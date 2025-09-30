import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:playo/core/models/game.dart';
import 'package:playo/core/error/failure.dart';
import 'package:playo/init_dependecies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../repository/games_remote_repository.dart';
import 'package:playo/features/play/model/sub_tab.dart';
import 'package:playo/features/play/model/menu_action.dart';
import 'package:playo/features/play/model/sport_registry.dart';

part 'game_view_model.g.dart';

// Helper mapping utilities formerly embedded in repository logic

@riverpod
class GameViewModel extends _$GameViewModel {
  static const _uuid = Uuid();

  GamesRemoteRepository get _repo => ref.read(gamesRemoteRepositoryProvider);
  SupabaseClient get _supabase => serviceLocator<SupabaseClient>();

  // -------------------- Play Page (Calendar / Tabs) State --------------------
  int _mainTabIndex = 0; // 0 Calendar, 1 My Sports, 2 Other Sports
  int _subTabIndex = 0; // Depends on main tab
  String _selectedCity = 'Bengaluru';
  Timer? _rolloverTimer;

  final List<String> _availableCities = const [
    'Amaravati',
    'Hyderabad',
    'Bengaluru',
    'Chennai',
    'Mumbai',
    'Delhi',
    'Pune',
    'Kolkata',
  ];

  // Cached data
  final Map<String, List<Game>> _gamesBySport = {}; // sportId -> games
  List<Game> _userCreatedUpcoming = const [];
  List<Game> _userCreatedPast = const [];
  List<Game> _nearbyAccepted = const [];

  Map<String, String> _sportNames = const {}; // sport_id -> sport_name
  Map<String, String> _sportImages = const {}; // sport_id -> image_url
  List<SubTab> _mySportsTabs = const [];
  List<SubTab> _otherSportsTabs = const [];

  // Stable ids for menu actions (reusing PlayPageViewModel semantics)
  static const String actCreateGame = 'create_game';
  static const String actShareCalendar = 'share_calendar';
  static const String actInvitePlaypals = 'invite_playpals';
  static const String actMyBookings = 'my_bookings';
  static const String actFilter = 'filter';
  static const String actSort = 'sort';

  // Public getters -----------------------------------------------------------
  int get tabIndex => _mainTabIndex;
  int get subTabIndex => _subTabIndex;
  String get selectedCity => _selectedCity;
  List<String> get availableCities => _availableCities;

  List<SubTab> get subTabs {
    switch (_mainTabIndex) {
      case 0:
        return const [
          SubTab(id: 'upcoming', label: 'Upcoming'),
          SubTab(id: 'past', label: 'Past'),
        ];
      case 1:
        return _mySportsTabs;
      default:
        return _otherSportsTabs;
    }
  }

  List<Game> get userCreatedUpcomingGames =>
      _mainTabIndex == 0 ? _userCreatedUpcoming : const [];
  List<Game> get pastUserCreatedGames =>
      _mainTabIndex == 0 ? _userCreatedPast : const [];
  List<Game> get nearbyAcceptedGames =>
      _mainTabIndex == 0 ? _nearbyAccepted : const [];

  List<Game> get currentSportGames {
    if (_mainTabIndex == 0) return const [];
    if (subTabs.isEmpty) return const [];
    final sportId = subTabs[_subTabIndex].id;
    return _gamesBySport[sportId] ?? const [];
  }

  String get emptyTitle {
    if (_mainTabIndex == 0) {
      return _subTabIndex == 0 ? 'No Upcoming Games' : 'No Past Games';
    }
    if (subTabs.isEmpty) return 'No games nearby';
    final sportLabel = subTabs[_subTabIndex].label;
    return 'No $sportLabel games nearby';
  }

  List<MenuAction> get menuActions {
    if (_mainTabIndex == 0) {
      if (_subTabIndex == 0) {
        return const [
          MenuAction(Icons.add, 'Create Game', id: actCreateGame),
          MenuAction(Icons.share, 'Share Calendar', id: actShareCalendar),
          MenuAction(
            Icons.person_add_alt_1,
            'Invite Playpals',
            id: actInvitePlaypals,
          ),
          MenuAction(Icons.history, 'My Bookings', id: actMyBookings),
        ];
      }
      return const [
        MenuAction(Icons.add, 'Create Game', id: actCreateGame),
        MenuAction(Icons.history, 'My Bookings', id: actMyBookings),
      ];
    }
    return const [
      MenuAction(Icons.tune, 'Filter', id: actFilter),
      MenuAction(Icons.swap_vert, 'Sort', id: actSort),
      MenuAction(Icons.history, 'My Bookings', id: actMyBookings),
    ];
  }

