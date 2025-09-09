import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/models/venue.dart' as model;
import 'package:playo/features/book/viewmodel/venue_view_model.dart';
import 'package:playo/features/book/view/widgets/sport_selection_widget.dart';
import 'package:playo/features/book/view/widgets/date_picker_widget.dart';
import 'package:playo/features/book/view/widgets/court_selection_widget.dart';
import 'package:playo/features/book/view/widgets/booking_summary_widget.dart';
import 'package:playo/features/book/view/widgets/venue_operating_hours.dart';
import 'package:playo/features/book/view/widgets/smart_slot_selector.dart';
import 'package:playo/features/book/view/pages/payment_check_page.dart';

class BookSlotPage extends ConsumerStatefulWidget {
  final String venueId;
  final String? sportName;

  const BookSlotPage({super.key, required this.venueId, this.sportName});

  @override
  ConsumerState<BookSlotPage> createState() => _BookSlotPageState();
}

class _BookSlotPageState extends ConsumerState<BookSlotPage> {
  int selectedDateIndex = 0;
  late TimeOfDay selectedTime;
  int selectedDuration = 60;
  Set<String> selectedCourts = {};
  Set<String> unavailableCourts = {}; // Track unavailable courts

  List<DateTime> availableDates = [];
  List<TimeOfDay> availableTimeSlots = [];
  Map<String, dynamic>? availabilityStatus;

  // Dynamic configuration from venue data
  int minDuration = 30;
  int maxDuration = 180;
  int durationStep = 30;
  String currency = '\$';

  @override
  void initState() {
    super.initState();
    // Initialize with current time rounded to next 30-minute slot
    _initializeCurrentTime();
  }

  void _initializeCurrentTime() {
    final now = TimeOfDay.now();
    final currentMinutes = now.hour * 60 + now.minute;
    // Round up to next 30-minute slot
    final nextSlotMinutes = ((currentMinutes + 29) ~/ 30) * 30;
    selectedTime = TimeOfDay(
      hour: (nextSlotMinutes ~/ 60) % 24,
      minute: nextSlotMinutes % 60,
    );
  }

  void _initializeFromVenueData(model.Datum venueData) {
    // Initialize available dates based on venue operating days
    availableDates = VenueOperatingHours.generateAvailableDates(
      startDate: DateTime.now(),
      numberOfDays: 30, // Next 30 available days
      nonOperatingDays: venueData.venue.nonOperatingDays,
    );

    // Initialize available time slots based on venue operating hours
    if (availableDates.isNotEmpty) {
      final selectedDate = availableDates[selectedDateIndex];
      availableTimeSlots = VenueOperatingHours.generateAvailableTimeSlots(
        openingHours: venueData.venue.openingHours,
        closingHours: venueData.venue.closingHours,
        nonOperatingDays: venueData.venue.nonOperatingDays,
        selectedDate: selectedDate,
        slotIntervalMinutes: durationStep,
        minimumBookingDuration: minDuration,
      );

      // Set initial time to first available slot if current time is not available
      if (availableTimeSlots.isNotEmpty &&
          !availableTimeSlots.any(
            (slot) =>
                slot.hour == selectedTime.hour &&
                slot.minute == selectedTime.minute,
          )) {
        selectedTime = availableTimeSlots.first;
      }
    }

    // Get currency from court data
    if (venueData.court.isNotEmpty) {
      currency = venueData.court.first.currency;
    }

    // Check initial availability
    _checkSlotAvailability(venueData);
  }

  void _checkSlotAvailability(model.Datum venueData) {
    if (availableDates.isEmpty) return;

    final selectedDate = availableDates[selectedDateIndex];
    availabilityStatus = VenueOperatingHours.checkSlotAvailability(
      openingHours: venueData.venue.openingHours,
      closingHours: venueData.venue.closingHours,
      nonOperatingDays: venueData.venue.nonOperatingDays,
      selectedDate: selectedDate,
      selectedTime: selectedTime,
      duration: selectedDuration,
    );

    // Check court availability and update unavailable courts
    _updateUnavailableCourts(venueData);
  }

  void _updateUnavailableCourts(model.Datum venueData) {
    final newUnavailableCourts = <String>{};

    // Check each court for availability
    for (final court in venueData.court) {
      if (_isCourtUnavailable(court)) {
        newUnavailableCourts.add(court.id);
      }
    }

    unavailableCourts = newUnavailableCourts;

    // Debug info for development (can be removed in production)
    if (newUnavailableCourts.isNotEmpty) {
      debugPrint(
        'Unavailable courts: ${newUnavailableCourts.length} out of ${venueData.court.length}',
      );
    }

    // Remove any selected courts that are now unavailable
    selectedCourts.removeWhere(
      (courtId) => unavailableCourts.contains(courtId),
    );
  }

