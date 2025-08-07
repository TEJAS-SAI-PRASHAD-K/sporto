import 'package:flutter/material.dart';
import 'package:playo/features/book/model/tab_item.dart';

class BookPageViewModel extends ChangeNotifier {
  String _selectedLocation = 'Hyderabad';
  String _searchQuery = '';
  int _selectedFilterIndex = 0;
  int _selectedTabIndex = 0;

  final List<String> _filterOptions = [
    'Sport & Availability',
    'Favourites',
    'Offers',
  ];

  List<TabItem> _tabs = [
    const TabItem(title: 'Venues', count: 0, isSelected: true),
    const TabItem(title: 'Events', count: 0),
    const TabItem(title: 'Deals', count: 0),
  ];

  // Getters
  String get selectedLocation => _selectedLocation;
  String get searchQuery => _searchQuery;
  int get selectedFilterIndex => _selectedFilterIndex;
  int get selectedTabIndex => _selectedTabIndex;
  List<String> get filterOptions => _filterOptions;
  List<TabItem> get tabs => _tabs;

  // Methods
  void setSelectedLocation(String location) {
    _selectedLocation = location;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedFilterIndex(int index) {
    _selectedFilterIndex = index;
    notifyListeners();
  }

  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    _updateTabSelection(index);
    notifyListeners();
  }

  void _updateTabSelection(int selectedIndex) {
    _tabs = _tabs.asMap().entries.map((entry) {
      return entry.value.copyWith(isSelected: entry.key == selectedIndex);
    }).toList();
  }
}
