import 'package:flutter/material.dart';
import 'package:playo/features/home/view/widgets/app_bar_with_search.dart';
import 'package:playo/features/home/view/widgets/search_bar_widget.dart';

class SelectPlaypalsPage extends StatefulWidget {
  const SelectPlaypalsPage({super.key});

  @override
  State<SelectPlaypalsPage> createState() => _SelectPlaypalsPageState();
}

class _SelectPlaypalsPageState extends State<SelectPlaypalsPage> {
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  final int _selectedCount = 0;

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
        title: 'Select Playpals',
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
              hintText: 'Search Playpals',
              onChanged: (value) {
                // Handle search logic here
              },
            ),
          Expanded(
            child: Center(
              child: Text(
                'Playpals list will be displayed here',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 32.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
              ),
              child: Text(
                '$_selectedCount SELECTED',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: FilledButton(
                onPressed: _selectedCount > 0
                    ? () {
                        // Handle next action
                        debugPrint(
                          'Next pressed with $_selectedCount selected',
                        );
                      }
                    : null,
                style: FilledButton.styleFrom(
                  backgroundColor: _selectedCount > 0
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).disabledColor,
                  foregroundColor: _selectedCount > 0
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.38),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                child: const Text(
                  'NEXT',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
