import 'package:flutter/material.dart';

/// A simple summary bar shown below app bars in Play flows.
/// Displays a single centered line of text with a bottom border.
class GameSubTabBar extends StatelessWidget {
  final String text;
  const GameSubTabBar({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w600),
      ),
    );
  }
}
