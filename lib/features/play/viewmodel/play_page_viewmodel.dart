import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:playo/features/play/model/menu_action.dart';
import 'package:playo/features/play/model/sub_tab.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/features/play/model/game_ui_extensions.dart';
import 'package:playo/features/play/repository/games_remote_repository.dart';
import 'package:playo/features/play/model/sport_registry.dart';
import 'package:playo/init_dependecies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

SupabaseClient getItSupabase() => serviceLocator<SupabaseClient>();

class PlayPageViewModel extends ChangeNotifier {
  PlayPageViewModel();
  int _tabIndex = 0;
  int _subTabIndex = 0;
  String _selectedCity = 'Bengaluru';
  Timer? _rolloverTimer;

  // Available cities list
  final List<String> _availableCities = [
    'Amaravati',
    'Hyderabad',
    'Bengaluru',
    'Chennai',
    'Mumbai',
    'Delhi',
    'Pune',
    'Kolkata',
  ];

  List<MenuAction>? _cachedUpcomingActions;
  List<MenuAction>? _cachedPastActions;
  List<MenuAction>? _cachedDefaultActions;

  // Stable ids for menu actions
  static const String actCreateGame = 'create_game';
  static const String actShareCalendar = 'share_calendar';
  static const String actInvitePlaypals = 'invite_playpals';
  static const String actMyBookings = 'my_bookings';
  static const String actFilter = 'filter';
  static const String actSort = 'sort';

  // Fake games data keyed by sport id
  final Map<String, List<Game>> _gamesBySport = {};

  // User created games and nearby games for Calendar tab
  List<Game>? _cachedUserCreatedGames;
  List<Game>? _cachedNearbyGames;
  List<Game>? _cachedPastUserCreatedGames;
  Map<String, String> _sportNames = const {}; // sport_id -> sport_name
  Map<String, String> _sportImages = const {}; // sport_id -> image_url
  List<SubTab> _mySportsTabs = const [];
  List<SubTab> _otherSportsTabs = const [];

  // Getters
  int get tabIndex => _tabIndex;
  int get subTabIndex => _subTabIndex;
  String get selectedCity => _selectedCity;
  List<String> get availableCities => List.unmodifiable(_availableCities);

  // Tab selection methods
  void setTabIndex(int value) {
    if (_tabIndex != value) {
      _tabIndex = value;
      // Reset sub tab selection when switching main tab
      _subTabIndex = 0;
      // Load sub-tabs (favorites/others) and sport-specific games when entering My Sports or Other Sports
      if (_tabIndex != 0) {
        unawaited(_refreshSubTabs());
        unawaited(refreshCurrentSportGames());
      }
      // Ensure Calendar lists are up-to-date when switching to Calendar
      if (_tabIndex == 0) {
        unawaited(refreshUpcoming());
      }
      notifyListeners();
    }
  }

  void setSubTabIndex(int value) {
    // Bound check based on current tab's items
    final items = subTabs;
    if (value < 0 || value >= items.length) return;
    if (_subTabIndex != value) {
      _subTabIndex = value;
      // Keep Calendar sub-tabs fresh (Upcoming/Past) when switching
      if (_tabIndex == 0) {
        unawaited(refreshUpcoming());
      } else {
        // When switching sports within My Sports/Other Sports, refresh that sport's games
        unawaited(refreshCurrentSportGames());
      }
      notifyListeners();
    }
  }

  // City selection method
  void setSelectedCity(String city) {
    if (_selectedCity != city && _availableCities.contains(city)) {
      _selectedCity = city;
      notifyListeners();

      // Clear cached actions when city changes as games might be different
      _cachedUpcomingActions = null;
      _cachedPastActions = null;
      _cachedUserCreatedGames = null;
      _cachedNearbyGames = null;

      // Refresh current lists affected by city
      if (_tabIndex == 0) {
        unawaited(refreshUpcoming());
      } else {
        unawaited(refreshCurrentSportGames());
      }
    }
  }

  // Check if a city is available
  bool isCityAvailable(String city) {
    return _availableCities.contains(city);
  }

  // Sub tabs vary by main tab
  List<SubTab> get subTabs {
    switch (_tabIndex) {
      case 0: // Calendar
        return const [
          SubTab(id: 'upcoming', label: 'Upcoming'),
          SubTab(id: 'past', label: 'Past'),
        ];
      case 1: // My Sports
        return _mySportsTabs;
      default: // Other Sports
        return _otherSportsTabs;
    }
  }

