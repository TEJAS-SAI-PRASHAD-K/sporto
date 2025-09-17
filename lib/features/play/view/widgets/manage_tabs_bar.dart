import 'package:flutter/material.dart';

class ManageTabsBar extends StatelessWidget implements PreferredSizeWidget {
  final int requestsCount;
  final int invitedCount;
  final int playingCount;
  final int retiredCount;
  const ManageTabsBar({
    super.key,
    required this.requestsCount,
    required this.invitedCount,
    required this.playingCount,
    required this.retiredCount,
  });

  @override
  Size get preferredSize => const Size.fromHeight(46);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return TabBar(
      
      labelColor: cs.primary,
      unselectedLabelColor: cs.onSurfaceVariant,
      indicatorColor: cs.primary,
      isScrollable: false,
      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
      tabs: [
        Tab(text: 'Requests ($requestsCount)'),
        Tab(text: 'Invited ($invitedCount)'),
        Tab(text: 'Playing ($playingCount)'),
        Tab(text: 'Retired ($retiredCount)'),
      ],
    );
  }
}
