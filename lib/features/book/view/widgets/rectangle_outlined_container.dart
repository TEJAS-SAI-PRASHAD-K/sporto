import 'package:flutter/material.dart';

class RectangleOutlinedContainer extends StatelessWidget {
  final String text;

  const RectangleOutlinedContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        maxLines: 1,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}
