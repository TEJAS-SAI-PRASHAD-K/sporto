import 'package:flutter/material.dart';
import 'package:playo/features/play/model/menu_action.dart';

class PlayPageViewModel extends ChangeNotifier {
  int _tabIndex = 0;
  int _subTabIndex = 0;

  List<MenuAction>? _cachedUpcomingActions;
  List<MenuAction>? _cachedPastActions;

  int get tabIndex => _tabIndex;
  int get subTabIndex => _subTabIndex;

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

  @override
  void dispose() {
    _cachedUpcomingActions = null;
    _cachedPastActions = null;
    super.dispose();
  }
}
