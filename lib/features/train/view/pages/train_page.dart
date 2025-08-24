import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:playo/core/common/widgets/main_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:playo/features/train/viewmodel/train_view_model.dart';
import 'package:playo/features/train/view/widgets/category_chip.dart';
import 'package:playo/features/train/view/widgets/trainer_card.dart';
import 'package:playo/features/train/view/pages/trainer_details_page.dart';

class TrainPage extends StatefulWidget {
  const TrainPage({super.key});

  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrainViewModel(),
      child: Builder(
        builder: (context) {
          final theme = Theme.of(context);
          return Scaffold(
            appBar: const MainAppBar(),
            body: Consumer<TrainViewModel>(
              builder: (context, vm, _) => CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search by Sport",
                          suffixIcon: Icon(
                            Iconsax.search_normal_1_copy,
                            color: theme.colorScheme.outline,
                            size: 18,
                          ),
                          filled: true,
                          fillColor: theme.colorScheme.surfaceContainer,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Quick actions row
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: theme.colorScheme.outlineVariant,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.list, size: 20),
                                    SizedBox(width: 6),
                                    Text("List With Us"),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 20,
                              width: 1,
                              color: Colors.grey.shade400,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.question_answer, size: 20),
                                    SizedBox(width: 6),
                                    Text("Queries"),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        "What're you looking to level up on?",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  // Categories grid 3xN like in screenshot
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: .85,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final c = vm.categories[index];
                        return CategoryChip(category: c, onTap: () {});
                      }, childCount: vm.categories.length),
                    ),
                  ),

                  // Filter buttons
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),

                      child: Row(
                        children: [
                          _FilterPill(
                            icon: Icons.swap_vert,
                            label: 'Filter & Sort',
                          ),
                          const SizedBox(width: 8),
                          _FilterPill(
                            icon: Icons.grid_view_rounded,
                            label: 'Service',
                          ),
                          const SizedBox(width: 8),
                          _FilterPill(
                            icon: Icons.person_outline,
                            label: 'Trainer',
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Trainers grid
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: .70,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final t = vm.trainers[index];
                        return TrainerCard(
                          trainer: t,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => TrainerDetailsPage(trainer: t),
                            ),
                          ),
                        );
                      }, childCount: vm.trainers.length),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FilterPill extends StatelessWidget {
  final IconData icon;
  final String label;
  const _FilterPill({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}
