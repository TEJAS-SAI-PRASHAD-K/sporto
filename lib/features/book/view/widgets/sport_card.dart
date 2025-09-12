import 'package:flutter/material.dart';

class SportCard extends StatelessWidget {
  const SportCard({super.key, required this.sport});
  final String sport;

  // A map of sports to icons
  static const Map<String, IconData> _sportIcons = {
    'badminton': Icons.sports_tennis,
    'football': Icons.sports_soccer,
    'cricket': Icons.sports_cricket,
    'tennis': Icons.sports_tennis,
    'basketball': Icons.sports_basketball,
    'hockey': Icons.sports_hockey,
    'volleyball': Icons.sports_volleyball,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Get the icon based on the sport name (default: sports icon)
    final icon = _sportIcons[sport] ?? Icons.sports;

    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: theme.dividerColor),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(
              sport,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