  String get emptyTitle {
    if (_tabIndex == 0) {
      return _subTabIndex == 0 ? 'No Upcoming Games' : 'No Past Games';
    }
    // For other tabs, show sport specific empty text
    // Guard against empty sub-tabs list while async loading favorites/others
    if (subTabs.isEmpty) {
      return 'No games nearby';
    }
    final sportLabel = subTabs[_subTabIndex].label;
    return 'No $sportLabel games nearby';
  }

  String get buttonLabel {
    if (_tabIndex == 0) {
      return _subTabIndex == 0 ? 'SEE GAMES' : '';
    }
    return 'SEE GAMES';
  }

  List<MenuAction> get menuActions {
    if (_tabIndex == 0) {
      // Calendar actions differ for upcoming vs past
      if (_subTabIndex == 0) {
        return _cachedUpcomingActions ??= const [
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
      return _cachedPastActions ??= const [
        MenuAction(Icons.add, 'Create Game', id: actCreateGame),
        MenuAction(Icons.history, 'My Bookings', id: actMyBookings),
      ];
    }
    // Default actions for My Sports / Other Sports
    return _cachedDefaultActions ??= const [
      MenuAction(Icons.tune, 'Filter', id: actFilter),
      MenuAction(Icons.swap_vert, 'Sort', id: actSort),
      MenuAction(Icons.history, 'My Bookings', id: actMyBookings),
    ];
  }

  String? get emptyImage => null;

  // Public getter for games shown under My Sports for the selected sport
  List<Game> get currentSportGames {
    if (_tabIndex == 0) return const [];
    if (subTabs.isEmpty) return const [];
    final sportId = subTabs[_subTabIndex].id;
    return _gamesBySport.putIfAbsent(sportId, () => <Game>[]);
  }

  // Public getters for Calendar tab
  List<Game> get userCreatedGames {
    if (_tabIndex != 0) return const [];
    return _cachedUserCreatedGames ??= _getUserCreatedGames();
  }

  List<Game> get nearbyGames {
    if (_tabIndex != 0) return const [];
    return _cachedNearbyGames ??= _getNearbyGames();
  }

  List<Game> get pastUserCreatedGames {
    if (_tabIndex != 0) return const [];
    return _cachedPastUserCreatedGames ?? const [];
  }

  List<Game> _getUserCreatedGames() {
    // Synchronous cache; ensure async refresh elsewhere
    return _cachedUserCreatedGames ?? const [];
  }

  List<Game> _getNearbyGames() {
    // Return nearby games - can be empty for now
    return const [];
  }

  // Fetch and cache public games for the current sport tab (My Sports)
  Future<void> refreshCurrentSportGames() async {
    if (_tabIndex == 0) return;
    try {
      await _ensureSportsLoaded();
      final repo = GamesRemoteRepository(getItSupabase());
      final supabase = getItSupabase();
      final currentUserId = supabase.auth.currentUser?.id;
      if (subTabs.isEmpty) return;
      final sportTabKey = subTabs[_subTabIndex].id; // current sport key
      final resolvedSportId = _resolveSportIdForCurrentSubTab();
      // If we cannot resolve any sport mapping yet, clear list and show empty state
      if (resolvedSportId.isEmpty && _sportNames.isEmpty) {
        _gamesBySport[sportTabKey] = <Game>[];
        notifyListeners();
        return;
      }
      final sportIdForQuery =
          (resolvedSportId.isNotEmpty && _isUuid(resolvedSportId))
          ? resolvedSportId
          : null;
      final now = DateTime.now();
      final res = await repo.listGames(
        sportId: sportIdForQuery,
        fromDate: DateTime(now.year, now.month, now.day),
        limit: 100,
      );
      res.match((_) {}, (list) async {
        final cityLower = _selectedCity.toLowerCase();
        final labelLc = subTabs[_subTabIndex].label.toLowerCase();
        final filtered = list.where((g) {
          final isMine = (g.organiserUserId == currentUserId);
          final isPublic = (g.gameAccessType ?? 'Public') == 'Public';
          if (isMine || !isPublic) return false;
          // Ensure sport match: if we didn't filter by sport_id at DB, match by resolved sport name
          if (sportIdForQuery == null) {
            final sportName = SportRegistry.nameFor(g.sportId).toLowerCase();
            if (sportName != labelLc) return false;
          }
          // City/area match – relax this to avoid over-filtering by text
          // If your schema has a city column, prefer filtering in SQL.
          // Here we only exclude if a different city name is explicitly present.
          final place = ((g.venueAddress ?? g.venueName ?? g.areaOfGame) ?? '')
              .toString()
              .toLowerCase();
          if (place.isNotEmpty && cityLower.isNotEmpty) {
            final hasSomeCity = _availableCities
                .map((e) => e.toLowerCase())
                .any((c) => place.contains(c));
            if (hasSomeCity && !place.contains(cityLower)) return false;
          }
          // upcoming only
          if (g.endTime.isBefore(now)) return false;
          return true;
        }).toList()..sort((a, b) => a.startTime.compareTo(b.startTime));
        _gamesBySport[sportTabKey] = filtered;
        notifyListeners();
      });
    } catch (_) {}
  }

  // Try to map sub-tab to the correct sport_id used in DB
  String _resolveSportIdForCurrentSubTab() {
    final sub = subTabs[_subTabIndex];
    final labelLc = sub.label.toLowerCase();
    final idLc = sub.id.toLowerCase();
    // exact match by name -> id
    final byName = _sportNames.entries.firstWhere(
      (e) => (e.value.toLowerCase() == labelLc),
      orElse: () => const MapEntry('', ''),
    );
    if (byName.key.isNotEmpty) return byName.key;
    // match by id directly
    if (_sportNames.containsKey(sub.id)) return sub.id;
    // try case-insensitive id match
    final byIdInsensitive = _sportNames.keys.firstWhere(
      (k) => k.toLowerCase() == idLc,
      orElse: () => '',
    );
    if (byIdInsensitive.isNotEmpty) return byIdInsensitive;
    // No valid mapping found
    return '';
  }

  bool _isUuid(String s) {
    final re = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12} ?$',
    );
    return re.hasMatch(s);
  }

