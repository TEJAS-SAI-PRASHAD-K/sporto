import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/widgets/bottom_navigation_bar.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';

class PickYourFavSportsPage extends ConsumerStatefulWidget {
  const PickYourFavSportsPage({super.key});

  @override
  ConsumerState<PickYourFavSportsPage> createState() =>
      _PickYourFavSportsPageState();
}

class Sport {
  final String name;
  final String image;

  Sport({required this.name, required this.image});
}

class _PickYourFavSportsPageState extends ConsumerState<PickYourFavSportsPage> {
  List<String> selectedSports = [];

  final List<Sport> allSports = [
    // Initial Sports
    Sport(name: 'Football', image: 'assets/images/football_ground.png'),
    Sport(name: 'Basketball', image: 'assets/images/football_ground.png'),
    Sport(name: 'Tennis', image: 'assets/images/football_ground.png'),
    Sport(name: 'Cricket', image: 'assets/images/football_ground.png'),
    Sport(name: 'Badminton', image: 'assets/images/football_ground.png'),
    Sport(name: 'Swimming', image: 'assets/images/football_ground.png'),
    Sport(name: 'Volleyball', image: 'assets/images/football_ground.png'),
    Sport(name: 'Hockey', image: 'assets/images/football_ground.png'),

    // Second Set of Sports
    Sport(name: 'Golf', image: 'assets/images/football_ground.png'),
    Sport(name: 'Baseball', image: 'assets/images/baseball_court.jpg'),
    Sport(name: 'Cycling', image: 'assets/images/football_ground.png'),
    Sport(name: 'Running', image: 'assets/images/football_ground.png'),
    Sport(name: 'Boxing', image: 'assets/images/football_ground.png'),
    Sport(name: 'Wrestling', image: 'assets/images/football_ground.png'),
    Sport(name: 'Gymnastics', image: 'assets/images/football_ground.png'),
    Sport(name: 'Table Tennis', image: 'assets/images/football_ground.png'),

    // Third Set of Sports
    Sport(name: 'Martial Arts', image: 'assets/images/football_ground.png'),
    Sport(name: 'Rock Climbing', image: 'assets/images/football_ground.png'),
    Sport(name: 'Skateboarding', image: 'assets/images/football_ground.png'),
    Sport(name: 'Surfing', image: 'assets/images/football_ground.png'),
    Sport(name: 'Snowboarding', image: 'assets/images/football_ground.png'),
    Sport(name: 'Archery', image: 'assets/images/football_ground.png'),
    Sport(name: 'Bowling', image: 'assets/images/football_ground.png'),
    Sport(name: 'Fishing', image: 'assets/images/football_ground.png'),
  ];

  void toggleSport(String sportName) {
    setState(() {
      if (selectedSports.contains(sportName)) {
        selectedSports.remove(sportName);
      } else {
        selectedSports.add(sportName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          // Scrollable Sports Grid
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
                    itemCount: allSports.length,
                    itemBuilder: (context, index) {
                      final sport = allSports[index];
                      final isSelected = selectedSports.contains(sport.name);

                      return GestureDetector(
                        onTap: () => toggleSport(sport.name),
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
                                ? Theme.of(context).colorScheme.primaryContainer
                                : Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainer,
                          ),
                          child: Stack(
                            children: [
                              // Sport Icon
                              Align(
                                alignment: Alignment.center,
                                child: Image.asset(
                                  sport.image,
                                  fit: BoxFit.fill,
                                ),
                              ),

                              // Sport Name
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
                                        .withValues(alpha: 0.7),
                                  ),
                                  child: Text(
                                    sport.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),

                              // Selection Indicator
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

                  // Extra padding at bottom for continue button space
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),

      // Continue Button (appears when sports are selected)
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

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => const BottomNavBar(),
                          ),
                          (Route<dynamic> route) => false,
                        );
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
