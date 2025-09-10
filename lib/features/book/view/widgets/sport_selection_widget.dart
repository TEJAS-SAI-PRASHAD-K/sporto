import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SportSelectionWidget extends StatelessWidget {
  final String? sportName;
  final ColorScheme colorScheme;

  const SportSelectionWidget({
    super.key,
    required this.sportName,
    required this.colorScheme,
  });

  IconData _getSportIcon(String? sportName) {
    switch (sportName?.toLowerCase()) {
      case 'badminton':
        return Iconsax.location; // Replace with appropriate badminton icon
      case 'tennis':
        return Iconsax.location; // Replace with appropriate tennis icon
      case 'football':
        return Iconsax.location; // Replace with appropriate football icon
      case 'basketball':
        return Iconsax.location;
      case 'cricket':
        return Iconsax.location;
      default:
        return Iconsax.location;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getSportIcon(sportName),
              size: 40,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            sportName ?? 'Sport',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
