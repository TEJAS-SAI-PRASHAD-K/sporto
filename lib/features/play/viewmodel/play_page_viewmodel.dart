import 'dart:async';
import 'package:flutter/material.dart';
import 'package:playo/features/play/model/menu_action.dart';
import 'package:playo/features/play/model/sub_tab.dart';
import 'package:playo/features/play/model/game.dart';
import 'package:playo/features/play/repository/games_remote_repository.dart';
import 'package:playo/features/play/mappers/game_mappers.dart';
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

  // Fake games data keyed by sport id
  final Map<String, List<Game>> _gamesBySport = {};

  // User created games and nearby games for Calendar tab
  List<Game>? _cachedUserCreatedGames;
  List<Game>? _cachedNearbyGames;
  List<Game>? _cachedPastUserCreatedGames;
  Map<String, String> _sportNames = const {}; // sport_id -> sport_name
  Map<String, String> _sportImages = const {}; // sport_id -> image_url

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
      // Seed fake data when entering My Sports for the first time
      if (_tabIndex == 1 && _gamesBySport.isEmpty) {
        _seedFakeGames();
      }
      // Ensure Calendar lists are up-to-date when switching to Calendar
      if (_tabIndex == 0) {
        unawaited(refreshUpcoming());
      }
      notifyListeners();
    }
  }

  void setSubTabIndex(int value) {
    if (_subTabIndex != value) {
      _subTabIndex = value;
      // Keep Calendar sub-tabs fresh (Upcoming/Past) when switching
      if (_tabIndex == 0) {
        unawaited(refreshUpcoming());
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
        return const [
          SubTab(
            id: 'badminton',
            label: 'Badminton',
            icon: Icons.sports_tennis,
          ),
          SubTab(id: 'swimming', label: 'Swimming', icon: Icons.pool),
          SubTab(id: 'running', label: 'Running', icon: Icons.directions_run),
          SubTab(id: 'cycling', label: 'Cycling', icon: Icons.directions_bike),
          SubTab(
            id: 'volleyball',
            label: 'Volleyball',
            icon: Icons.sports_volleyball,
          ),
        ];
      default: // Other Sports
        return const [
          SubTab(id: 'tennis', label: 'Tennis'),
          SubTab(id: 'football', label: 'Football'),
          SubTab(id: 'golf', label: 'Golf'),
        ];
    }
  }

  String get emptyTitle {
    if (_tabIndex == 0) {
      return _subTabIndex == 0 ? 'No Upcoming Games' : 'No Past Games';
    }
    // For other tabs, show sport specific empty text
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
          MenuAction(Icons.add, 'Create Game'),
          MenuAction(Icons.share, 'Share Calendar'),
          MenuAction(Icons.person_add_alt_1, 'Invite Playpals'),
          MenuAction(Icons.history, 'My Bookings'),
        ];
      }
      return _cachedPastActions ??= const [
        MenuAction(Icons.add, 'Create Game'),
        MenuAction(Icons.history, 'My Bookings'),
      ];
    }
    // Default actions for My Sports / Other Sports
    return _cachedDefaultActions ??= const [
      MenuAction(Icons.tune, 'Filter'),
      MenuAction(Icons.swap_vert, 'Sort'),
      MenuAction(Icons.history, 'My Bookings'),
    ];
  }

  String? get emptyImage => null;

  // Public getter for games shown under My Sports for the selected sport
  List<Game> get currentSportGames {
    if (_tabIndex != 1) return const [];
    final sportId = subTabs[_subTabIndex].id;
    return _gamesBySport[sportId] ?? const [];
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

  void _seedFakeGames() {
    DateTime now = DateTime.now();
    List<Game> sample(String sport, {bool booked = false}) => [
      Game(
        id: '${sport.toLowerCase()}-1',
        sport: sport,
        type: sport == 'Badminton' ? 'Doubles • Regular' : 'Regular',
        organizerName: 'Nagaraj Rao',
        startTime: now.add(const Duration(days: 1, hours: 17)),
        endTime: now.add(const Duration(days: 1, hours: 18)),
        venue: 'NRC $sport Arena,Basavanagudi',
        distanceKm: 2.93,
        goingCount: 2,
        capacity: sport == 'Badminton' ? 6 : 10,
        levelLabel: 'Intermediate - Professional',
        mustHaveSkill: true,
        booked: booked,
      ),
      Game(
        id: '${sport.toLowerCase()}-2',
        sport: sport,
        type: sport == 'Badminton' ? 'Doubles • Regular' : 'Regular',
        organizerName: 'Nagaraj Rao',
        startTime: now.add(const Duration(days: 1, hours: 16)),
        endTime: now.add(const Duration(days: 1, hours: 17)),
        venue: 'NRC $sport Arena,Basavanagudi',
        distanceKm: 2.93,
        goingCount: 2,
        capacity: sport == 'Badminton' ? 6 : 10,
        levelLabel: 'Intermediate - Professional',
        mustHaveSkill: true,
        booked: booked,
      ),
    ];

    _gamesBySport['badminton'] = sample('Badminton', booked: true);
    _gamesBySport['running'] = sample('Running');
    _gamesBySport['cycling'] = sample('Cycling');
    _gamesBySport['volleyball'] = sample('Volleyball');
    _gamesBySport['swimming'] = sample('Swimming');
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
      final res = await repo.listGames();
      res.match((_) {}, (list) {
        final nameResolver = (String id) => _sportNames[id] ?? id;
        final imageResolver = (String id) => _sportImages[id] ?? '';
        final supabase = getItSupabase();
        final currentUserId = supabase.auth.currentUser?.id;
        // Partition: user-created vs public nearby (others)
        final createdByMeUpcoming = <Game>[];
        final createdByMePast = <Game>[];
        final publicOthers = <Game>[];
        final cityLower = _selectedCity.toLowerCase();
        final now = DateTime.now();
        for (final g in list) {
          final ui = GameMappers.toUi(
            g,
            sportNameResolver: nameResolver,
            sportImageResolver: imageResolver,
          );
          final isMine = (g.organiserUserId == currentUserId);
          final isPublic = (g.gameAccessType ?? 'Public') == 'Public';
          if (isMine) {
            // Decide upcoming vs past using end time
            if (ui.endTime.isBefore(now)) {
              createdByMePast.add(ui);
            } else {
              createdByMeUpcoming.add(ui);
            }
          } else if (isPublic) {
            // Simple area/city filter for demo based on selected city string
            final place =
                ((g.venueAddress ?? g.venueName ?? g.areaOfGame) ?? '')
                    .toString()
                    .toLowerCase();
            if (place.contains(cityLower) || cityLower.isEmpty) {
              publicOthers.add(ui);
            }
          }
        }
        _cachedUserCreatedGames = createdByMeUpcoming;
        _cachedPastUserCreatedGames = createdByMePast;
        _cachedNearbyGames = publicOthers;
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
    } catch (_) {
      _sportNames = const {};
      _sportImages = const {};
    }
  }
}
