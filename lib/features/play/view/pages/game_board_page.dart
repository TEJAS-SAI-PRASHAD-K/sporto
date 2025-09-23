import 'package:flutter/material.dart';
import 'package:playo/features/play/model/game.dart';
import 'package:playo/features/play/view/pages/game_overview/game_overview_page.dart';

class GameBoardPage extends StatelessWidget {
  final Game game;
  const GameBoardPage({super.key, required this.game});

  String _dateChip(DateTime dt) {
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
    const weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final m = months[dt.month - 1];
    final w = weekdays[dt.weekday - 1];
    return '$w, $m ${dt.day}';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: cs.surfaceContainerHighest,
              child: Icon(Icons.person, color: cs.onSurface),
            ),
            const SizedBox(width: 8),
            Text(
              game.sport,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Info',
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => GameOverviewPage(game: game)),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Chat body placeholder
          ListView(
            padding: const EdgeInsets.symmetric(vertical: 16),
            children: [
              const SizedBox(height: 24),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: cs.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: cs.outlineVariant),
                  ),
                  child: Text(
                    _dateChip(DateTime.now()),
                    style: TextStyle(color: cs.onSurfaceVariant),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  '${game.organizerName} joined.',
                  style: TextStyle(color: cs.onSurfaceVariant),
                ),
              ),
            ],
          ),
          // Bottom input bar
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                decoration: BoxDecoration(
                  color: cs.surface,
                  border: Border(top: BorderSide(color: cs.outlineVariant)),
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: cs.outlineVariant),
                        ),
                        child: Icon(Icons.add, color: cs.primary),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: cs.outlineVariant),
                        ),
                        child: Text(
                          'Type Something',
                          style: TextStyle(color: cs.onSurfaceVariant),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.mic, color: cs.primary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