  // Tab & city setters -------------------------------------------------------
  void setTabIndex(int value) {
    if (_mainTabIndex == value) return;
    _mainTabIndex = value;
    _subTabIndex = 0; // reset
    if (_mainTabIndex == 0) {
      unawaited(refreshUpcoming());
    } else {
      unawaited(
        _ensureSportsLoaded().then((_) async {
          await _refreshSportsTabs();
          await refreshCurrentSportGames();
        }),
      );
    }
    _touch();
  }

  void setSubTabIndex(int value) {
    final tabs = subTabs;
    if (value < 0 || value >= tabs.length) return;
    if (_subTabIndex == value) return;
    _subTabIndex = value;
    if (_mainTabIndex == 0) {
      unawaited(refreshUpcoming());
    } else {
      unawaited(refreshCurrentSportGames());
    }
    _touch();
  }

  void setSelectedCity(String city) {
    if (city == _selectedCity || !_availableCities.contains(city)) return;
    _selectedCity = city;
    if (_mainTabIndex == 0) {
      unawaited(refreshUpcoming());
    } else {
      unawaited(refreshCurrentSportGames());
    }
    _touch();
  }

  // Core refresh methods -----------------------------------------------------
  Future<void> refreshUpcoming() async {
    try {
      await _ensureSportsLoaded();
      final res = await _repo.listGames(fromDate: DateTime.now());
      await res.match((_) async {}, (list) async {
        final currentUserId = _supabase.auth.currentUser?.id;
        final now = DateTime.now();
        final createdUpcoming = <Game>[];
        final createdPast = <Game>[];
        final publicOthers = <Game>[];
        for (final g in list) {
          final start = _composeStart(g);
          final end = start.add(const Duration(hours: 2)); // assume duration
          final isMine = g.organiserUserId == currentUserId;
          if (isMine) {
            if (end.isBefore(now)) {
              createdPast.add(g);
            } else {
              createdUpcoming.add(g);
            }
          } else if ((g.gameAccessType ?? 'Public') == 'Public') {
            if (end.isAfter(now)) publicOthers.add(g);
          }
        }
        _userCreatedUpcoming = createdUpcoming
          ..sort((a, b) => _composeStart(a).compareTo(_composeStart(b)));
        _userCreatedPast = createdPast
          ..sort((a, b) => _composeStart(b).compareTo(_composeStart(a)));
        // Filter publicOthers to ones user has a participation (Joined)
        final accepted = <String>{};
        try {
          if (currentUserId != null && publicOthers.isNotEmpty) {
            final ids = publicOthers.map((g) => g.gameId).toList();
            final quoted = ids.map((e) => '"$e"').join(',');
            final inList = '($quoted)';
            final rows = await _supabase
                .from('games_participants')
                .select('game_id, participation_status')
                .eq('user_id', currentUserId)
                .filter('game_id', 'in', inList);
            for (final row in (rows as List)) {
              if ((row['participation_status'] as String?) == 'Joined') {
                accepted.add(row['game_id'] as String);
              }
            }
          }
        } catch (_) {}
        _nearbyAccepted =
            publicOthers.where((g) => accepted.contains(g.gameId)).toList()
              ..sort((a, b) => _composeStart(a).compareTo(_composeStart(b)));
        _scheduleNextRollover();
        _touch();
      });
    } catch (_) {}
  }

