import 'package:flutter/material.dart';
import 'package:playo/core/models/game.dart';
import 'package:playo/features/play/model/game_ui_extensions.dart';
import 'package:playo/features/play/view/pages/game_overview/add_players_page.dart';
import 'package:playo/features/play/view/pages/game_overview/manage_players_page.dart';
import 'package:playo/features/play/view/widgets/game_sub_tab_bar.dart';

class PlayersPage extends StatelessWidget {
  final Game game;
  final bool inviteOnly; // if true shows lock, else globe
  const PlayersPage({super.key, required this.game, this.inviteOnly = false});

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
        title: Text(
          'Players (${game.goingCount})',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          Row(
            children: [
              Icon(
                inviteOnly ? Icons.lock_outline : Icons.public_outlined,
                color: cs.onSurface,
              ),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          GameSubTabBar(
            text:
                '${game.sport} / ${_timeOfDay(game.startTime)} / ${_dateLabel(game.startTime)} / ${game.levelLabel}',
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 8),
                _PlayerTile(
                  name: game.organizerName,
                  chip: 'HOST',
                  skill: 'PROFESSIONAL',
                ),
                const Divider(height: 1),
                _PlayerTile(name: 'Tejas  K', skill: 'PROFESSIONAL'),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AddPlayersPage(),
                          ),
                        );
                      },
                      child: const Text('ADD PLAYERS'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ManagePlayersPage(game: game),
                          ),
                        );
                      },
                      child: const Text('MANAGE'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerTile extends StatelessWidget {
  final String name;
  final String? chip;
  final String skill;
  const _PlayerTile({required this.name, this.chip, required this.skill});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: CircleAvatar(
        backgroundColor: cs.primary,
        child: Icon(Icons.person, color: cs.onPrimary),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(name, style: TextStyle(color: cs.onSurface)),
          ),
          if (chip != null) ...[
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Text(
                chip!,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
      subtitle: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: Text(
              skill,
              style: TextStyle(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
