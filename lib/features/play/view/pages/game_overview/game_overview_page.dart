import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/features/play/model/game_ui_extensions.dart';
import 'package:playo/features/play/view/pages/game_overview/add_expense/manage_expenses_page.dart';
import 'package:playo/features/play/view/pages/game_overview/add_players_page.dart';
import 'package:playo/features/play/view/pages/game_overview/manage_players_page.dart';
import 'package:playo/features/play/view/pages/game_overview/players_page.dart';
import 'package:playo/features/play/repository/games_remote_repository.dart';
import 'package:playo/init_dependecies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:playo/core/models/game.dart' as core_game;
import 'package:playo/features/play/view/pages/update_game_page.dart';
import 'package:playo/features/play/view/widgets/menu_overlay.dart';
import 'package:playo/features/play/model/menu_action.dart';

class GameOverviewPage extends StatefulWidget {
  final Game game;
  final ValueChanged<Game>? onGameUpdated;
  const GameOverviewPage({super.key, required this.game, this.onGameUpdated});
  @override
  State<GameOverviewPage> createState() => _GameOverviewPageState();
}

class _GameOverviewPageState extends State<GameOverviewPage> {
  late Game _game;

  @override
  void initState() {
    super.initState();
    _game = widget.game;
  }

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

  // Exact time utilities for subtitle

  String _fmtTime(DateTime dt) {
    int h = dt.hour % 12;
    if (h == 0) h = 12;
    final m = dt.minute.toString().padLeft(2, '0');
    final ampm = dt.hour >= 12 ? 'PM' : 'AM';
    return '$h:$m $ampm';
  }

  String _fmtRange(DateTime start, DateTime end) =>
      '${_fmtTime(start)} - ${_fmtTime(end)}';

  String _buildInviteLink(Game game) {
    // For demo: simple deep link with game_id. Replace with your dynamic link.
    return 'https://playo.app/join?game_id=${game.id}';
  }

