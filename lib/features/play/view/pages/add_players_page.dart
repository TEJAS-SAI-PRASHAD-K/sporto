import 'package:flutter/material.dart';
import 'package:playo/core/common/widgets/filter_sort_bottom_sheet.dart';

class AddPlayersPage extends StatefulWidget {
  const AddPlayersPage({super.key});

  @override
  State<AddPlayersPage> createState() => _AddPlayersPageState();
}

class _AddPlayersPageState extends State<AddPlayersPage> {
  SortBy _sortBy = SortBy.recentlyAdded;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Add Players', style: TextStyle(fontWeight: FontWeight.w700)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Center(
              child: Text(
                'INVITED (0)',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search By Name, Number or Email',
                filled: true,
                fillColor: cs.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Tabs
          TabBarHeader(),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    final res = await showFilterSortBottomSheet(context, initialSort: _sortBy);
                    if (res != null) {
                      setState(() => _sortBy = res.sortBy);
                    }
                  },
                  child: _FilterChipButton(icon: Icons.filter_alt_outlined, label: 'Filter'),
                ),
                const SizedBox(width: 8),
                _FilterChipButton(icon: Icons.tag_outlined, label: sortByLabel(_sortBy)),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _EmptyIllustration(),
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    disabledBackgroundColor: cs.surfaceContainerHighest,
                    disabledForegroundColor: cs.onSurfaceVariant,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('SEND INVITE (0)'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TabBarHeader extends StatefulWidget {
  @override
  State<TabBarHeader> createState() => _TabBarHeaderState();
}

class _TabBarHeaderState extends State<TabBarHeader>
    with TickerProviderStateMixin {
  late final TabController _controller = TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      children: [
        TabBar(
          controller: _controller,
          labelColor: cs.primary,
          unselectedLabelColor: cs.onSurfaceVariant,
          indicatorColor: cs.primary,
          tabs: const [
            Tab(text: 'Playpals'),
            Tab(text: 'Contacts'),
          ],
        ),
        SizedBox(
          height: 0,
          child: TabBarView(
            controller: _controller,
            children: const [SizedBox.shrink(), SizedBox.shrink()],
          ),
        ),
      ],
    );
  }
}

class _FilterChipButton extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FilterChipButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: cs.onSurface),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: cs.onSurface)),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 18),
        ],
      ),
    );
  }
}

class _EmptyIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Icon(Icons.smartphone, size: 96, color: cs.onSurfaceVariant),
          const SizedBox(height: 16),
          Text(
            'No Players Found',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: cs.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You can change the filter to see more players.',
            style: TextStyle(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
