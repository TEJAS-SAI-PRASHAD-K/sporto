import 'package:flutter/material.dart';

class VenueOperatingHours {
  static List<TimeOfDay> generateAvailableTimeSlots({
    required String openingHours,
    required String closingHours,
    required List<String> nonOperatingDays,
    required DateTime selectedDate,
    int slotIntervalMinutes = 30,
    int minimumBookingDuration = 30,
  }) {
    // Check if venue is closed on selected day
    final dayName = _getDayName(selectedDate.weekday);
    if (nonOperatingDays.contains(dayName.toLowerCase())) {
      return [];
    }

    final openTime = _parseTimeString(openingHours);
    final closeTime = _parseTimeString(closingHours);

    if (openTime == null || closeTime == null) {
      return _getDefaultTimeSlots();
    }

    return _generateSlotsFromTimes(
      openTime,
      closeTime,
      slotIntervalMinutes,
      minimumBookingDuration,
    );
  }

  static TimeOfDay? _parseTimeString(String timeStr) {
    try {
      timeStr = timeStr.trim().toLowerCase();

      // Handle "closed" or empty
      if (timeStr.isEmpty || timeStr.contains('closed')) {
        return null;
      }

      // Handle "24/7" or "24 hours"
      if (timeStr.contains('24') &&
          (timeStr.contains('7') || timeStr.contains('hour'))) {
        return const TimeOfDay(hour: 0, minute: 0);
      }

      // Remove common separators and text
      timeStr = timeStr.replaceAll(RegExp(r'[^\d:apm\s]'), '');

      // Handle AM/PM format
      final amPmMatch = RegExp(
        r'(\d{1,2}):?(\d{0,2})\s*(am|pm)',
      ).firstMatch(timeStr);
      if (amPmMatch != null) {
        int hour = int.parse(amPmMatch.group(1)!);
        int minute = amPmMatch.group(2)!.isEmpty
            ? 0
            : int.parse(amPmMatch.group(2)!);
        final isPm = amPmMatch.group(3) == 'pm';

        if (hour == 12) hour = 0;
        if (isPm) hour += 12;

        return TimeOfDay(hour: hour % 24, minute: minute);
      }

      // Handle 24-hour format
      final timeMatch = RegExp(r'(\d{1,2}):?(\d{0,2})').firstMatch(timeStr);
      if (timeMatch != null) {
        int hour = int.parse(timeMatch.group(1)!);
        int minute = timeMatch.group(2)!.isEmpty
            ? 0
            : int.parse(timeMatch.group(2)!);

        if (hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
          return TimeOfDay(hour: hour, minute: minute);
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  static List<TimeOfDay> _generateSlotsFromTimes(
    TimeOfDay openTime,
    TimeOfDay closeTime,
    int intervalMinutes,
    int minimumDuration,
  ) {
    final slots = <TimeOfDay>[];

    int openMinutes = openTime.hour * 60 + openTime.minute;
    int closeMinutes = closeTime.hour * 60 + closeTime.minute;

    // Handle overnight operation
    if (closeMinutes <= openMinutes) {
      closeMinutes += 24 * 60;
    }

    // Generate slots with interval - allow slots up to the point where
    // the minimum duration can still fit within operating hours
    for (
      int minutes = openMinutes;
      minutes <= closeMinutes - minimumDuration;
      minutes += intervalMinutes
    ) {
      final hour = (minutes ~/ 60) % 24;
      final minute = minutes % 60;
      slots.add(TimeOfDay(hour: hour, minute: minute));
    }

    return slots;
  }

  static List<TimeOfDay> _getDefaultTimeSlots() {
    // Default operating hours: 6 AM to 11 PM
    final slots = <TimeOfDay>[];
    for (int hour = 6; hour <= 22; hour++) {
      for (int minute = 0; minute < 60; minute += 30) {
        slots.add(TimeOfDay(hour: hour, minute: minute));
      }
    }
    return slots;
  }

  static String _getDayName(int weekday) {
    const days = [
      'monday',
      'tuesday',
      'wednesday',
      'thursday',
      'friday',
      'saturday',
      'sunday',
    ];
    return days[weekday - 1];
  }

  static bool isSlotAvailable(
    TimeOfDay slot,
    int duration,
    List<TimeOfDay> availableSlots,
  ) {
    // Check if the slot exists
    final slotExists = availableSlots.any(
      (available) =>
          available.hour == slot.hour && available.minute == slot.minute,
    );

    if (!slotExists) return false;

    // Check if duration fits within operating hours
    final slotMinutes = slot.hour * 60 + slot.minute;
    final endMinutes = slotMinutes + duration;

    if (availableSlots.isEmpty) return false;

    // Calculate the actual closing time based on available slots
    // The last slot should be able to accommodate the minimum booking duration
    final lastSlot = availableSlots.last;
    final lastSlotMinutes = lastSlot.hour * 60 + lastSlot.minute;

    // The booking can end at most 30 minutes after the last available slot
    // (since slots are generated every 30 minutes, this accounts for the venue's actual closing time)
    final maxEndTime =
        lastSlotMinutes + 60; // Allow for minimum booking duration

    return endMinutes <= maxEndTime;
  }

  static List<DateTime> generateAvailableDates({
    required DateTime startDate,
    required int numberOfDays,
    required List<String> nonOperatingDays,
  }) {
    final dates = <DateTime>[];
    DateTime currentDate = startDate;

    int addedDays = 0;
    int attempts = 0;
    final maxAttempts = numberOfDays * 2; // Prevent infinite loop

    while (addedDays < numberOfDays && attempts < maxAttempts) {
      final dayName = _getDayName(currentDate.weekday);

      // Only add if venue operates on this day
      if (!nonOperatingDays.contains(dayName.toLowerCase())) {
        dates.add(currentDate);
        addedDays++;
      }

      currentDate = currentDate.add(const Duration(days: 1));
      attempts++;
    }

    return dates;
  }

  static DateTime? findNextAvailableDate({
    required String openingHours,
    required String closingHours,
    required List<String> nonOperatingDays,
    required TimeOfDay desiredTime,
    required int duration,
    DateTime? startFromDate,
    int maxDaysToCheck = 30,
  }) {
    final searchStartDate = startFromDate ?? DateTime.now();

    for (int i = 0; i < maxDaysToCheck; i++) {
      final checkDate = searchStartDate.add(Duration(days: i));
      final dayName = _getDayName(checkDate.weekday);

      // Skip non-operating days
      if (nonOperatingDays.contains(dayName.toLowerCase())) {
        continue;
      }

      // Get available slots for this date
      final availableSlots = generateAvailableTimeSlots(
        openingHours: openingHours,
        closingHours: closingHours,
        nonOperatingDays: nonOperatingDays,
        selectedDate: checkDate,
        slotIntervalMinutes: 30,
        minimumBookingDuration: duration,
      );

      // Check if desired time is available on this date
      if (isSlotAvailable(desiredTime, duration, availableSlots)) {
        return checkDate;
      }
    }

    return null;
  }

  static TimeOfDay? findNextAvailableTime({
    required String openingHours,
    required String closingHours,
    required List<String> nonOperatingDays,
    required DateTime selectedDate,
    required int duration,
    TimeOfDay? startFromTime,
    int slotIntervalMinutes = 30,
  }) {
    final availableSlots = generateAvailableTimeSlots(
      openingHours: openingHours,
      closingHours: closingHours,
      nonOperatingDays: nonOperatingDays,
      selectedDate: selectedDate,
      slotIntervalMinutes: slotIntervalMinutes,
      minimumBookingDuration: duration,
    );

    if (availableSlots.isEmpty) return null;

    // If no start time provided, return first available slot
    if (startFromTime == null) {
      return availableSlots.first;
    }

    final startMinutes = startFromTime.hour * 60 + startFromTime.minute;

    // Find the next available slot from start time
    for (final slot in availableSlots) {
      final slotMinutes = slot.hour * 60 + slot.minute;
      if (slotMinutes >= startMinutes &&
          isSlotAvailable(slot, duration, availableSlots)) {
        return slot;
      }
    }

    return null;
  }

  static Map<String, dynamic> checkSlotAvailability({
    required String openingHours,
    required String closingHours,
    required List<String> nonOperatingDays,
    required DateTime selectedDate,
    required TimeOfDay selectedTime,
    required int duration,
  }) {
    final availableSlots = generateAvailableTimeSlots(
      openingHours: openingHours,
      closingHours: closingHours,
      nonOperatingDays: nonOperatingDays,
      selectedDate: selectedDate,
      slotIntervalMinutes: 30,
      minimumBookingDuration: duration,
    );

    final isAvailable = isSlotAvailable(selectedTime, duration, availableSlots);

    if (isAvailable) {
      return {'isAvailable': true, 'message': 'Slot is available'};
    }

    // Find next available time on same date
    final nextTimeToday = findNextAvailableTime(
      openingHours: openingHours,
      closingHours: closingHours,
      nonOperatingDays: nonOperatingDays,
      selectedDate: selectedDate,
      duration: duration,
      startFromTime: selectedTime,
    );

    if (nextTimeToday != null) {
      return {
        'isAvailable': false,
        'message': 'Slot not available',
        'nextAvailableTime': nextTimeToday,
        'nextAvailableDate': selectedDate,
      };
    }

    // Find next available date
    final nextAvailableDate = findNextAvailableDate(
      openingHours: openingHours,
      closingHours: closingHours,
      nonOperatingDays: nonOperatingDays,
      desiredTime: selectedTime,
      duration: duration,
      startFromDate: selectedDate.add(const Duration(days: 1)),
    );

    if (nextAvailableDate != null) {
      return {
        'isAvailable': false,
        'message': 'Slot not available',
        'nextAvailableTime': selectedTime,
        'nextAvailableDate': nextAvailableDate,
      };
    }

    return {
      'isAvailable': false,
      'message': 'No available slots found in the next 30 days',
    };
  }
}