  bool _isCourtUnavailable(model.Court court) {
    // Enhanced logic to work for venues with any number of arenas
    // This would be replaced with real booking data in production

    final selectedStartMinutes = selectedTime.hour * 60 + selectedTime.minute;
    final selectedEndMinutes = selectedStartMinutes + selectedDuration;
    final selectedDate = availableDates[selectedDateIndex];

    // Get court index (first court = 0, second court = 1, etc.)
    final venueState = ref.read(venueViewModelProvider).valueOrNull;
    if (venueState == null) return false;

    final venueData = venueState.data.firstWhere(
      (datum) => datum.venue.id == widget.venueId,
      orElse: () => venueState.data.first,
    );

    final courtIndex = venueData.court.indexWhere((c) => c.id == court.id);
    if (courtIndex == -1) return false;

    // Mock unavailability rules for any venue:

    // Rule 1: First arena/court (index 0) is unavailable during 6-8 PM
    if (courtIndex == 0) {
      const bookedStartMinutes = 18 * 60; // 6:00 PM
      const bookedEndMinutes = 20 * 60; // 8:00 PM

      if (selectedStartMinutes < bookedEndMinutes &&
          selectedEndMinutes > bookedStartMinutes) {
        return true;
      }
    }

    // Rule 2: Second arena/court (index 1) is unavailable on weekends
    if (courtIndex == 1) {
      if (selectedDate.weekday == DateTime.saturday ||
          selectedDate.weekday == DateTime.sunday) {
        return true;
      }
    }

    // Rule 3: Third arena/court (index 2) is unavailable during lunch hours (12-2 PM)
    if (courtIndex == 2) {
      const lunchStartMinutes = 12 * 60; // 12:00 PM
      const lunchEndMinutes = 14 * 60; // 2:00 PM

      if (selectedStartMinutes < lunchEndMinutes &&
          selectedEndMinutes > lunchStartMinutes) {
        return true;
      }
    }

    // Rule 4: For venues with only one arena, apply special logic
    if (venueData.court.length == 1) {
      // Single arena is unavailable on Mondays from 10 AM - 12 PM (maintenance)
      if (selectedDate.weekday == DateTime.monday) {
        const maintenanceStartMinutes = 10 * 60; // 10:00 AM
        const maintenanceEndMinutes = 12 * 60; // 12:00 PM

        if (selectedStartMinutes < maintenanceEndMinutes &&
            selectedEndMinutes > maintenanceStartMinutes) {
          return true;
        }
      }
    }

    // Rule 5: Any arena is unavailable during very early morning (before 6 AM)
    if (selectedStartMinutes < 6 * 60) {
      // Before 6:00 AM
      return true;
    }

    return false;
  }

  void _onTimeChanged(TimeOfDay newTime) {
    setState(() {
      selectedTime = newTime;

      // Check availability for new time and update unavailable courts
      final venueState = ref.read(venueViewModelProvider).valueOrNull;
      if (venueState != null) {
        final venueData = venueState.data.firstWhere(
          (datum) => datum.venue.id == widget.venueId,
          orElse: () => venueState.data.first,
        );
        _checkSlotAvailability(venueData);
      }
    });
  }

  void _onDurationChanged(int newDuration) {
    setState(() {
      selectedDuration = newDuration;

      // Check availability for new duration and update unavailable courts
      final venueState = ref.read(venueViewModelProvider).valueOrNull;
      if (venueState != null) {
        final venueData = venueState.data.firstWhere(
          (datum) => datum.venue.id == widget.venueId,
          orElse: () => venueState.data.first,
        );
        _checkSlotAvailability(venueData);
      }
    });
  }

  void _onDateSelected(int index) {
    setState(() {
      selectedDateIndex = index;
      // Regenerate time slots for new date
      if (availableDates.isNotEmpty) {
        final selectedDate = availableDates[selectedDateIndex];
        final venueState = ref.read(venueViewModelProvider).valueOrNull;
        if (venueState != null) {
          final venueData = venueState.data.firstWhere(
            (datum) => datum.venue.id == widget.venueId,
            orElse: () => venueState.data.first,
          );
          availableTimeSlots = VenueOperatingHours.generateAvailableTimeSlots(
            openingHours: venueData.venue.openingHours,
            closingHours: venueData.venue.closingHours,
            nonOperatingDays: venueData.venue.nonOperatingDays,
            selectedDate: selectedDate,
            slotIntervalMinutes: durationStep,
            minimumBookingDuration: minDuration,
          );

          // If changing from today to another day, reset time to first available slot
          final isToday = DateUtils.isSameDay(selectedDate, DateTime.now());
          if (!isToday && availableTimeSlots.isNotEmpty) {
            selectedTime = availableTimeSlots.first;
          } else if (isToday) {
            // For today, set to next available 30-minute slot
            _initializeCurrentTime();
          }

          // Check availability for new date
          _checkSlotAvailability(venueData);
        }
      }
    });
  }

