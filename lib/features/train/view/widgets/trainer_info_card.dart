import 'package:flutter/material.dart';
import 'package:playo/features/train/model/trainer.dart';

class TrainerInfoCard extends StatelessWidget {
  final Trainer trainer;

  const TrainerInfoCard({super.key, required this.trainer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(trainer.avatarAsset),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        trainer.rating != null ? Icons.star : Icons.star_border,
                        size: 18,
                        color: trainer.rating != null
                            ? Colors.amber
                            : colorScheme.outline,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        trainer.rating != null ? '${trainer.rating}' : '--',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (trainer.rating != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          '(${trainer.ratingCount})',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.outline,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${trainer.interestedCount} interested',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
