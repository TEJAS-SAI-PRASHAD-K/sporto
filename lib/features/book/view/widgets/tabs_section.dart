import 'package:flutter/material.dart';
import '../../model/tab_item.dart';

class TabsSection extends StatelessWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const TabsSection({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: tabs.asMap().entries.map((entry) {
              final index = entry.key;
              final tab = entry.value;
              final isSelected = tab.isSelected;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onTabSelected(index),
                  child: Column(
                    children: [
                      Text(
                        '${tab.title} (${tab.count})',
                        style: TextStyle(
                          color: isSelected
                              ? const Color(0xFF4CAF50)
                              : const Color(0xFF757575),
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF4CAF50)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Container(height: 1, color: const Color(0xFFE0E0E0)),
      ],
    );
  }
}
