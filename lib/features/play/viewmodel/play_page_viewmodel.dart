import 'package:flutter/material.dart';
import 'package:playo/features/play/model/menu_action.dart';

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

  // Getters
  int get tabIndex => _tabIndex;
  int get subTabIndex => _subTabIndex;
  String get selectedCity => _selectedCity;
  List<String> get availableCities => List.unmodifiable(_availableCities);

  // Tab selection methods
  void setTabIndex(int value) {
    if (_tabIndex != value) {
      _tabIndex = value;
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
    }
  }

  // Check if a city is available
  bool isCityAvailable(String city) {
    return _availableCities.contains(city);
  }

  String get emptyTitle =>
      _subTabIndex == 0 ? 'No Upcoming Games' : 'No Past Games';

  String get buttonLabel => _subTabIndex == 0 ? 'SEE GAMES' : '';

  List<MenuAction> get menuActions {
    if (_subTabIndex == 0) {
      return _cachedUpcomingActions ??= [
        const MenuAction(Icons.add, 'Create Game'),
        const MenuAction(Icons.share, 'Share Calendar'),
        const MenuAction(Icons.person_add_alt_1, 'Invite Playpals'),
        const MenuAction(Icons.history, 'My Bookings'),
      ];
    }
    return _cachedPastActions ??= [
      const MenuAction(Icons.add, 'Create Game'),
      const MenuAction(Icons.history, 'My Bookings'),
    ];
  }

  String? get emptyImage => null;

  @override
  void dispose() {
    _cachedUpcomingActions = null;
    _cachedPastActions = null;
    super.dispose();
  }
}
