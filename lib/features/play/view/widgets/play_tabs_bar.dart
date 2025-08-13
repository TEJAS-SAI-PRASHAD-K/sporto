import 'package:flutter/material.dart';

class PlayTabsBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const PlayTabsBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = ['Calendar', 'My Sports', 'Other Sports'];

    return Container(
      height: 54,
      color: Theme.of(context).colorScheme.surface,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(tabs.length, (i) {
            final selected = selectedIndex == i;
            return Padding(
              padding: const EdgeInsets.only(left: 16, right: 4),
              child: TextButton(
                onPressed: () => onTabSelected(i),
                style: TextButton.styleFrom(
                  foregroundColor: selected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: Text(tabs[i]),
              ),
            );
          }),
        ),
      ),
    );
  }
}
