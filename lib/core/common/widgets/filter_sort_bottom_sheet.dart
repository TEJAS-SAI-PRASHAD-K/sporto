import 'package:flutter/material.dart';

/// Sort options supported by the filter bottom sheet
enum SortBy { recentlyAdded, mutualGames, alphabetical }

String sortByLabel(SortBy s) {
  switch (s) {
    case SortBy.recentlyAdded:
      return 'Recently Added';
    case SortBy.mutualGames:
      return 'Mutual Games';
    case SortBy.alphabetical:
      return 'Alphabetically';
  }
}

// Internal tabs for the filter sheet left rail
enum _FilterTab { sort, sports, tags }

/// Result returned from the bottom sheet. Can be extended with sports/tags later.
class FilterSortResult {
  final SortBy sortBy;
  final String? sport; // null means All/none selected
  const FilterSortResult({required this.sortBy, this.sport});
}

/// Shows a modal bottom sheet that lets the user pick sorting and future filters.
Future<FilterSortResult?> showFilterSortBottomSheet(
  BuildContext context, {
  SortBy initialSort = SortBy.recentlyAdded,
  String? initialSport,
  List<String>? sports,
  Future<List<String>> Function()? loadSports,
}) {
  final cs = Theme.of(context).colorScheme;
  SortBy selectedSort = initialSort;
  String? selectedSport = initialSport;
  _FilterTab tab = _FilterTab.sort;

  return showModalBottomSheet<FilterSortResult>(
    context: context,
    isScrollControlled: false,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Text(
                      'Filter & Sort',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.pop(ctx),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left rail (tabs)
                    Container(
                      width: 120,
                      decoration: BoxDecoration(
                        color: cs.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _RailButton(
                            label: 'Sort By',
                            isSelected: tab == _FilterTab.sort,
                            onTap: () => setState(() => tab = _FilterTab.sort),
                          ),
                          _RailButton(
                            label: 'Sports',
                            isSelected: tab == _FilterTab.sports,
                            onTap: () =>
                                setState(() => tab = _FilterTab.sports),
                          ),
                          _RailButton(
                            label: 'Tags',
                            isSelected: tab == _FilterTab.tags,
                            onTap: () => setState(() => tab = _FilterTab.tags),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Right content
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: tab == _FilterTab.sort
                            ? Column(
                                key: const ValueKey('sort'),
                                children: [
                                  _SortTile(
                                    title: sortByLabel(SortBy.recentlyAdded),
                                    group: selectedSort,
                                    value: SortBy.recentlyAdded,
                                    onChanged: (v) =>
                                        setState(() => selectedSort = v),
                                  ),
                                  const Divider(),
                                  _SortTile(
                                    title: sortByLabel(SortBy.mutualGames),
                                    group: selectedSort,
                                    value: SortBy.mutualGames,
                                    onChanged: (v) =>
                                        setState(() => selectedSort = v),
                                  ),
                                  const Divider(),
                                  _SortTile(
                                    title: sortByLabel(SortBy.alphabetical),
                                    group: selectedSort,
                                    value: SortBy.alphabetical,
                                    onChanged: (v) =>
                                        setState(() => selectedSort = v),
                                  ),
                                ],
                              )
                            : tab == _FilterTab.sports
                            ? _SportsPicker(
                                selected: selectedSport,
                                sports: sports,
                                loadSports: loadSports,
                                onChanged: (s) =>
                                    setState(() => selectedSport = s),
                              )
                            : Center(
                                child: Text(
                                  'Tags coming soon',
                                  style: TextStyle(color: cs.onSurfaceVariant),
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          setState(() {
                            selectedSort = SortBy.recentlyAdded;
                            selectedSport = null;
                          });
                        },
                        child: const Text('RESET'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            ctx,
                            FilterSortResult(
                              sortBy: selectedSort,
                              sport: selectedSport,
                            ),
                          );
                        },
                        child: const Text('SEE RESULT'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      );
    },
  );
}

class _RailButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _RailButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? cs.surface : Colors.transparent,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 18,
              decoration: BoxDecoration(
                color: isSelected ? cs.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? cs.primary : cs.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
            if (label == 'Tags') ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.amber.shade400,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text('NEW', style: TextStyle(fontSize: 10)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SortTile extends StatelessWidget {
  final String title;
  final SortBy group;
  final SortBy value;
  final ValueChanged<SortBy> onChanged;
  const _SortTile({
    required this.title,
    required this.group,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: TextStyle(color: cs.onSurface)),
      trailing: Radio<SortBy>(
        value: value,
        groupValue: group,
        onChanged: (v) => onChanged(v ?? value),
      ),
      onTap: () => onChanged(value),
    );
  }
}

class _SportsPicker extends StatelessWidget {
  final String? selected;
  final List<String>? sports;
  final Future<List<String>> Function()? loadSports;
  final ValueChanged<String?> onChanged;
  const _SportsPicker({
    required this.selected,
    required this.sports,
    required this.loadSports,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Widget buildList(List<String> data) {
      if (data.isEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Text(
            'No sports found',
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
        );
      }
      return Column(
        children: [
          ...data.map(
            (s) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(s),
              trailing: Radio<String?>(
                value: s,
                groupValue: selected,
                onChanged: (v) => onChanged(v),
              ),
              onTap: () => onChanged(s),
            ),
          ),
        ],
      );
    }

    if (sports != null) {
      return buildList(sports!);
    }
    if (loadSports != null) {
      return FutureBuilder<List<String>>(
        future: loadSports!(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Text(
                'Failed to load sports',
                style: TextStyle(color: cs.error),
              ),
            );
          }
          return buildList(snapshot.data ?? const []);
        },
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Text(
        'Provide sports or a loader',
        style: TextStyle(color: cs.onSurfaceVariant),
      ),
    );
  }
}