  Future<void> refreshCurrentSportGames() async {
    if (_mainTabIndex == 0) return;
    try {
      await _ensureSportsLoaded();
      if (subTabs.isEmpty) return;
      final sportId = subTabs[_subTabIndex].id; // already a sport id (UUID)
      final now = DateTime.now();
      final res = await _repo.listGames(
        sportId: _isUuid(sportId) ? sportId : null,
        fromDate: DateTime(now.year, now.month, now.day),
        limit: 100,
      );
      res.match((_) {}, (list) {
        final currentUserId = _supabase.auth.currentUser?.id;
        final filtered = list.where(
          (g) {
            if (g.organiserUserId == currentUserId) return false; // others only
            if ((g.gameAccessType ?? 'Public') != 'Public') return false;
            final start = _composeStart(g);
            final end = start.add(const Duration(hours: 2));
            if (end.isBefore(now)) return false;
            // If we did not filter by sportId, match by sport name vs tab label
            if (!_isUuid(sportId)) {
              final labelLc = subTabs[_subTabIndex].label.toLowerCase();
              final sportName = SportRegistry.nameFor(g.sportId).toLowerCase();
              if (sportName != labelLc) return false;
            }
            return true;
          },
        ).toList()..sort((a, b) => _composeStart(a).compareTo(_composeStart(b)));
        _gamesBySport[sportId] = filtered;
        _touch();
      });
    } catch (_) {}
  }

  Future<void> _refreshSportsTabs() async {
    try {
      await _ensureSportsLoaded();
      final supabase = _supabase;
      final userId = supabase.auth.currentUser?.id;
      List<String> favoriteIds = const [];
      if (userId != null) {
        try {
          final resp = await supabase
              .from('users')
              .select('favorite_sports')
              .eq('user_id', userId)
              .maybeSingle();
          final fav = resp?['favorite_sports'];
          List<String> rawValues = const [];
          if (fav is List) {
            rawValues = fav.cast();
          } else if (fav is String) {
            try {
              final decoded = jsonDecode(fav);
              if (decoded is List) rawValues = decoded.cast();
            } catch (_) {
              rawValues = fav
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
            }
          }
          if (rawValues.isNotEmpty) {
            // Map sport names to ids when needed
            final mapped = <String>[];
            for (final v in rawValues) {
              if (_sportNames.containsKey(v)) {
                mapped.add(v); // already id
              } else {
                final byName = _sportNames.entries.firstWhere(
                  (e) => e.value.toLowerCase() == v.toLowerCase(),
                  orElse: () => const MapEntry('', ''),
                );
                if (byName.key.isNotEmpty) mapped.add(byName.key);
              }
            }
            favoriteIds = mapped;
          }
        } catch (_) {}
      }
      final all =
          _sportNames.entries.map((e) => MapEntry(e.key, e.value)).toList()
            ..sort(
              (a, b) => a.value.toLowerCase().compareTo(b.value.toLowerCase()),
            );
      final favSet = favoriteIds.toSet();
      final my = all.where((e) => favSet.contains(e.key)).toList();
      final others = all.where((e) => !favSet.contains(e.key)).toList();
      _mySportsTabs = [for (final e in my) SubTab(id: e.key, label: e.value)];
      _otherSportsTabs = [
        for (final e in others) SubTab(id: e.key, label: e.value),
      ];
      if (subTabs.isEmpty) {
        _subTabIndex = 0;
      } else if (_subTabIndex >= subTabs.length) {
        _subTabIndex = 0;
      }
      _touch();
    } catch (_) {}
  }

  Future<void> _ensureSportsLoaded() async {
    if (_sportNames.isNotEmpty && _sportImages.isNotEmpty) return;
    try {
      final response = await _supabase
          .from('sports')
          .select('sport_id, sport_name, image_url')
          .eq('is_sport_active', true);
      final list = (response as List).cast<Map<String, dynamic>>();
      _sportNames = {
        for (final row in list)
          row['sport_id'] as String: (row['sport_name'] as String),
      };
      _sportImages = {
        for (final row in list)
          row['sport_id'] as String: (row['image_url'] as String?) ?? '',
      };
      SportRegistry.setNames(_sportNames);
      SportRegistry.setImages(_sportImages);
    } catch (_) {
      _sportNames = const {};
      _sportImages = const {};
    }
  }

