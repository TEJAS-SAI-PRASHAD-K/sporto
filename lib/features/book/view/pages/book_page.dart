import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodel/book_page_viewmodel.dart';
import '../widgets/book_app_bar.dart';
import '../widgets/book_search_bar.dart';
import '../widgets/promotional_banner.dart';
import '../widgets/filter_section.dart';
import '../widgets/tabs_section.dart';

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
    return Consumer<BookPageViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.white,
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
              ],
            ),
          ),
        );
      },
    );
  }
}
