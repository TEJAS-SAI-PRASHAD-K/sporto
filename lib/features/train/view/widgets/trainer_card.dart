import 'package:flutter/material.dart';
import 'package:playo/core/models/trainer.dart' as model;

class TrainerCard extends StatelessWidget {
  final model.Datum datum;
  final VoidCallback? onTap;

  const TrainerCard({super.key, required this.datum, this.onTap});

  @override
  Widget build(BuildContext context) {
    final t = datum.trainer;
    final avatarUrl = t.avatar.isNotEmpty ? t.avatar.first : null;
    final tags = const ["Trainer"];

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: avatarUrl != null
                        ? Image.network(avatarUrl, fit: BoxFit.cover)
                        : Container(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainer,
                          ),
                  ),
                ),
                if (tags.isNotEmpty)
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        tags.join(' • '),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          letterSpacing: .2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${t.firstName} ${t.lastName}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    // location fields are not present on this model; using service location if available
                    t.serviceVenue,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    t.audienceTypes.join(', '),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        t.rating != 0 ? Icons.star : Icons.star_border,
                        size: 18,
                        color: t.rating != 0
                            ? Colors.amber
                            : Theme.of(context).colorScheme.outline,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        t.rating != 0
                            ? '${t.rating.toStringAsFixed(1)} (${t.totalReviews} Ratings)'
                            : '--',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
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
