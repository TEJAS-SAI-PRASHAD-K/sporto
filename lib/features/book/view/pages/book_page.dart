import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/common/widgets/main_app_bar.dart';
import 'package:playo/core/models/venue.dart';
import 'package:playo/features/book/viewmodel/venue_view_model.dart';
import 'package:playo/features/book/model/tab_item.dart';

import '../widgets/book_search_bar.dart';
import '../widgets/promotional_banner.dart';
import '../widgets/filter_section.dart';
import '../widgets/tabs_section.dart';
import '../widgets/venues_list.dart' show VenuesList;

class BookPage extends ConsumerStatefulWidget {
  const BookPage({super.key});

  @override
  ConsumerState<BookPage> createState() => _BookPageState();
}

class _BookPageState extends ConsumerState<BookPage> {
  String _searchQuery = '';
  int _selectedFilterIndex = 0;
  int _selectedTabIndex = 0;

  List<TabItem> _tabs = [
    const TabItem(title: 'Venues', count: 0, isSelected: true),
    const TabItem(title: 'Events', count: 0, isSelected: false),
    const TabItem(title: 'Deals', count: 0, isSelected: false),
  ];

  final List<String> _filterOptions = [
    'Sport & Availability',
    'Favourites',
    'Offers',
  ];

  void _setSearchQuery(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _setSelectedFilterIndex(int index) {
    setState(() {
      _selectedFilterIndex = index;
    });
  }

  void _setSelectedTabIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
      _tabs = _tabs.asMap().entries.map((entry) {
        return entry.value.copyWith(isSelected: entry.key == index);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final venueState = ref.watch(venueViewModelProvider);

    ref.listen<AsyncValue<Venue>?>(venueViewModelProvider, (_, next) {
      next?.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: $error")));
        },
      );
    });

    final venueCount = venueState?.valueOrNull?.data.length ?? 0;
    final currentSelection = _tabs.indexWhere((t) => t.isSelected == true);

    _tabs = [
      _tabs[0].copyWith(
        count: venueCount,
        isSelected: currentSelection == 0 || currentSelection == -1,
      ),
      _tabs[1].copyWith(count: 0, isSelected: currentSelection == 1),
      _tabs[2].copyWith(count: 0, isSelected: currentSelection == 2),
    ];

    return Scaffold(
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// ---------- Static UI ----------
            const SizedBox(height: 16),
            BookSearchBar(
              searchQuery: _searchQuery,
              onSearchChanged: _setSearchQuery,
            ),
            const SizedBox(height: 16),
            const PromotionalBanner(),
            const SizedBox(height: 20),
            FilterSection(
              options: _filterOptions,
              selectedIndex: _selectedFilterIndex,
              onFilterSelected: _setSelectedFilterIndex,
            ),
            const SizedBox(height: 16),
            TabsSection(
              tabs: _tabs,
              selectedIndex: _selectedTabIndex,
              onTabSelected: _setSelectedTabIndex,
            ),
            const SizedBox(height: 16),

            /// ---------- Dynamic Content ----------
            Builder(
              builder: (context) {
                if (_selectedTabIndex == 0) {
                  // VENUES
                  if (venueState == null) {
                    return const Center(
                      child: Text("No data yet. Tap to load."),
                    );
                  }
                  return venueState.when(
                    data: (venues) {
                      if (venues.data.isEmpty) {
                        return const Center(child: Text("No venues found"));
                      }
                      return VenuesList(venues: venues.data);
                    },
                    loading: () =>
                        const Center(child: Text("Loading venues...")),
                    error: (err, _) =>
                        const Center(child: Text("Failed to load venues")),
                  );
                } else if (_selectedTabIndex == 1) {
                  // EVENTS
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                        'No Events found',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                } else {
                  //DEALS
                  return const Center(child: Text("No deals available"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
