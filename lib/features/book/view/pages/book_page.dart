import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/book_page_viewmodel.dart';
import '../widgets/book_app_bar.dart';
import '../widgets/book_search_bar.dart';
import '../widgets/promotional_banner.dart';
import '../widgets/filter_section.dart';
import '../widgets/tabs_section.dart';
import '../pages/add_venues_page.dart' show VenuesList;
import '../pages/add_venues_page.dart' as venues_source;

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookPageViewModel(),
      child: const BookPageContent(),
    );
  }
}

class BookPageContent extends StatelessWidget {
  const BookPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<BookPageViewModel>();
      vm.setTabCount(0, venues_source.mockVenuesCount);
    });

    return Consumer<BookPageViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: BookAppBar(
            selectedLocation: viewModel.selectedLocation,
            onLocationChanged: viewModel.setSelectedLocation,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 16),
                BookSearchBar(
                  searchQuery: viewModel.searchQuery,
                  onSearchChanged: viewModel.setSearchQuery,
                ),
                const SizedBox(height: 16),
                const PromotionalBanner(),
                const SizedBox(height: 20),
                FilterSection(
                  options: viewModel.filterOptions,
                  selectedIndex: viewModel.selectedFilterIndex,
                  onFilterSelected: viewModel.setSelectedFilterIndex,
                ),
                const SizedBox(height: 16),
                TabsSection(
                  tabs: viewModel.tabs,
                  selectedIndex: viewModel.selectedTabIndex,
                  onTabSelected: viewModel.setSelectedTabIndex,
                ),
                const SizedBox(height: 16),
                if (viewModel.selectedTabIndex == 0) ...[
                  // Venues tab content
                  const VenuesList(embedded: true),
                  const SizedBox(height: 16),
                ],
                if (viewModel.selectedTabIndex == 1) ...[
                  // Events tab content
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: Text(
                        'No Events found',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
