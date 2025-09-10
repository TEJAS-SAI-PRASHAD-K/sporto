import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SlotAvailabilityWidget extends StatelessWidget {
  final Map<String, dynamic> availabilityStatus;
  final VoidCallback? onAcceptSuggestion;
  final ColorScheme colorScheme;

  const SlotAvailabilityWidget({
    super.key,
    required this.availabilityStatus,
    required this.colorScheme,
    this.onAcceptSuggestion,
  });

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String _formatDate(DateTime date) {
    final today = DateTime.now();
    final tomorrow = today.add(const Duration(days: 1));

    if (DateUtils.isSameDay(date, today)) {
      return 'Today';
    } else if (DateUtils.isSameDay(date, tomorrow)) {
      return 'Tomorrow';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAvailable = availabilityStatus['isAvailable'] as bool;

    if (isAvailable) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colorScheme.primary.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: colorScheme.primary, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Slot is available for booking',
                style: TextStyle(
                  color: colorScheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Slot not available - show suggestion
    final nextTime = availabilityStatus['nextAvailableTime'] as TimeOfDay?;
    final nextDate = availabilityStatus['nextAvailableDate'] as DateTime?;
    final message = availabilityStatus['message'] as String;

    if (nextTime == null || nextDate == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colorScheme.error.withValues(alpha: 0.5),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(Icons.cancel, color: colorScheme.error, size: 16),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: colorScheme.error,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: colorScheme.tertiaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: colorScheme.tertiary.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: colorScheme.tertiary, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Selected slot is not available',
                  style: TextStyle(
                    color: colorScheme.tertiary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Next available: ${_formatTime(nextTime)} on ${_formatDate(nextDate)}',
                  style: TextStyle(
                    color: colorScheme.onTertiaryContainer,
                    fontSize: 11,
                  ),
                ),
              ),
              if (onAcceptSuggestion != null)
                TextButton(
                  onPressed: onAcceptSuggestion,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Use This',
                    style: TextStyle(
                      color: colorScheme.tertiary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