  Widget _privacyToggleButton({
    required BuildContext context,
    required IconData icon,
    required bool selected,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    final cs = Theme.of(context).colorScheme;
    final Color bg = selected ? cs.onPrimary : cs.surface;
    final Color fg = selected ? cs.primary : cs.onSurfaceVariant;
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: selected ? cs.primary : cs.outlineVariant,
            ),
          ),
          child: Icon(icon, color: fg, size: 20),
        ),
      ),
    );
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
              _game.sport,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 2),
            Text(
              '${_fmtRange(_game.startTime, _game.endTime)} • ${_dateLabel(_game.startTime)}',
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              final url = _buildInviteLink(_game);
              final text = 'Join my ${_game.sport} game on Playo: $url';
              Share.share(text, subject: 'Playo Game Invite');
            },
            icon: const Icon(Icons.share_outlined),
            tooltip: 'Share Invite',
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: _showMoreMenu,
            icon: const Icon(Icons.more_vert, size: 28),
            tooltip: 'More',
          ),
          const SizedBox(width: 8),
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
                              _game.venue.split(',').first,
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => ManageExpensesPage(),
                        ),
                      );
                    },
                  ),
                ),

                // Other Instructions
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Other Instructions',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          if (_game.payAndJoin && _game.costPerPlayer != null)
                            _chip(
                              context,
                              'INR ${_game.costPerPlayer!.toStringAsFixed(0)}/Player',
                              Icons.payments_outlined,
                            ),
                          if (_game.type.toLowerCase().contains('tournament'))
                            _chip(
                              context,
                              'Tournament',
                              Icons.emoji_events_outlined,
                            ),
                          if (_game.costShared)
                            _chip(context, 'Cost Shared', Icons.call_split),
                          if (_game.bringYourOwnEquipment)
                            _chip(
                              context,
                              'Bring Your Own Equipment',
                              Icons.backpack_outlined,
                            ),
                          if ((_game.totalPlayers ?? 0) > 0)
                            _chip(
                              context,
                              'Required Players ${_game.totalPlayers}',
                              Icons.groups_2_outlined,
                            ),
                        ],
                      ),
                      if ((_game.instructionsNote ?? '').isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          _game.instructionsNote!,
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      ],
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
                            'Players (${_game.goingCount})',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              _privacyToggleButton(
                                context: context,
                                icon: Icons.lock_outline,
                                selected: !_game.isPublic,
                                tooltip: 'Invite Only',
                                onTap: () {
                                  if (_game.isPublic) {
                                    setState(() {
                                      _game.gameAccessType = 'Invite Only';
                                    });
                                    widget.onGameUpdated?.call(_game);
                                  }
                                },
                              ),
                              const SizedBox(width: 8),
                              _privacyToggleButton(
                                context: context,
                                icon: Icons.public_outlined,
                                selected: _game.isPublic,
                                tooltip: 'Public',
                                onTap: () {
                                  if (!_game.isPublic) {
                                    setState(() {
                                      _game.gameAccessType = 'Public';
                                    });
                                    widget.onGameUpdated?.call(_game);
                                  }
                                },
                              ),
                            ],
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
                            Expanded(child: Text(_game.organizerName)),
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
                                  builder: (_) =>
                                      ManagePlayersPage(game: _game),
                                ),
                              );
                            },
                          ),
                          _QuickAction(
                            icon: Icons.chevron_right,
                            label: 'Players',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PlayersPage(
                                    game: _game,
                                    inviteOnly: !_game.isPublic,
                                  ),
                                ),
                              );
                            },
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
                        _game.isPublic
                            ? 'This game is Public'
                            : 'This game is Invite Only',
                        style: TextStyle(color: cs.onSurfaceVariant),
                      ),
                      const SizedBox(width: 6),
                      Icon(
                        _game.isPublic
                            ? Icons.public_outlined
                            : Icons.lock_outline,
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

  OverlayEntry? _moreMenuOverlay;

  void _showMoreMenu() {
    _moreMenuOverlay?.remove();
    final media = MediaQuery.of(context);
    final top = kToolbarHeight + media.padding.top + 8;
    _moreMenuOverlay = MenuOverlay.build(
      top: top,
      right: 12,
      actions: const [
        MenuAction(
          Icons.event_available_outlined,
          'Add to Calendar',
          id: 'calendar',
        ),
        MenuAction(
          Icons.notifications_off_outlined,
          'Mute Notifications',
          id: 'mute',
        ),
        MenuAction(Icons.edit_outlined, 'Edit Game Details', id: 'edit'),
      ],
      onClose: () {
        _moreMenuOverlay?.remove();
        _moreMenuOverlay = null;
      },
      onActionTap: (action) async {
        switch (action.id) {
          case 'calendar':
            // TODO: implement calendar integration
            break;
          case 'mute':
            // TODO: implement mute notifications toggle
            break;
          case 'edit':
            final r = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => _UpdateGameRouteProxy(gameId: _game.id),
              ),
            );
            if (r == 'deleted') {
              if (!mounted) return;
              Navigator.pop(context, 'deleted');
            }
            break;
        }
      },
    );
    Overlay.of(context).insert(_moreMenuOverlay!);
  }
}

// Small helper route that loads core Game and shows UpdateGamePage
class _UpdateGameRouteProxy extends StatelessWidget {
  final String gameId;
  const _UpdateGameRouteProxy({required this.gameId});

  @override
  Widget build(BuildContext context) {
    final supabase = serviceLocator<SupabaseClient>();
    final repo = GamesRemoteRepository(supabase);
    return FutureBuilder<core_game.Game>(
      future: repo
          .getGameById(gameId)
          .then((e) => e.getOrElse((_) => throw Exception('Failed'))),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Failed to load game')),
          );
        }
        return UpdateGamePage(game: snapshot.data!);
      },
    );
  }
}

Widget _chip(BuildContext context, String label, IconData icon) {
  final cs = Theme.of(context).colorScheme;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: cs.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: cs.onSurfaceVariant),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12, color: cs.onSurface)),
      ],
    ),
  );
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
