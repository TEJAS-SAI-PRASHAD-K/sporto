import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:playo/core/common/widgets/main_app_bar.dart';
import 'package:playo/core/models/trainer.dart';
import 'package:playo/features/more/view/pages/help_and_support_page.dart';
import 'package:playo/features/train/viewmodel/train_view_model.dart';
import 'package:playo/features/train/view/widgets/category_chip.dart';
import 'package:playo/features/train/view/widgets/trainer_card.dart';
import 'package:playo/features/train/view/pages/trainer_details_page.dart';
import 'package:playo/features/train/view/widgets/filter_pill.dart';

class TrainPage extends ConsumerStatefulWidget {
  const TrainPage({super.key});

  @override
  ConsumerState<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends ConsumerState<TrainPage> {
  @override
  void initState() {
    super.initState();

    // Call fetch after the first frame to avoid interacting with providers
    // synchronously during widget initialization.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(trainViewModelProvider.notifier).fetchTrainers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final trainState = ref.watch(trainViewModelProvider);

    ref.listen<AsyncValue<Trainer>?>(trainViewModelProvider, (_, next) {
      next?.whenOrNull(
        error: (error, _) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Error: $error")));
        },
      );
    });

    final theme = Theme.of(context);

    return Scaffold(
      appBar: const MainAppBar(),
      body: CustomScrollView(
        slivers: [
          // Search field
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
                  border: Border.all(color: theme.colorScheme.outlineVariant),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                      color: theme.colorScheme.outlineVariant,
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Service categories from view model
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: .85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final categories = ref
                      .read(trainViewModelProvider.notifier)
                      .categories;
                  if (index >= categories.length) {
                    return const SizedBox.shrink();
                  }
                  final c = categories[index];
                  return CategoryChip(category: c, onTap: () {});
                },
                childCount: ref
                    .read(trainViewModelProvider.notifier)
                    .categories
                    .length,
              ),
            ),
          ),

          // Filter buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterPill(
                      icon: Icons.swap_vert,
                      label: 'Filter & Sort',
                      isSelected: false,
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    FilterPill(
                      icon: Icons.grid_view_rounded,
                      label: 'Service',
                      isSelected: false,
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    FilterPill(
                      icon: Icons.person_outline,
                      label: 'Trainer',
                      isSelected: false,
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    FilterPill(
                      icon: Icons.school,
                      label: 'Academy',
                      isSelected: false,
                      onTap: () {},
                    ),
                    SizedBox(width: 12),
                  ],
                ),
              ),
            ),
          ),

          // Trainers
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
              child: trainState?.when(
                data: (trainers) {
                  if (trainers.data.isEmpty) {
                    return const Center(child: Text("No trainers found"));
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: trainers.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: .70,
                        ),
                    itemBuilder: (context, index) {
                      final datum = trainers.data[index];
                      return TrainerCard(
                        datum: datum,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TrainerDetailsPage(datum: datum),
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) =>
                    Center(child: Text("Failed to load trainers: $err")),
              ),
            ),
          ),

          // FAQs Button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => HelpAndSupportPage()),
                    );
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.onInverseSurface,
                    backgroundColor: theme.colorScheme.primary,
                    textStyle: theme.textTheme.bodyLarge,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                      side: BorderSide(color: theme.colorScheme.primary),
                    ),
                  ),
                  child: const Text('FAQs'),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 12)),
        ],
      ),
    );
  }
}
