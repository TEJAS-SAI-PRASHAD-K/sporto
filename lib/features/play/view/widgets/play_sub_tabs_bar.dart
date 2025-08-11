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

    return SizedBox(
      height: 48,
      child: Row(
        children: [
          for (int i = 0; i < subTabs.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: ChoiceChip(
                checkmarkColor: Theme.of(context).colorScheme.onPrimary,
                selected: selectedIndex == i,
                label: Text(
                  subTabs[i],
                  style: TextStyle(
                    color: selectedIndex == i
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onPrimaryFixedVariant,
                  ),
                ),
                selectedColor: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondaryFixedDim,
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
