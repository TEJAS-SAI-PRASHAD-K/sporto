import 'package:flutter/material.dart';
import 'package:playo/features/play/model/menu_action.dart';
import 'package:playo/features/play/model/sub_tab.dart';
import 'package:playo/features/play/model/game.dart';

class PlayPageViewModel extends ChangeNotifier {
  int _tabIndex = 0;
  int _subTabIndex = 0;
  String _selectedCity = 'Bengaluru';

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
      notifyListeners();
    }
  }

  void setSubTabIndex(int value) {
    if (_subTabIndex != value) {
      _subTabIndex = value;
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

  List<Game> _getUserCreatedGames() {
    // Return user's created games - for now using Swimming games as example
    // To test empty state, you can return an empty list: return const [];
    DateTime now = DateTime.now();
    return [
      Game(
        id: 'user-swimming-1',
        sport: 'Swimming',
        type: 'Regular',
        organizerName: 'You',
        startTime: now.add(
          const Duration(days: 1, hours: 9),
        ), // Tomorrow morning
        endTime: now.add(const Duration(days: 1, hours: 10)),
        venue: 'Amaravati Sports Complex',
        distanceKm: 0.0,
        goingCount: 1,
        capacity: 8,
        levelLabel: 'All Levels',
        mustHaveSkill: false,
        booked: false,
      ),
    ];
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
    _cachedUpcomingActions = null;
    _cachedPastActions = null;
    _cachedDefaultActions = null;
    _cachedUserCreatedGames = null;
    _cachedNearbyGames = null;
    super.dispose();
  }
}
