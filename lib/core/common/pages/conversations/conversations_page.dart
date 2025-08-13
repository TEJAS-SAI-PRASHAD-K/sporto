import 'package:flutter/material.dart';
import 'game_tab.dart';
import 'group_tab.dart';
import 'playpals_tab.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  static const List<String> _tabs = ['Game', 'Group', 'Playpal[DMs]'];

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  int _selectedIndex = 0;

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return const GameTab();
      case 1:
        return const GroupTab();
      case 2:
        return const PlaypalsTab();
      default:
        return const GameTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Conversations',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              children: List.generate(ConversationsPage._tabs.length, (index) {
                final isSelected = _selectedIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => _selectedIndex = index),
                  child: Container(
                    margin: index < ConversationsPage._tabs.length - 1
                        ? const EdgeInsets.only(right: 24)
                        : EdgeInsets.zero,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          ConversationsPage._tabs[index],
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 3,
                          width: 75,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(child: _buildTabContent()),
        ],
      ),
    );
  }
}
