import 'package:flutter/material.dart';

class CustomTimePicker {
  static Future<TimeOfDay?> showCustomTimePicker({
    required BuildContext context,
    required TimeOfDay initialTime,
    required List<TimeOfDay> availableSlots,
    required ColorScheme colorScheme,
  }) async {
    if (availableSlots.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('No available time slots for this date'),
          backgroundColor: colorScheme.error,
        ),
      );
      return null;
    }

    return await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: colorScheme.surface,
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              dayPeriodTextColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colorScheme.onPrimary;
                }
                return colorScheme.onSurface;
              }),
              dayPeriodColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colorScheme.primary;
                }
                return colorScheme.surface;
              }),
              hourMinuteTextColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colorScheme.onPrimary;
                }
                return colorScheme.onSurface;
              }),
              hourMinuteColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colorScheme.primary;
                }
                return colorScheme.surfaceContainerHighest;
              }),
              dialHandColor: colorScheme.primary,
              dialTextColor: WidgetStateColor.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return colorScheme.onPrimary;
                }
                return colorScheme.onSurface;
              }),
            ),
          ),
          child: TimePickerDialog(
            initialTime: initialTime,
            helpText: 'Select Available Time',
            hourLabelText: 'Hour',
            minuteLabelText: 'Minute',
            confirmText: 'SELECT',
            cancelText: 'CANCEL',
          ),
        );
      },
    ).then((selectedTime) {
      if (selectedTime == null) return null;

      // Check if selected time is in available slots
      final isAvailable = availableSlots.any(
        (slot) =>
            slot.hour == selectedTime.hour &&
            slot.minute == selectedTime.minute,
      );

      if (!isAvailable) {
        // Find closest available slot
        final selectedMinutes = selectedTime.hour * 60 + selectedTime.minute;
        TimeOfDay? closestSlot;
        int minDifference = double.maxFinite.toInt();

        for (final slot in availableSlots) {
          final slotMinutes = slot.hour * 60 + slot.minute;
          final difference = (slotMinutes - selectedMinutes).abs();
          if (difference < minDifference) {
            minDifference = difference;
            closestSlot = slot;
          }
        }

        if (closestSlot != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Selected time not available. Closest available time: ${_formatTime(closestSlot)} selected.',
              ),
              backgroundColor: colorScheme.primary,
            ),
          );
          return closestSlot;
        }
      }

      return selectedTime;
    });
  }

  static String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}
