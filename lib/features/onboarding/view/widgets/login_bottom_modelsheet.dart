import 'package:flutter/material.dart';

void showCustomModelSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    builder: (context) => const CustomModelContent(),
  );
}

class CustomModelContent extends StatelessWidget {
  const CustomModelContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(height: 50, color: Colors.red),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('data'),
        ),
        Container(height: 50, color: Colors.pink),
      ],
    );
  }
}


