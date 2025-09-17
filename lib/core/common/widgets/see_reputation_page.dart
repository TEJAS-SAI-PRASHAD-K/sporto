import 'package:flutter/material.dart';

class SeeReputationPage extends StatelessWidget {
  final String playerName;
  final int noShowsLast15;
  final int downvotes;
  final int upvotes;
  final List<_RepCategory> categories;

  const SeeReputationPage({
    super.key,
    required this.playerName,
    this.noShowsLast15 = 0,
    this.downvotes = 0,
    this.upvotes = 0,
    this.categories = const [
      _RepCategory(title: 'Punctual', up: 0, down: 0),
      _RepCategory(title: 'Team Player', up: 0, down: 0),
      _RepCategory(title: 'Particular on payments', up: 0, down: 0),
    ],
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reputation',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        children: [
          Text(
            'Reputation recorded by playpals',
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          _NoShowsCard(count: noShowsLast15),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.thumb_down_alt_outlined,
                color: Colors.orange.shade700,
              ),
              const SizedBox(width: 6),
              Text('Downvotes', style: TextStyle(color: cs.onSurface)),
              const SizedBox(width: 24),
              Icon(
                Icons.thumb_up_alt_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 6),
              Text('Upvotes', style: TextStyle(color: cs.onSurface)),
            ],
          ),
          const SizedBox(height: 24),
          for (final c in categories) ...[
            _CategoryBar(title: c.title, up: c.up, down: c.down),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _NoShowsCard extends StatelessWidget {
  final int count;
  const _NoShowsCard({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$count',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'No-Shows ( in last 15 games )',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
    );
  }
}

class _CategoryBar extends StatelessWidget {
  final String title;
  final int up;
  final int down;
  const _CategoryBar({
    required this.title,
    required this.up,
    required this.down,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 14,
                decoration: BoxDecoration(
                  color: cs.surfaceVariant,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                height: 14,
                decoration: BoxDecoration(
                  color: cs.surfaceVariant,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Total ${up + down} votes',
          style: TextStyle(color: cs.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _RepCategory {
  final String title;
  final int up;
  final int down;
  const _RepCategory({
    required this.title,
    required this.up,
    required this.down,
  });
}

Future<void> openSeeReputation(
  BuildContext context, {
  required String playerName,
  int noShowsLast15 = 0,
  int downvotes = 0,
  int upvotes = 0,
  List<Map<String, int>> categories = const [
    {'Punctual': 0},
    {'Team Player': 0},
    {'Particular on payments': 0},
  ],
}) async {
  final parsed = categories
      .map(
        (e) => _RepCategory(title: e.keys.first, up: e.values.first, down: 0),
      )
      .toList();
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => SeeReputationPage(
        playerName: playerName,
        noShowsLast15: noShowsLast15,
        downvotes: downvotes,
        upvotes: upvotes,
        categories: parsed,
      ),
    ),
  );
}
