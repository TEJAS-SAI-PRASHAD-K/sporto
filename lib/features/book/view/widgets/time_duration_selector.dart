import 'package:flutter/material.dart';

class TimeDurationSelector extends StatelessWidget {
  final TimeOfDay selectedTime;
  final int selectedDuration;
  final int minDuration;
  final int maxDuration;
  final int durationStep;
  final VoidCallback onTimeEdit;
  final VoidCallback? onDecreaseDuration;
  final VoidCallback onIncreaseDuration;
  final ColorScheme colorScheme;

  const TimeDurationSelector({
    super.key,
    required this.selectedTime,
    required this.selectedDuration,
    required this.minDuration,
    required this.maxDuration,
    required this.durationStep,
    required this.onTimeEdit,
    this.onDecreaseDuration,
    required this.onIncreaseDuration,
    required this.colorScheme,
  });

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                "TIME",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _formatTime(selectedTime),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: onTimeEdit,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                "DURATION",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurfaceVariant,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: selectedDuration > minDuration
                        ? onDecreaseDuration
                        : null,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: selectedDuration > minDuration
                          ? colorScheme.surfaceContainerHighest
                          : colorScheme.surfaceContainerHighest.withValues(
                              alpha: 0.3,
                            ),
                      child: Icon(
                        Icons.remove,
                        size: 16,
                        color: selectedDuration > minDuration
                            ? colorScheme.onSurfaceVariant
                            : colorScheme.onSurfaceVariant.withValues(
                                alpha: 0.3,
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "$selectedDuration min",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: onIncreaseDuration,
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      child: Icon(
                        Icons.add,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
