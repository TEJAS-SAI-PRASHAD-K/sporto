import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:playo/core/widgets/bottom_navigation_bar.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';
import 'package:playo/features/onboarding/providers/sports_provider.dart';
import 'package:playo/core/providers/current_user_provider.dart';

class PickYourFavSportsPage extends ConsumerStatefulWidget {
  final bool isLoggedIn;
  const PickYourFavSportsPage({super.key, this.isLoggedIn = false});

  @override
  ConsumerState<PickYourFavSportsPage> createState() =>
      _PickYourFavSportsPageState();
}

class _PickYourFavSportsPageState extends ConsumerState<PickYourFavSportsPage> {
  List<String> selectedSports = [];
  bool _initializedFromUser = false;

  void toggleSport(String sportId) {
    setState(() {
      if (selectedSports.contains(sportId)) {
        selectedSports.remove(sportId);
      } else {
        selectedSports.add(sportId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Initialize selection from user's saved favorites (first build only)
    final currentUser = ref.watch(currentUserNotifierProvider);
    if (!_initializedFromUser &&
        (currentUser?.favoriteSports?.isNotEmpty ?? false)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        setState(() {
          selectedSports = List<String>.from(currentUser!.favoriteSports!);
          _initializedFromUser = true;
        });
      });
    }
    final sportsAsync = ref.watch(sportsViewModelProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Pick Your Favorites',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: sportsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading sports: $e')),
        data: (sports) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 1.2,
                          ),
                      itemCount: sports.length,
                      itemBuilder: (context, index) {
                        final sport = sports[index];
                        final isSelected = selectedSports.contains(
                          sport.sportId,
                        );
                        return GestureDetector(
                          onTap: () => toggleSport(sport.sportId),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.outline,
                                width: isSelected ? 3 : 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              color: isSelected
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainer,
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child:
                                      sport.imageUrl != null &&
                                          sport.imageUrl!.isNotEmpty
                                      ? Image.network(
                                          sport.imageUrl!,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(Icons.sports),
                                        )
                                      : const Icon(Icons.sports),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .surfaceContainer
                                          .withAlpha(180),
                                    ),
                                    child: Text(
                                      sport.sportName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: selectedSports.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        // Save selected sports to user profile
                        await ref
                            .read(authViewModelProvider.notifier)
                            .updateUserSports(preferredSports: selectedSports);

                        if (!widget.isLoggedIn) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => const BottomNavBar(),
                            ),
                            (Route<dynamic> route) => false,
                          );
                        } else {
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text('Error: $e')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Continue (${selectedSports.length} selected)',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }
}