  @override
  void dispose() {
    _rolloverTimer?.cancel();
    _cachedUpcomingActions = null;
    _cachedPastActions = null;
    _cachedDefaultActions = null;
    _cachedUserCreatedGames = null;
    _cachedNearbyGames = null;
    super.dispose();
  }

  // Public method to refresh upcoming from Supabase
  Future<void> refreshUpcoming() async {
    try {
      final repo = GamesRemoteRepository(getItSupabase());
      await _ensureSportsLoaded();
      // Fetch all games and partition locally into upcoming vs past
      final today = DateTime.now();
      final res = await repo.listGames(
        fromDate: DateTime(today.year, today.month, today.day),
      );
      await res.match((_) async {}, (list) async {
        final supabase = getItSupabase();
        final currentUserId = supabase.auth.currentUser?.id;
        // Partition: user-created vs public nearby (others)
        final createdByMeUpcoming = <Game>[];
        final createdByMePast = <Game>[];
        final publicOthers = <Game>[];
        final cityLower = _selectedCity.toLowerCase();
        final now = DateTime.now();
        for (final g in list) {
          final isMine = (g.organiserUserId == currentUserId);
          final isPublic = (g.gameAccessType ?? 'Public') == 'Public';
          // Update sport registry for name/image resolution
          // (resolution can be used by UI widgets if needed)
          // nameResolver and imageResolver are used via SportRegistry below
          if (isMine) {
            if (g.endTime.isBefore(now)) {
              createdByMePast.add(g);
            } else {
              createdByMeUpcoming.add(g);
            }
          } else if (isPublic) {
            final place =
                ((g.venueAddress ?? g.venueName ?? g.areaOfGame) ?? '')
                    .toString()
                    .toLowerCase();
            if (cityLower.isEmpty) {
              publicOthers.add(g);
            } else {
              // Relax text city filter similar to sports tabs
              final hasSomeCity = _availableCities
                  .map((e) => e.toLowerCase())
                  .any((c) => place.contains(c));
              if (!hasSomeCity || place.contains(cityLower)) {
                publicOthers.add(g);
              }
            }
          }
        }
        _cachedUserCreatedGames = createdByMeUpcoming;
        _cachedPastUserCreatedGames = createdByMePast;
        // Only show in Calendar's nearby list games where the current user has an accepted participation (Joined)
        final acceptedGameIds = <String>{};
        try {
          if (currentUserId != null && publicOthers.isNotEmpty) {
            final ids = publicOthers.map((g) => g.gameId).toList();
            // Build SQL IN list: in.("id1","id2",...)
            final quoted = ids.map((e) => '"' + e + '"').join(',');
            final inList = '($quoted)';
            final rows = await supabase
                .from('games_participants')
                .select('game_id, participation_status')
                .eq('user_id', currentUserId)
                .filter('game_id', 'in', inList);
            for (final row in (rows as List)) {
              if ((row['participation_status'] as String?) == 'Joined') {
                final gid = row['game_id'] as String?;
                if (gid != null) acceptedGameIds.add(gid);
              }
            }
          }
        } catch (_) {}
        _cachedNearbyGames = publicOthers
            .where((g) => acceptedGameIds.contains(g.gameId))
            .toList();
        _scheduleNextRollover(createdByMeUpcoming);
        notifyListeners();
      });
    } catch (_) {}
  }

