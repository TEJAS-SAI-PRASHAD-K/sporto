import 'package:flutter/material.dart';
import 'package:playo/core/widgets/theme_switch_icon_button.dart';

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
  int currentSportsSet = 0; // 0 = initial 6, 1 = next 6, 2 = remaining sports

  final List<Sport> initialSports = [
    Sport(name: 'Football', image: 'assets/images/google_icon.png'),
    Sport(name: 'Basketball', image: 'assets/images/google_icon.png'),
    Sport(name: 'Tennis', image: 'assets/images/google_icon.png'),
    Sport(name: 'Cricket', image: 'assets/images/google_icon.png'),
    Sport(name: 'Badminton', image: 'assets/images/google_icon.png'),
    Sport(name: 'Swimming', image: 'assets/images/google_icon.png'),
    Sport(name: 'Volleyball', image: 'assets/images/google_icon.png'),
    Sport(name: 'Hockey', image: 'assets/images/google_icon.png'),
  ];

  final List<Sport> secondSports = [
    Sport(name: 'Golf', image: 'assets/images/google_icon.png'),
    Sport(name: 'Baseball', image: 'assets/images/google_icon.png'),
    Sport(name: 'Cycling', image: 'assets/images/google_icon.png'),
    Sport(name: 'Running', image: 'assets/images/google_icon.png'),
    Sport(name: 'Boxing', image: 'assets/images/google_icon.png'),
    Sport(name: 'Wrestling', image: 'assets/images/google_icon.png'),
    Sport(name: 'Gymnastics', image: 'assets/images/google_icon.png'),
    Sport(name: 'Table Tennis', image: 'assets/images/google_icon.png'),
  ];

  final List<Sport> thirdSports = [
    Sport(name: 'Martial Arts', image: 'assets/images/google_icon.png'),
    Sport(name: 'Rock Climbing', image: 'assets/images/google_icon.png'),
    Sport(name: 'Skateboarding', image: 'assets/images/google_icon.png'),
    Sport(name: 'Surfing', image: 'assets/images/google_icon.png'),
    Sport(name: 'Snowboarding', image: 'assets/images/google_icon.png'),
    Sport(name: 'Archery', image: 'assets/images/google_icon.png'),
    Sport(name: 'Bowling', image: 'assets/images/google_icon.png'),
    Sport(name: 'Fishing', image: 'assets/images/google_icon.png'),
  ];

  List<Sport> get currentSportsToShow {
    List<Sport> allSports = [];
    allSports.addAll(initialSports);

    if (currentSportsSet >= 1) {
      allSports.addAll(secondSports);
    }

    if (currentSportsSet >= 2) {
      allSports.addAll(thirdSports);
    }

    return allSports;
  }

  bool get hasMoreSports {
    return currentSportsSet < 2;
  }

  void toggleSport(String sportName) {
    setState(() {
      if (selectedSports.contains(sportName)) {
        selectedSports.remove(sportName);
      } else {
        selectedSports.add(sportName);
      }
    });
  }

  void showMoreSports() {
    setState(() {
      if (currentSportsSet < 2) {
        currentSportsSet++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      persistentFooterButtons: [
        if (hasMoreSports)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
              onPressed: showMoreSports,
              style: OutlinedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                side: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show More Sports',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.expand_more,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),

        if (hasMoreSports && selectedSports.isNotEmpty)
          const SizedBox(height: 12),

        if (selectedSports.isNotEmpty)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Selected sports: ${selectedSports.join(', ')}',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
      ],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom AppBar in body
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
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
                    ThemeSwitchIconButton(),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Sports wrap
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: currentSportsToShow.map((sport) {
                    final isSelected = selectedSports.contains(sport.name);

                    return GestureDetector(
                      onTap: () => toggleSport(sport.name),
                      child: Container(
                        width:
                            (MediaQuery.of(context).size.width - 48) /
                            2, // Responsive width
                        height: 150,
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
                                ).colorScheme.surfaceContainerLow,
                        ),
                        child: Stack(
                          children: [
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
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Theme.of(context)
                                      .colorScheme
                                      .surfaceContainerHighest
                                      .withValues(alpha: 0.5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      sport.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
