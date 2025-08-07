import 'package:flutter/material.dart';

class PlaySubTabsBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final void Function(BuildContext ctx) onMenuPressed;

  const PlaySubTabsBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    final subTabs = ['Upcoming', 'Past'];

    return Container(
      height: 48,
      color: Colors.white,
      child: Row(
        children: [
          for (int i = 0; i < subTabs.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ChoiceChip(
                selected: selectedIndex == i,
                label: Text(
                  subTabs[i],
                  style: TextStyle(
                    color: selectedIndex == i ? Colors.white : Colors.black,
                  ),
                ),
                selectedColor: Colors.green,
                backgroundColor: const Color(0xFFF2F3F4),
                onSelected: (_) => onTabSelected(i),
              ),
            ),
          const Spacer(),
          Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onPressed: () => onMenuPressed(ctx),
            ),
          ),
        ],
      ),
    );
  }
}
