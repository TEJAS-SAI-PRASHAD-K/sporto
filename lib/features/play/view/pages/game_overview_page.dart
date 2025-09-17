import 'package:flutter/material.dart';
import 'package:playo/features/play/model/game.dart';
import 'package:playo/features/play/view/pages/add_players_page.dart';
import 'package:playo/features/play/view/pages/manage_players_page.dart';

class GameOverviewPage extends StatelessWidget {
  final Game game;
  const GameOverviewPage({super.key, required this.game});

  String _dateLabel(DateTime dt) {
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final w = weekdays[dt.weekday - 1];
    return '${dt.day}${_ordinal(dt.day)} ${months[dt.month - 1]}, $w';
  }

  String _ordinal(int n) {
    if (n >= 11 && n <= 13) return 'th';
    switch (n % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String _timeOfDay(DateTime dt) {
    final h = dt.hour;
    if (h >= 5 && h < 12) return 'Morning';
    if (h >= 12 && h < 17) return 'Afternoon';
    if (h >= 17 && h < 21) return 'Evening';
    return 'Night';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              game.sport,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              '${_timeOfDay(game.startTime)} • ${_dateLabel(game.startTime)}',
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            ),
          ],
        ),
        actions: const [
          Icon(Icons.public_outlined),
          SizedBox(width: 8),
          Icon(Icons.more_vert),
          SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Venue tag card
                _SectionCard(
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined, color: cs.primary),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              game.venue.split(',').first,
                              style: TextStyle(
                                color: cs.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Find and tag your venue',
                              style: TextStyle(color: cs.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      FilledButton.tonal(
                        onPressed: () {},
                        child: const Text(
                          'TAG\nVENUE',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),

                // Add Expense tile
                _SectionCard(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.account_balance_wallet_outlined),
                    title: const Text('Add Expense'),
                    subtitle: const Text(
                      'Start adding your expenses to split cost among players',
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ),

                // Other Instructions with button
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Other Instructions',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You can let the joinees know more about your game',
                        style: TextStyle(color: cs.onSurfaceVariant),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('ADD INSTRUCTIONS'),
                        ),
                      ),
                    ],
                  ),
                ),

                // Google Fit prompt
                _SectionCard(
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.amber,
                        child: Icon(
                          Icons.local_fire_department,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Activity is about to begin',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Link Google Fit and start tracking your game stats',
                              style: TextStyle(color: cs.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonalIcon(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_outline),
                      label: const Text('LINK GOOGLE FIT'),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Players section
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Players (${game.goingCount})',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.lock_outline),
                            tooltip: 'Privacy',
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.public_outlined),
                            tooltip: 'Public',
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.favorite_outline,
                            color: Colors.red,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'You are not covered',
                              style: TextStyle(color: cs.onSurfaceVariant),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Learn more'),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: cs.primary,
                          child: Icon(Icons.person, color: cs.onPrimary),
                        ),
                        title: Row(
                          children: [
                            Expanded(child: Text(game.organizerName)),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: cs.surface,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: cs.outlineVariant),
                              ),
                              child: const Text(
                                'HOST',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.shield_outlined, size: 14),
                            const SizedBox(width: 6),
                            const Text('AMATEUR'),
                          ],
                        ),
                      ),

                      const Divider(height: 24),
                      // Add Co-Host row
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest,
                          child: Icon(
                            Icons.person_add_alt_1_outlined,
                            color: cs.onSurface,
                          ),
                        ),
                        title: const Text('Add Co-Host'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () {},
                      ),

                      const SizedBox(height: 8),
                      // Quick actions: Add, Manage, Players
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _QuickAction(
                            icon: Icons.person_add_alt_1_outlined,
                            label: 'Add',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const AddPlayersPage(),
                                ),
                              );
                            },
                          ),
                          _QuickAction(
                            icon: Icons.manage_accounts_outlined,
                            label: 'Manage',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => const ManagePlayersPage(),
                                ),
                              );
                            },
                          ),
                          _QuickAction(
                            icon: Icons.chevron_right,
                            label: 'Players',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Queries card
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Queries (0)',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'There are no queries yet! Queries sent by players will be shown here',
                        style: TextStyle(color: cs.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),
                // Public label
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'This game is Public',
                        style: TextStyle(color: cs.onSurfaceVariant),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        Icons.public_outlined,
                        size: 16,
                        color: cs.onSurfaceVariant,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // for bottom button spacing
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text('GAME BOARD'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final Widget child;
  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: child,
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cs.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(icon, color: cs.onSurface),
            ),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: cs.onSurface)),
          ],
        ),
      ),
    );
  }
}
