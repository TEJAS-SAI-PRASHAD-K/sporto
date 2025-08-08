import 'package:flutter/material.dart';

enum OverlayDirection { right, left, top, bottom }

class CircularOverlayPage extends StatelessWidget {
  final List<String> labels;
  final List<String> imagePaths;
  final List<OverlayDirection> directions;

  const CircularOverlayPage({
    super.key,
    required this.labels,
    required this.imagePaths,
    required this.directions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 120,
          left: 30,
          child: CircularBubbleWithDirection(
            image: imagePaths[0],
            label: labels[0],
            direction: directions[0],
          ),
        ),
        Positioned(
          top: 80,
          right: 45,
          child: CircularBubbleWithDirection(
            image: imagePaths[1],
            label: labels[1],
            direction: directions[1],
          ),
        ),
        Positioned(
          bottom: 100,
          left: 30,
          child: CircularBubbleWithDirection(
            image: imagePaths[2],
            label: labels[2],
            direction: directions[2],
          ),
        ),
        Positioned(
          bottom: 80,
          right: 45,
          child: CircularBubbleWithDirection(
            image: imagePaths[3],
            label: labels[3],
            direction: directions[3],
          ),
        ),
      ],
    );
  }
}

class CircularBubbleWithDirection extends StatelessWidget {
  final String image;
  final String label;
  final OverlayDirection direction;

  const CircularBubbleWithDirection({
    super.key,
    required this.image,
    required this.label,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    final labelWidget = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
    );
    final avatarWidget = Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
      ),
      child: ClipOval(child: Image.asset(image, fit: BoxFit.fill)),
    );

    switch (direction) {
      case OverlayDirection.right:
        return Row(children: [avatarWidget, labelWidget]);
      case OverlayDirection.left:
        return Row(children: [labelWidget, avatarWidget]);
      case OverlayDirection.top:
        return Column(children: [labelWidget, avatarWidget]);
      case OverlayDirection.bottom:
        return Column(children: [avatarWidget, labelWidget]);
    }
  }
}
