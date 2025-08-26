import 'package:flutter/material.dart';
import 'package:playo/features/train/model/service_category.dart';

class CategoryChip extends StatelessWidget {
  final ServiceCategory category;
  final VoidCallback? onTap;

  const CategoryChip({super.key, required this.category, this.onTap});

  /// Get appropriate text color based on background brightness
  Color _getTextColor(Color backgroundColor, BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    // Calculate contrast ratio and choose the best color
    final onSurfaceContrast = _calculateContrast(
      backgroundColor,
      colorScheme.onSurface,
    );
    final surfaceContrast = _calculateContrast(
      backgroundColor,
      colorScheme.surface,
    );
    final onPrimaryContrast = _calculateContrast(
      backgroundColor,
      colorScheme.onPrimary,
    );
    final primaryContrast = _calculateContrast(
      backgroundColor,
      colorScheme.primary,
    );

    // Return the color with the highest contrast
    final contrasts = [
      (onSurfaceContrast, colorScheme.onSurface),
      (surfaceContrast, colorScheme.surface),
      (onPrimaryContrast, colorScheme.onPrimary),
      (primaryContrast, colorScheme.primary),
    ];

    contrasts.sort((a, b) => b.$1.compareTo(a.$1));
    return contrasts.first.$2;
  }

  /// Calculate contrast ratio between two colors
  double _calculateContrast(Color color1, Color color2) {
    final lum1 = _calculateLuminance(color1);
    final lum2 = _calculateLuminance(color2);
    final brightest = lum1 > lum2 ? lum1 : lum2;
    final darkest = lum1 > lum2 ? lum2 : lum1;
    return (brightest + 0.05) / (darkest + 0.05);
  }

  /// Calculate luminance of a color
  double _calculateLuminance(Color color) {
    final r = color.r;
    final g = color.g;
    final b = color.b;
    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipBackground = category.background;
    final chipTextColor = _getTextColor(chipBackground, context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: Container(
        width: 92,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: chipBackground,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(category.imageAsset),
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: chipTextColor,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
