import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  const BottomBar({super.key, required this.selectedIndex, required this.onTabTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 13,
      unselectedFontSize: 13,
      selectedItemColor: Color(0xFF007AFF),
      unselectedItemColor: Colors.grey[600],
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Play'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Book'),
        BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'More'),
      ],
      currentIndex: selectedIndex,
      onTap: onTabTapped,
    );
  }
}
