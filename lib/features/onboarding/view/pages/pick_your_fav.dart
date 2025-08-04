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
  ];

  final List<Sport> secondSports = [
    Sport(name: 'Volleyball', image: 'assets/images/google_icon.png'),
    Sport(name: 'Hockey', image: 'assets/images/google_icon.png'),
    Sport(name: 'Golf', image: 'assets/images/google_icon.png'),
    Sport(name: 'Baseball', image: 'assets/images/google_icon.png'),
    Sport(name: 'Cycling', image: 'assets/images/google_icon.png'),
    Sport(name: 'Running', image: 'assets/images/google_icon.png'),
  ];

  final List<Sport> thirdSports = [
    Sport(name: 'Boxing', image: 'assets/images/google_icon.png'),
    Sport(name: 'Wrestling', image: 'assets/images/google_icon.png'),
    Sport(name: 'Gymnastics', image: 'assets/images/google_icon.png'),
    Sport(name: 'Table Tennis', image: 'assets/images/google_icon.png'),
    Sport(name: 'Martial Arts', image: 'assets/images/google_icon.png'),
    Sport(name: 'Rock Climbing', image: 'assets/images/google_icon.png'),
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
                          borderRadius: BorderRadius.circular(16),
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
                            color: isSelected ? Colors.blue : Colors.grey,
                            width: isSelected ? 3 : 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
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
              const SizedBox(height: 100), // Add space for BottomAppBar
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasMoreSports)
              OutlinedButton(
                onPressed: () {
                  showMoreSports();
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Show More Sports', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 8),
                    Icon(Icons.expand_more),
                  ],
                ),
              ),
            // if (selectedSports.isNotEmpty)
            //   Padding(
            //     padding: EdgeInsets.only(top: hasMoreSports ? 12 : 0),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         // TODO: Handle continue with selected sports
            //         ScaffoldMessenger.of(context).showSnackBar(
            //           SnackBar(
            //             content: Text(
            //               'Selected sports: ${selectedSports.join(', ')}',
            //             ),
            //           ),
            //         );
            //       },
            //       style: ElevatedButton.styleFrom(
            //         minimumSize: const Size(double.infinity, 50),
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(12),
            //         ),
            //       ),
            //       child: Text(
            //         'Continue (${selectedSports.length} selected)',
            //         style: const TextStyle(fontSize: 16),
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
