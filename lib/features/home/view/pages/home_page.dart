import 'package:flutter/material.dart';
import '../widgets/appbar.dart';
import '../widgets/weekly_goal_card.dart';
import '../widgets/create_game_card.dart';
import '../widgets/home_tile.dart';
import '../widgets/corporate_banner.dart';
import '../widgets/quick_action_tile.dart';
import '../widgets/spotlight_tile.dart';
import '../widgets/social_links_row.dart';
import '../widgets/refer_banner.dart';
import '../widgets/footer_section.dart';
import '../widgets/bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Simple navigation logic for demo purposes
    switch (index) {
      case 0:
        break; // Home, do nothing
      case 1:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('')));
        break;
      case 2:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('')));
        break;
      case 3:
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('')));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WeeklyGoalCard(),
            const CreateGameCard(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 6,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeTile(
                    img: 'assets/images/boy_avatar.png',
                    title: 'Play',
                    description: 'Find players and join their activities',
                    onTap: () => ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text(''))),
                  ),
                  HomeTile(
                    img: 'assets/images/boy_avatar.png',
                    title: 'Book',
                    description: 'Book your slots in venues nearby',
                    onTap: () => ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text(''))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: HomeTile(
                img: 'assets/images/boy_avatar.png',
                title: 'Train With Us',
                description:
                    'Connect with certified coaches nearby to level up your game',
                onTap: () => ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text(''))),
                isWide: true,
              ),
            ),
            const CorporateBanner(),
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
                    onTap: () {},
                  ),
                  QuickActionTile(
                    title: "Bookings",
                    subtitle: "Game History",
                    icon: Icons.bookmark_border_rounded,
                    onTap: () => ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text(''))),
                  ),
                  QuickActionTile(
                    title: "Playpals",
                    subtitle: "Manage Players",
                    icon: Icons.people_alt,
                    onTap: () => ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text(''))),
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
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
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
                          color: Theme.of(context).primaryColor,
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
                            img: 'assets/coins.png',
                            onTap: () => ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(const SnackBar(content: Text(''))),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SpotlightTile(
                            title: 'Find Your\nCoach. Crush\nYour Goals.',
                            buttonLabel: 'Train Smarter',
                            img: 'assets/whistle.png',
                            onTap: () => ScaffoldMessenger.of(
                              context,
                            ).showSnackBar(const SnackBar(content: Text(''))),
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
            const FooterSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _selectedIndex,
        onTabTapped: onTabTapped,
      ),
    );
  }
}
