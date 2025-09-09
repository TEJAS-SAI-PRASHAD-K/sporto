import 'package:flutter/material.dart';
import 'package:playo/features/book/view/widgets/venue_operating_hours.dart';

class SmartSlotSelector extends StatefulWidget {
  final DateTime selectedDate;
  final String openingHours;
  final String closingHours;
  final List<String> nonOperatingDays;
  final TimeOfDay selectedTime;
  final int selectedDuration;
  final Function(TimeOfDay) onTimeChanged;
  final Function(int) onDurationChanged;
  final ColorScheme colorScheme;
  final int minDuration;
  final int maxDuration;
  final int durationStep;

  const SmartSlotSelector({
    super.key,
    required this.selectedDate,
    required this.openingHours,
    required this.closingHours,
    required this.nonOperatingDays,
    required this.selectedTime,
    required this.selectedDuration,
    required this.onTimeChanged,
    required this.onDurationChanged,
    required this.colorScheme,
    this.minDuration = 30,
    this.maxDuration = 180,
    this.durationStep = 30,
  });

  @override
  State<SmartSlotSelector> createState() => _SmartSlotSelectorState();
}

class _SmartSlotSelectorState extends State<SmartSlotSelector> {
  List<TimeSlot> availableSlots = [];
  List<int> availableDurations = [];
  bool hasConflict = false;
  String conflictMessage = '';

  @override
  void initState() {
    super.initState();
    _generateAvailableSlots();
  }

