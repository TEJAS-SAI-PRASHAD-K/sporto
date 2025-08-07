import 'package:flutter/material.dart';
import 'package:playo/core/widgets/bottom_navigation_bar.dart';
import 'package:playo/features/onboarding/view/pages/avatar.dart';

class PickYourFavPage extends StatefulWidget {
  const PickYourFavPage({super.key});

  @override
  State<PickYourFavPage> createState() => _PickYourFavPageState();
}

class Sport {
  final String name;
  final String image;

  Sport({required this.name, required this.image});
}

class _PickYourFavPageState extends State<PickYourFavPage> {
  List<String> selectedSports = [];

  final List<Sport> allSports = [
    // Initial Sports
    Sport(name: 'Football', image: 'assets/images/google_icon.png'),
    Sport(name: 'Basketball', image: 'assets/images/google_icon.png'),
    Sport(name: 'Tennis', image: 'assets/images/google_icon.png'),
    Sport(name: 'Cricket', image: 'assets/images/google_icon.png'),
    Sport(name: 'Badminton', image: 'assets/images/google_icon.png'),
    Sport(name: 'Swimming', image: 'assets/images/google_icon.png'),
    Sport(name: 'Volleyball', image: 'assets/images/google_icon.png'),
    Sport(name: 'Hockey', image: 'assets/images/google_icon.png'),

    // Second Set of Sports
    Sport(name: 'Golf', image: 'assets/images/google_icon.png'),
    Sport(name: 'Baseball', image: 'assets/images/google_icon.png'),
    Sport(name: 'Cycling', image: 'assets/images/google_icon.png'),
    Sport(name: 'Running', image: 'assets/images/google_icon.png'),
    Sport(name: 'Boxing', image: 'assets/images/google_icon.png'),
    Sport(name: 'Wrestling', image: 'assets/images/google_icon.png'),
    Sport(name: 'Gymnastics', image: 'assets/images/google_icon.png'),
    Sport(name: 'Table Tennis', image: 'assets/images/google_icon.png'),

    // Third Set of Sports
    Sport(name: 'Martial Arts', image: 'assets/images/google_icon.png'),
    Sport(name: 'Rock Climbing', image: 'assets/images/google_icon.png'),
    Sport(name: 'Skateboarding', image: 'assets/images/google_icon.png'),
    Sport(name: 'Surfing', image: 'assets/images/google_icon.png'),
    Sport(name: 'Snowboarding', image: 'assets/images/google_icon.png'),
    Sport(name: 'Archery', image: 'assets/images/google_icon.png'),
    Sport(name: 'Bowling', image: 'assets/images/google_icon.png'),
    Sport(name: 'Fishing', image: 'assets/images/google_icon.png'),
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
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => Avatar()),
                      );
                    },
                    icon: const Icon(Icons.arrow_back, size: 30),
                    style: IconButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Pick Your Favorites',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),

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
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerLow,
                            ),
                            child: Stack(
                              children: [
                                // Sport Icon
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding: const EdgeInsets.all(9),
                                    child: Image.asset(
                                      sport.image,
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.contain,
                                    ),
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
                                          .surfaceContainerHighest
                                          .withValues(alpha: 0.7),
                                    ),
                                    child: Text(
                                      sport.name,
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
      ),

      // Continue Button (appears when sports are selected)
      bottomNavigationBar: selectedSports.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => BottomNavBar()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Selected sports: ${selectedSports.join(', ')}',
                          ),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
