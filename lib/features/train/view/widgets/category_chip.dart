import 'package:flutter/material.dart';
import 'package:playo/features/train/model/service_category.dart';

class CategoryChip extends StatelessWidget {
  final ServiceCategory category;
  final VoidCallback? onTap;

  const CategoryChip({super.key, required this.category, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipBackground = theme.colorScheme.surfaceContainerHighest;
    final chipTextColor = theme.textTheme.bodyMedium?.color;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
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
              backgroundColor: Colors.transparent,
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
