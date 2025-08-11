import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:playo/core/providers/bottom_nav_provider.dart';
import 'package:playo/features/book/view/pages/book_page.dart';
import 'package:playo/features/train/view/pages/train_page.dart';
import 'package:playo/features/home/view/pages/home_page.dart';
import 'package:playo/features/more/view/pages/more_page.dart';
import 'package:playo/features/play/view/pages/play_page.dart';

class BottomNavBar extends ConsumerStatefulWidget {
  const BottomNavBar({super.key});

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends ConsumerState<BottomNavBar> {
  @override
  void initState() {
    super.initState();
  }

  List<Widget> _buildPages() {
    return [
      const TrainPage(),
      const PlayPage(),
      const HomePage(),
      const BookPage(),
      const MorePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(bottomNavIndexProvider);

    return PopScope(
      canPop: currentIndex == 2,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && currentIndex != 2) {
          ref.read(bottomNavIndexProvider.notifier).state = 2;
        }
      },
      child: Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: IndexedStack(
            key: ValueKey(currentIndex),
            index: currentIndex,
            children: _buildPages(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedFontSize: 14,
          currentIndex: currentIndex,
          onTap: (index) {
            ref.read(bottomNavIndexProvider.notifier).state = index;
          },
          items: [
            BottomNavigationBarItem(
              icon: _buildNavIcon(Iconsax.play, 1),
              activeIcon: _buildActiveIcon(Iconsax.play, 1),
              label: "Play",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Iconsax.user, 2),
              activeIcon: _buildActiveIcon(Iconsax.user, 2),
              label: "Train",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Iconsax.home, 0),
              activeIcon: _buildActiveIcon(Iconsax.home, 0),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Iconsax.book, 3),
              activeIcon: _buildActiveIcon(Iconsax.book, 3),
              label: "Book",
            ),
            BottomNavigationBarItem(
              icon: _buildNavIcon(Iconsax.more, 4),
              activeIcon: _buildActiveIcon(Iconsax.more, 4),
              label: "More",
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onSurface,
          backgroundColor: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    return Container(
      height: 40,
      width: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Icon(icon),
    );
  }

  Widget _buildActiveIcon(IconData icon, int index) {
    return Container(
      height: 40,
      width: 60,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Icon(icon),
    );
  }
}
