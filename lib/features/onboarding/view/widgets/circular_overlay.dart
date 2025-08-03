import 'package:flutter/material.dart';

class CircularOverlayPage extends StatelessWidget {
  final List<String> labels;
  final List<String> imagePaths;

  const CircularOverlayPage({
    super.key,
    required this.labels,
    required this.imagePaths,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 80,
          left: 30,
          child: CircularLabel(label: labels[0], image: imagePaths[0]),
        ),
        Positioned(
          top: 80,
          right: 30,
          child: CircularLabel(label: labels[1], image: imagePaths[1]),
        ),
        Positioned(
          bottom: 180,
          left: 30,
          child: CircularLabel(label: labels[2], image: imagePaths[2]),
        ),
        Positioned(
          bottom: 180,
          right: 30,
          child: CircularLabel(label: labels[3], image: imagePaths[3]),
        ),
      ],
    );
  }
}

class CircularLabel extends StatelessWidget {
  final String label;
  final String image;

  const CircularLabel({super.key, required this.label, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: ClipOval(child: Image.asset(image)),
        ),
      ],
    );
  }
}