  void _addCourt(String courtId) {
    // Don't add courts that are unavailable
    if (unavailableCourts.contains(courtId)) return;

    setState(() {
      selectedCourts.add(courtId);
    });
  }

  void _removeCourt(String courtId) {
    setState(() {
      selectedCourts.remove(courtId);
    });
  }

  double _calculateTotalPrice(List<model.Court> selectedCourtsList) {
    double total = 0.0;
    for (final court in selectedCourtsList) {
      // Convert to USD pricing (rate adjusted for USD conversion)
      final priceInDollars = court.hourlyRate / 86.0;
      total += (priceInDollars * selectedDuration) / 60.0;
    }
    return total;
  }

  void _addToBooking(model.Datum venueData) {
    if (selectedCourts.isEmpty) return;

    // Check if slot is available before booking
    if (availabilityStatus != null &&
        !(availabilityStatus!['isAvailable'] as bool)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Selected slot is not available. Please choose an available slot.',
          ),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    // Navigate to payment check page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentCheckPage()),
    );

    // Clear selected courts after navigation
    setState(() {
      selectedCourts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final venueState = ref.watch(venueViewModelProvider);

    return venueState.when(
          data: (venueData) {
            // Get the first venue (assuming single venue for now)
            final selectedVenue = venueData.data.firstWhere(
              (datum) => datum.venue.id == widget.venueId,
              orElse: () => venueData.data.first,
            );

            return _buildBookingContent(selectedVenue);
          },
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (error, _) => Scaffold(
            body: Center(child: Text('Error loading venue data: $error')),
          ),
        ) ??
        const Scaffold(body: Center(child: Text('No venue data available')));
  }

  Widget _buildBookingContent(model.Datum venueData) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // Initialize data from venue on first build or when venue changes
    if (availableDates.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _initializeFromVenueData(venueData);
        });
      });
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          venueData.venue.name,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: availableDates.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Fixed header section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Sport selection widget
                      SportSelectionWidget(
                        sportName: widget.sportName,
                        colorScheme: colorScheme,
                      ),

                      const SizedBox(height: 20),

                      // Date picker widget
                      DatePickerWidget(
                        availableDates: availableDates,
                        selectedDateIndex: selectedDateIndex,
                        onDateSelected: _onDateSelected,
                        colorScheme: colorScheme,
                      ),

                      const SizedBox(height: 20),

                      // Smart slot selector widget
                      SmartSlotSelector(
                        selectedDate: availableDates[selectedDateIndex],
                        openingHours: venueData.venue.openingHours,
                        closingHours: venueData.venue.closingHours,
                        nonOperatingDays: venueData.venue.nonOperatingDays,
                        selectedTime: selectedTime,
                        selectedDuration: selectedDuration,
                        onTimeChanged: _onTimeChanged,
                        onDurationChanged: _onDurationChanged,
                        colorScheme: colorScheme,
                        minDuration: minDuration,
                        maxDuration: maxDuration,
                        durationStep: durationStep,
                      ),

                      const SizedBox(height: 20),

                      // Available Arenas header
                      Text(
                        "Available Arenas",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),

                // Flexible middle section for courts
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: CourtSelectionWidget(
                      courts: venueData.court,
                      selectedCourts: selectedCourts,
                      unavailableCourts: unavailableCourts,
                      onAddCourt: _addCourt,
                      onRemoveCourt: _removeCourt,
                      colorScheme: colorScheme,
                    ),
                  ),
                ),

                // Fixed bottom section for booking summary
                // Only show if there are selected courts AND none are unavailable
                if (selectedCourts.isNotEmpty &&
                    !selectedCourts.any(
                      (courtId) => unavailableCourts.contains(courtId),
                    ))
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BookingSummaryWidget(
                      selectedCourtsList: venueData.court
                          .where((court) => selectedCourts.contains(court.id))
                          .toList(),
                      selectedTime: selectedTime,
                      selectedDuration: selectedDuration,
                      totalPrice: _calculateTotalPrice(
                        venueData.court
                            .where((court) => selectedCourts.contains(court.id))
                            .toList(),
                      ),
                      currency: currency,
                      onAddToBooking: () => _addToBooking(venueData),
                      colorScheme: colorScheme,
                    ),
                  ),

                // Show message when courts are selected but some are unavailable
                if (selectedCourts.isNotEmpty &&
                    selectedCourts.any(
                      (courtId) => unavailableCourts.contains(courtId),
                    ))
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: colorScheme.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber,
                            color: colorScheme.onErrorContainer,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Some selected courts are unavailable for this time slot. Please select only available courts to proceed.',
                              style: TextStyle(
                                color: colorScheme.onErrorContainer,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
