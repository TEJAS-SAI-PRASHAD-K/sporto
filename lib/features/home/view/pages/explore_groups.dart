import 'package:flutter/material.dart';
import 'package:playo/features/home/view/widgets/app_bar_with_search.dart';
import 'package:playo/features/home/view/widgets/search_bar_widget.dart';

class ExploreGroups extends StatefulWidget {
  const ExploreGroups({super.key});

  @override
  State<ExploreGroups> createState() => _ExploreGroupsState();
}

class _ExploreGroupsState extends State<ExploreGroups> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
      } else {
        _searchFocusNode.requestFocus();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearch(
        title: 'Explore Groups',
        isSearching: _isSearching,
        onSearchToggle: _toggleSearch,
        centerTitle: false,
      ),
      body: Column(
        children: [
          if (_isSearching)
            SearchBarWidget(
              controller: _searchController,
              focusNode: _searchFocusNode,
              hintText: 'Search by Name',
              onChanged: (value) {
                // Handle search logic here
              },
            ),
          const Expanded(
            child: Center(child: Text('Groups will be displayed here')),
          ),
        ],
      ),
    );
  }
}
