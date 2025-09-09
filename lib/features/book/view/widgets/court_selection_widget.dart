import 'package:flutter/material.dart';
import 'package:playo/core/models/venue.dart' as model;

class CourtSelectionWidget extends StatelessWidget {
  final List<model.Court> courts;
  final Set<String> selectedCourts;
  final Map<String, int> selectedCourtsWithDuration;
  final Set<String> unavailableCourts; // New parameter for unavailable courts
  final Function(String) onAddCourt;
  final Function(String) onRemoveCourt;
  final ColorScheme colorScheme;

  const CourtSelectionWidget({
    super.key,
    required this.courts,
    required this.selectedCourts,
    required this.selectedCourtsWithDuration,
    required this.unavailableCourts,
    required this.onAddCourt,
    required this.onRemoveCourt,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    final bookableCourts = courts.where((court) => court.isBookable).toList();

    return SingleChildScrollView(
      child: Column(
        children: bookableCourts.map((court) {
          final isSelected = selectedCourts.contains(court.id);
          final isUnavailable = unavailableCourts.contains(court.id);

          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            child: GestureDetector(
              onTap: isUnavailable
                  ? null // Disable tap for unavailable courts
                  : () => isSelected
                        ? onRemoveCourt(court.id)
                        : onAddCourt(court.id),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isUnavailable
                        ? colorScheme.outline.withValues(alpha: 0.3)
                        : isSelected
                        ? colorScheme.primary
                        : colorScheme.outlineVariant,
                    width: isSelected ? 2 : 1,
                  ),
                  borderRadius: BorderRadius.circular(8),
                  color: isUnavailable
                      ? colorScheme.surfaceContainer.withValues(alpha: 0.5)
                      : isSelected
                      ? colorScheme.primaryContainer.withValues(alpha: 0.3)
                      : colorScheme.surface,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  court.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: isUnavailable
                                        ? colorScheme.onSurface.withValues(
                                            alpha: 0.5,
                                          )
                                        : isSelected
                                        ? colorScheme.primary
                                        : colorScheme.onSurface,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              if (isUnavailable)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.errorContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    'Unavailable',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: colorScheme.onErrorContainer,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          if (court.description.isNotEmpty)
                            Text(
                              court.description,
                              style: TextStyle(
                                fontSize: 12,
                                color: isUnavailable
                                    ? colorScheme.onSurfaceVariant.withValues(
                                        alpha: 0.5,
                                      )
                                    : colorScheme.onSurfaceVariant,
                              ),
                            ),
                          Text(
                            '\$${(court.hourlyRate / 86.0).toStringAsFixed(2)}/hour',
                            style: TextStyle(
                              fontSize: 12,
                              color: isUnavailable
                                  ? colorScheme.onSurface.withValues(alpha: 0.5)
                                  : colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: isUnavailable
                          ? colorScheme.surfaceContainerHighest.withValues(
                              alpha: 0.5,
                            )
                          : colorScheme.surfaceContainerHighest,
                      child: Icon(
                        isUnavailable
                            ? Icons.block
                            : isSelected
                            ? Icons.remove
                            : Icons.add,
                        size: 16,
                        color: isUnavailable
                            ? colorScheme.onSurfaceVariant.withValues(
                                alpha: 0.5,
                              )
                            : colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
