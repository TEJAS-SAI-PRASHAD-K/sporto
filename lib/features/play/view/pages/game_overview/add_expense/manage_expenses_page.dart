import 'package:flutter/material.dart';
import 'package:playo/features/play/view/widgets/game_sub_tab_bar.dart';
import 'package:playo/features/play/view/pages/game_overview/add_expense/add_expense.dart';

class ManageExpensesPage extends StatefulWidget {
  const ManageExpensesPage({super.key});

  @override
  State<ManageExpensesPage> createState() => _ManageExpensesPageState();
}

class _ManageExpensesPageState extends State<ManageExpensesPage> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Manage',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: TextButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const AddExpensePage()),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Expense'),
                style: TextButton.styleFrom(foregroundColor: cs.onSurface),
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Expenses'),
              Tab(text: 'Accounts'),
              Tab(text: 'Log'),
            ],
          ),
        ),
        body: Column(
          children: [
            const GameSubTabBar(
              text: 'Badminton / Night / 18th Sep, Thu / Beginner +',
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _EmptyState(
                    title: 'No Expense Recorded',
                    subtitle: 'Expenses added by players will appear here!',
                    ctaLabel: 'ADD EXPENSE',
                    onPressed: () {},
                  ),
                  _EmptyState(
                    title: 'No Dues',
                    subtitle:
                        'You will be able to see how much you owe/owed here!',
                  ),
                  _EmptyState(
                    title: 'Empty Log',
                    subtitle:
                        'Change logs will be captured here for transparency!',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? ctaLabel;
  final VoidCallback? onPressed;
  const _EmptyState({
    required this.title,
    required this.subtitle,
    this.ctaLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      color: cs.surfaceContainerHighest.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.image_outlined, size: 100, color: cs.onSurfaceVariant),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              color: cs.onSurface,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              subtitle,
              style: TextStyle(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ),
          if (ctaLabel != null) ...[
            const SizedBox(height: 24),
            FilledButton(onPressed: onPressed, child: Text(ctaLabel!)),
          ],
        ],
      ),
    );
  }
}
