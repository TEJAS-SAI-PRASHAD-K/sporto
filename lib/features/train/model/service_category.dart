import 'package:flutter/material.dart';

/// Represents a top category tile like Badminton, Swimming, etc.
class ServiceCategory {
  final String id;
  final String name;
  final String imageAsset;
  final Color background;

  const ServiceCategory({
    required this.id,
    required this.name,
    required this.imageAsset,
    required this.background,
  });

  /// Generate a beautiful color based on category name
  static Color generateColorForCategory(String categoryName) {
    // Create a hash from the category name
    int hash = categoryName.hashCode;

    // Define beautiful color palettes
    final List<Color> beautifulColors = [
      const Color(0xFFFFB3BA), // Light pink
      const Color(0xFFFFDFBA), // Light peach
      const Color(0xFFFFFFBA), // Light yellow
      const Color(0xFFBAFFBA), // Light green
      const Color(0xFFBAE1FF), // Light blue
      const Color(0xFFE1BAFF), // Light purple
      const Color(0xFFFFBAE1), // Light magenta
      const Color(0xFFBAFFE1), // Light mint
      const Color(0xFFE1FFBA), // Light lime
      const Color(0xFFFFE1BA), // Light orange
      const Color(0xFFBAFFFF), // Light cyan
      const Color(0xFFFFBAFF), // Light fuchsia
    ];

    // Use hash to select a color from the palette
    return beautifulColors[hash.abs() % beautifulColors.length];
  }
}