  @override
  void didUpdateWidget(SmartSlotSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedDate != widget.selectedDate ||
        oldWidget.selectedTime != widget.selectedTime ||
        oldWidget.selectedDuration != widget.selectedDuration) {
      _generateAvailableSlots();
    }
  }

  void _generateAvailableSlots() {
    // Get current time and round to next 30-minute slot
    final now = TimeOfDay.now();
    final isToday = DateUtils.isSameDay(widget.selectedDate, DateTime.now());

    // Generate all possible time slots
    final allSlots = VenueOperatingHours.generateAvailableTimeSlots(
      openingHours: widget.openingHours,
      closingHours: widget.closingHours,
      nonOperatingDays: widget.nonOperatingDays,
      selectedDate: widget.selectedDate,
      slotIntervalMinutes: 30,
      minimumBookingDuration: widget.minDuration,
    );

    // Filter slots based on current time if today
    List<TimeOfDay> filteredSlots = allSlots;
    if (isToday) {
      // Round current time up to next 30-minute slot
      final currentMinutes = now.hour * 60 + now.minute;
      final nextSlotMinutes = ((currentMinutes + 29) ~/ 30) * 30;

      filteredSlots = allSlots.where((slot) {
        final slotMinutes = slot.hour * 60 + slot.minute;
        return slotMinutes >= nextSlotMinutes;
      }).toList();
    }

    // Create TimeSlot objects with availability info
    availableSlots = filteredSlots.map((time) {
      return TimeSlot(
        time: time,
        isAvailable: true, // We'll check conflicts separately
      );
    }).toList();

    // Generate available durations for current time
    _generateAvailableDurations();

    // Check for conflicts
    _checkForConflicts();
  }

  void _generateAvailableDurations() {
    availableDurations.clear();

    // Always generate duration options, even if no slots are available
    // This allows users to change duration to potentially find available slots

    // Calculate maximum possible duration from selected time to venue closing
    final selectedSlotMinutes =
        widget.selectedTime.hour * 60 + widget.selectedTime.minute;

    // Find venue closing time
    final closingTime = _parseTimeString(widget.closingHours);
    if (closingTime == null) {
      // If we can't parse closing time, still provide basic duration options
      for (
        int duration = widget.minDuration;
        duration <= widget.maxDuration;
        duration += widget.durationStep
      ) {
        availableDurations.add(duration);
      }
      return;
    }

    int closingMinutes = closingTime.hour * 60 + closingTime.minute;
    if (closingMinutes <= selectedSlotMinutes) {
      closingMinutes += 24 * 60; // Handle overnight venues
    }

    final maxPossibleMinutes = closingMinutes - selectedSlotMinutes;

    // Generate duration options based on venue hours, not arena availability
    for (
      int duration = widget.minDuration;
      duration <= widget.maxDuration && duration <= maxPossibleMinutes;
      duration += widget.durationStep
    ) {
      availableDurations.add(duration);
    }

    // Ensure we always have at least the minimum duration available
    if (availableDurations.isEmpty) {
      availableDurations.add(widget.minDuration);
    }
  }

  void _checkForConflicts() {
    hasConflict = false;
    conflictMessage = '';

    final selectedStartMinutes =
        widget.selectedTime.hour * 60 + widget.selectedTime.minute;
    final selectedEndMinutes = selectedStartMinutes + widget.selectedDuration;

    // Simple mock booking conflict - let's say 6:00 PM to 8:00 PM is booked
    const bookedStartMinutes = 18 * 60; // 6:00 PM
    const bookedEndMinutes = 20 * 60; // 8:00 PM

    // Check if selected slot overlaps with the booked slot
    if (selectedStartMinutes < bookedEndMinutes &&
        selectedEndMinutes > bookedStartMinutes) {
      hasConflict = true;
    }
  }

  TimeOfDay? _parseTimeString(String timeStr) {
    try {
      timeStr = timeStr.trim().toLowerCase();

      if (timeStr.isEmpty || timeStr.contains('closed')) {
        return null;
      }

      if (timeStr.contains('24') &&
          (timeStr.contains('7') || timeStr.contains('hour'))) {
        return const TimeOfDay(hour: 0, minute: 0);
      }

      timeStr = timeStr.replaceAll(RegExp(r'[^\d:apm\s]'), '');

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

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    if (availableSlots.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.colorScheme.error.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.info_outline,
              color: widget.colorScheme.onErrorContainer,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'No available slots for this date',
                style: TextStyle(
                  color: widget.colorScheme.onErrorContainer,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),

        // Time and Duration Row
        Row(
          children: [
            // Time Dropdown
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Time',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: widget.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: widget.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: widget.colorScheme.outline.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<TimeOfDay>(
                        value:
                            availableSlots.any(
                              (slot) =>
                                  slot.time.hour == widget.selectedTime.hour &&
                                  slot.time.minute ==
                                      widget.selectedTime.minute,
                            )
                            ? widget.selectedTime
                            : availableSlots.first.time,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: widget.colorScheme.onSurfaceVariant,
                        ),
                        items: availableSlots.map((slot) {
                          return DropdownMenuItem<TimeOfDay>(
                            value: slot.time,
                            child: Text(
                              _formatTime(slot.time),
                              style: TextStyle(
                                color: widget.colorScheme.onSurface,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (TimeOfDay? newTime) {
                          if (newTime != null) {
                            widget.onTimeChanged(newTime);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Duration Dropdown
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Duration',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: widget.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: widget.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: widget.colorScheme.outline.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value:
                            availableDurations.contains(widget.selectedDuration)
                            ? widget.selectedDuration
                            : availableDurations.isNotEmpty
                            ? availableDurations.first
                            : widget.minDuration,
                        isExpanded: true,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: widget.colorScheme.onSurfaceVariant,
                        ),
                        items: availableDurations.map((duration) {
                          return DropdownMenuItem<int>(
                            value: duration,
                            child: Text(
                              '${duration}min',
                              style: TextStyle(
                                color: widget.colorScheme.onSurface,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (int? newDuration) {
                          if (newDuration != null) {
                            widget.onDurationChanged(newDuration);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Availability Status Bar - only show when there's a conflict
        if (hasConflict) ...[
          const SizedBox(height: 16),
          _buildAvailabilityStatusBar(),
        ],
      ],
    );
  }

  Widget _buildAvailabilityStatusBar() {
    // Calculate end time
    final endTime = TimeOfDay(
      hour:
          (widget.selectedTime.hour * 60 +
              widget.selectedTime.minute +
              widget.selectedDuration) ~/
          60 %
          24,
      minute:
          (widget.selectedTime.hour * 60 +
              widget.selectedTime.minute +
              widget.selectedDuration) %
          60,
    );

    // Only show when there's a conflict (already booked)
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: widget.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: widget.colorScheme.error.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.warning,
            color: widget.colorScheme.onErrorContainer,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Time slot is already booked from ${_formatTime(widget.selectedTime)} to ${_formatTime(endTime)}',
              style: TextStyle(
                color: widget.colorScheme.onErrorContainer,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeSlot {
  final TimeOfDay time;
  final bool isAvailable;

  TimeSlot({required this.time, required this.isAvailable});
}
