import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/common/widgets/main_app_bar.dart';
import 'package:playo/core/providers/bottom_nav_provider.dart';
import 'package:playo/features/home/view/pages/groups_page.dart';
import 'package:playo/features/home/view/pages/weekly_fit_goal_page.dart';
import 'package:playo/features/more/view/pages/my_bookings_page.dart';
import 'package:playo/features/more/view/pages/playpals_page.dart';
import 'package:playo/features/more/view/pages/refer_and_earn_page.dart';
import '../widgets/create_game_card.dart';
import '../widgets/home_tile.dart';
import '../widgets/quick_action_tile.dart';
import '../widgets/spotlight_tile.dart';
import '../widgets/social_links_row.dart';
import '../widgets/refer_banner.dart';
import '../widgets/footer_section.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                tileColor: Theme.of(context).colorScheme.surfaceContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(9),
                ),
                leading: const Icon(
                  Icons.local_fire_department,
                  color: Colors.orange,
                  size: 35,
                ),
                title: const Text(
                  'Set your weekly fit goal',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Keep yourself fit!'),
                trailing: const Icon(Icons.chevron_right_rounded, size: 32),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WeeklyFitGoalPage(),
                    ),
                  );
                },
              ),
            ),
            const CreateGameCard(),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeTile(
                    img: 'assets/images/football_ground.png',
                    title: 'Play',
                    description: 'Find players and join their activities',
                    onTap: () {
                      ref.read(bottomNavIndexProvider.notifier).state = 0;
                    },
                  ),
                  HomeTile(
                    img: 'assets/images/baseball_court.jpg',
                    title: 'Book',
                    description: 'Book your slots in venues nearby',
                    onTap: () {
                      ref.read(bottomNavIndexProvider.notifier).state = 3;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: HomeTile(
                img: 'assets/images/tennis_court.png',
                title: 'Train With Us',
                description:
                    'Connect with certified coaches nearby to level up your game',
                onTap: () {
                  ref.read(bottomNavIndexProvider.notifier).state = 1;
                },
                isWide: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuickActionTile(
                    title: "Groups",
                    subtitle: "Connect",
                    icon: Icons.groups,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GroupsPage()),
                      );
                    },
                  ),
                  QuickActionTile(
                    title: "Bookings",
                    subtitle: "Game History",
                    icon: Icons.bookmark_border_rounded,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyBookingsPage(),
                        ),
                      );
                    },
                  ),
                  QuickActionTile(
                    title: "Playpals",
                    subtitle: "Manage Players",
                    icon: Icons.people_alt,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlaypalsPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 10,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Spotlight',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: SpotlightTile(
                            title: 'Play.\nRefer. Earn.\nRepeat.',
                            buttonLabel: 'Refer Now',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReferAndEarnPage(),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SpotlightTile(
                            title: 'Find Your\nCoach. Crush\nYour Goals.',
                            buttonLabel: 'Train Smarter',
                            onTap: () {
                              ref.read(bottomNavIndexProvider.notifier).state =
                                  1;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SocialLinksRow(),
            const ReferBanner(),
            const SizedBox(height: 24),
            const FooterSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