  bool _isUuid(String s) {
    final re = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12} ?$',
    );
    return re.hasMatch(s);
  }

  void _scheduleNextRollover() {
    _rolloverTimer?.cancel();
    if (_userCreatedUpcoming.isEmpty) return;
    final now = DateTime.now();
    final futureEnds =
        _userCreatedUpcoming
            .map((g) => _composeStart(g).add(const Duration(hours: 2)))
            .where((t) => t.isAfter(now))
            .toList()
          ..sort();
    if (futureEnds.isEmpty) return;
    final next = futureEnds.first;
    final delay = next.difference(now) + const Duration(seconds: 1);
    _rolloverTimer = Timer(delay, () {
      unawaited(refreshUpcoming());
    });
  }

  void _touch() {
    // Emit a benign AsyncData to trigger UI rebuilds
    state = const AsyncData(null);
  }

  DateTime _composeStart(Game g) {
    // gameDate (date only) + gameTime (HH:mm:ss) -> DateTime
    final date = g.gameDate ?? g.createdAt ?? DateTime.now();
    final time = (g.gameTime ?? '00:00:00').split(':');
    final h = int.tryParse(time.elementAt(0)) ?? 0;
    final m = int.tryParse(time.elementAt(1)) ?? 0;
    final s = int.tryParse(time.elementAt(2)) ?? 0;
    return DateTime(date.year, date.month, date.day, h, m, s);
  }

  @override
  @override
  AsyncValue<void> build() => const AsyncData(null);

  // -------------------- Game CRUD --------------------
  Future<AsyncValue<Game>> createGame({
    required String sportId,
    required String? area,
    required DateTime gameDate,
    required String gameTime, // HH:mm:ss
    required bool isPublic,
    required Map<String, dynamic> rules,
    String? notes,
  }) async {
    state = const AsyncLoading();
    final currentUserId = _supabase.auth.currentUser?.id;
    if (currentUserId == null) {
      final failure = Failure('Not authenticated');
      state = AsyncError(failure, StackTrace.current);
      return AsyncError(failure, StackTrace.current);
    }
    final game = Game(
      gameId: _uuid.v4(),
      organiserUserId: currentUserId,
      sportId: sportId,
      areaOfGame: area,
      gameDate: DateTime(gameDate.year, gameDate.month, gameDate.day),
      gameTime: gameTime,
      gameAccessType: isPublic ? 'Public' : 'Invite Only',
      currentPlayersCount: 1,
      venueName: area,
      venueAddress: area,
      playerIds: [currentUserId],
      waitlistUserIds: const [],
      gameRules: jsonEncode(rules),
      requiresApproval: !isPublic,
      notes: notes?.trim().isEmpty == true ? null : notes?.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final res = await _repo.createGame(game);
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (r) {
        state = const AsyncData(null);
        return AsyncData(r);
      },
    );
  }

  Future<AsyncValue<Game>> patchGame(
    String gameId,
    Map<String, dynamic> updates,
  ) async {
    state = const AsyncLoading();
    final res = await _repo.patchGame(gameId, updates);
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (r) {
        state = const AsyncData(null);
        return AsyncData(r);
      },
    );
  }

  Future<AsyncValue<void>> deleteGame(String gameId) async {
    state = const AsyncLoading();
    final res = await _repo.deleteGame(gameId);
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (_) {
        state = const AsyncData(null);
        return const AsyncData(null);
      },
    );
  }

  // -------------------- Participation --------------------
  Future<AsyncValue<GameParticipation>> joinGame({
    required String gameId,
    bool organiser = false,
  }) async {
    state = const AsyncLoading();
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      final failure = Failure('Not authenticated');
      state = AsyncError(failure, StackTrace.current);
      return AsyncError(failure, StackTrace.current);
    }
    final payload = GameParticipation(
      participationId: _uuid.v4(),
      gameId: gameId,
      userId: userId,
      participationStatus: 'Joined',
      joinedAt: DateTime.now(),
      isOrganiser: organiser,
      hasPaid: false,
    ).toJson();
    final res = await _repo.insertGameParticipation(payload);
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (r) {
        state = const AsyncData(null);
        return AsyncData(r);
      },
    );
  }

  Future<AsyncValue<GameParticipation>> requestToJoinGame(String gameId) async {
    state = const AsyncLoading();
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      final failure = Failure('Not authenticated');
      state = AsyncError(failure, StackTrace.current);
      return AsyncError(failure, StackTrace.current);
    }
    final payload = GameParticipation(
      participationId: _uuid.v4(),
      gameId: gameId,
      userId: userId,
      participationStatus: 'Pending',
      joinedAt: DateTime.now(),
      isOrganiser: false,
      hasPaid: false,
    ).toJson();
    final res = await _repo.insertGameParticipation(payload);
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (r) {
        state = const AsyncData(null);
        return AsyncData(r);
      },
    );
  }

  Future<AsyncValue<GameParticipation>> acceptJoinRequest(
    String participationId,
  ) async {
    state = const AsyncLoading();
    final res = await _repo.updateGameParticipation(participationId, {
      'participation_status': 'Joined',
      'responded_at': DateTime.now().toIso8601String(),
    });
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (r) {
        state = const AsyncData(null);
        return AsyncData(r);
      },
    );
  }

  Future<AsyncValue<void>> leaveGame(String participationId) async {
    state = const AsyncLoading();
    final res = await _repo.cancelParticipation(participationId);
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (_) {
        state = const AsyncData(null);
        return const AsyncData(null);
      },
    );
  }

  Future<AsyncValue<List<GameParticipation>>> listParticipants(
    String gameId,
  ) async {
    state = const AsyncLoading();
    final res = await _repo.listParticipationsForGame(gameId);
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (r) {
        state = const AsyncData(null);
        return AsyncData(r);
      },
    );
  }

  /// Convenience: returns the current user's participation (if any) for a game.
  Future<AsyncValue<GameParticipation?>> myParticipation(String gameId) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId == null) {
      final failure = Failure('Not authenticated');
      return AsyncError(failure, StackTrace.current);
    }
    final listAv = await listParticipants(gameId);
    return listAv.when(
      data: (list) {
        final found = list.firstWhere(
          (p) => p.userId == userId,
          orElse: () => GameParticipation(
            participationId: '',
            gameId: gameId,
            userId: userId,
            participationStatus: null,
            joinedAt: null,
          ),
        );
        if (found.participationId.isEmpty) return const AsyncData(null);
        return AsyncData(found);
      },
      error: (e, st) => AsyncError(e, st),
      loading: () => const AsyncLoading(),
    );
  }

  /// Groups participants by their participation_status. Keys: Pending, Joined, Waitlisted, Cancelled.
  Future<AsyncValue<Map<String, List<GameParticipation>>>> participantsByStatus(
    String gameId,
  ) async {
    final listAv = await listParticipants(gameId);
    return listAv.when(
      data: (list) {
        final map = <String, List<GameParticipation>>{};
        for (final p in list) {
          final key = (p.participationStatus ?? 'Unknown');
          final bucket = map.putIfAbsent(key, () => <GameParticipation>[]);
          bucket.add(p);
        }
        return AsyncData(map);
      },
      error: (e, st) => AsyncError(e, st),
      loading: () => const AsyncLoading(),
    );
  }

  // -------------------- Invites --------------------
  Future<AsyncValue<GameInvite>> sendInvite({
    required String gameId,
    required String inviteeUserId,
  }) async {
    state = const AsyncLoading();
    final inviterUserId = _supabase.auth.currentUser?.id;
    if (inviterUserId == null) {
      final failure = Failure('Not authenticated');
      state = AsyncError(failure, StackTrace.current);
      return AsyncError(failure, StackTrace.current);
    }
    final payload = GameInvite(
      inviteId: _uuid.v4(),
      gameId: gameId,
      inviterUserId: inviterUserId,
      inviteeUserId: inviteeUserId,
      inviteStatus: 'Pending',
      sentAt: DateTime.now(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ).toJson();
    final res = await _repo.insertGameInvite(payload);
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (r) {
        state = const AsyncData(null);
        return AsyncData(r);
      },
    );
  }

  Future<AsyncValue<List<GameInvite>>> listInvitesForUser(String userId) async {
    state = const AsyncLoading();
    final res = await _repo.fetchInvitesForUser(userId);
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (r) {
        state = const AsyncData(null);
        return AsyncData(r);
      },
    );
  }

  Future<AsyncValue<GameInvite>> updateInviteStatus({
    required String inviteId,
    required String status,
  }) async {
    state = const AsyncLoading();
    final res = await _repo.updateGameInviteStatus(
      inviteId: inviteId,
      status: status,
    );
    return res.match(
      (l) {
        state = AsyncError(l, StackTrace.current);
        return AsyncError(l, StackTrace.current);
      },
      (r) {
        state = const AsyncData(null);
        return AsyncData(r);
      },
    );
  }
}
