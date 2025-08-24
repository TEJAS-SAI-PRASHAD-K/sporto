import 'package:flutter/material.dart';
import 'package:playo/features/play/model/sub_tab.dart';

class PlaySubTabsBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final void Function(BuildContext ctx) onMenuPressed;
  final List<SubTab> items;

  const PlaySubTabsBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.onMenuPressed,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final subTabs = items;

    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  for (int i = 0; i < subTabs.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: ChoiceChip(
                        shape: StadiumBorder(
                          side: BorderSide(color: cs.outlineVariant),
                        ),
                        showCheckmark: false,
                        selected: selectedIndex == i,
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (subTabs[i].icon != null) ...[
                              Icon(
                                subTabs[i].icon,
                                size: 18,
                                color: selectedIndex == i
                                    ? cs.onPrimary
                                    : cs.onSurface,
                              ),
                              const SizedBox(width: 6),
                            ],
                            Text(
                              subTabs[i].label,
                              style: TextStyle(
                                color: selectedIndex == i
                                    ? cs.onPrimary
                                    : cs.onSurface,
                              ),
                            ),
                          ],
                        ),
                        selectedColor: cs.primary,
                        backgroundColor: cs.surface,
                        onSelected: (bool selected) {
                          if (selected) onTabSelected(i);
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
          Builder(
            builder: (ctx) => IconButton(
              icon: Icon(Icons.more_vert, color: cs.onSurface),
              onPressed: () => onMenuPressed(ctx),
            ),
          ),
        ],
      ),
    );
  }
}