  void _scheduleNextRollover(List<Game> upcomingMine) {
    // Cancel any previous timer
    _rolloverTimer?.cancel();
    if (upcomingMine.isEmpty) return;
    // Find the earliest end time in future
    final now = DateTime.now();
    final futureEnds =
        upcomingMine.map((g) => g.endTime).where((t) => t.isAfter(now)).toList()
          ..sort();
    if (futureEnds.isEmpty) return;
    final next = futureEnds.first;
    final delay = next.difference(now) + const Duration(seconds: 1);
    _rolloverTimer = Timer(delay, () {
      // When the earliest upcoming game ends, refresh to move it to Past
      unawaited(refreshUpcoming());
    });
  }

  Future<void> _ensureSportsLoaded() async {
    if (_sportNames.isNotEmpty && _sportImages.isNotEmpty) return;
    try {
      final supabase = getItSupabase();
      final response = await supabase
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
      // expose for UI extensions
      SportRegistry.setNames(_sportNames);
      SportRegistry.setImages(_sportImages);
    } catch (_) {
      _sportNames = const {};
      _sportImages = const {};
    }
  }

  Future<void> _refreshSubTabs() async {
    try {
      await _ensureSportsLoaded();
      final supabase = getItSupabase();
      final userId = supabase.auth.currentUser?.id;
      List<String> favoriteIds = const [];
      if (userId != null) {
        try {
          final resp = await supabase
              .from('users')
              .select('favorite_sports')
              .eq('user_id', userId)
              .single();
          final fav = resp['favorite_sports'];
          // Accept array, JSON string, or comma-separated string
          List<String> rawValues = const [];
          if (fav is List) {
            rawValues = fav
                .cast<dynamic>()
                .map((e) => e?.toString() ?? '')
                .where((e) => e.isNotEmpty)
                .toList();
          } else if (fav is String) {
            final s = fav.trim();
            if (s.startsWith('[') && s.endsWith(']')) {
              try {
                final decoded = (jsonDecode(s) as List)
                    .map((e) => e?.toString() ?? '')
                    .where((e) => e.isNotEmpty)
                    .toList();
                rawValues = decoded;
              } catch (_) {
                rawValues = s
                    .split(',')
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList();
              }
            } else {
              rawValues = s
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
            }
          }
          // Normalize entries: accept sport UUIDs or sport names -> map to UUIDs
          if (rawValues.isNotEmpty) {
            final nameToId = <String, String>{
              for (final entry in _sportNames.entries)
                entry.value.toLowerCase(): entry.key,
            };
            final normalized = <String>{};
            for (final v in rawValues) {
              final val = v.trim();
              if (val.isEmpty) continue;
              if (_sportNames.containsKey(val)) {
                normalized.add(val);
              } else {
                final mapped = nameToId[val.toLowerCase()];
                if (mapped != null) normalized.add(mapped);
              }
            }
            favoriteIds = normalized.toList();
          }
        } catch (_) {}
      }
      // Build all active sports sorted by name
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
      // Keep subTabIndex valid for current tab
      if (subTabs.isEmpty) {
        _subTabIndex = 0;
      } else if (_subTabIndex >= subTabs.length) {
        _subTabIndex = 0;
      }
      notifyListeners();
      // If we're on a sports tab and items are now present, fetch games for the current sub-tab
      if (_tabIndex != 0 && subTabs.isNotEmpty) {
        unawaited(refreshCurrentSportGames());
      }
    } catch (_) {}
  }
}
