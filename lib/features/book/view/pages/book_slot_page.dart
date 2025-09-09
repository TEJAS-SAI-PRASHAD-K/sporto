import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/models/venue.dart' as model;
import 'package:playo/core/models/game.dart';
import 'package:playo/features/book/viewmodel/venue_view_model.dart';
import 'package:playo/features/book/view/widgets/venue_sport_selector.dart';
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
  String? selectedSportId; // Track selected sport for filtering

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

  void _onSportSelected(String? sportId) {
    setState(() {
      selectedSportId = sportId;
      // Clear selected courts when changing sport filter
      selectedCourts.clear();

      // Recheck availability for the new filtered courts
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

  List<model.Court> _getFilteredCourts(model.Datum venueData) {
    if (selectedSportId == null) {
      return venueData.court.where((court) => court.isBookable).toList();
    }
    return venueData.court
        .where((court) => court.isBookable && court.sportId == selectedSportId)
        .toList();
  }

  bool _hasAvailableSlots(DateTime testDate, model.Datum venueData) {
    // Generate all possible time slots for this date
    final allTimeSlots = VenueOperatingHours.generateAvailableTimeSlots(
      openingHours: venueData.venue.openingHours,
      closingHours: venueData.venue.closingHours,
      nonOperatingDays: venueData.venue.nonOperatingDays,
      selectedDate: testDate,
      slotIntervalMinutes: durationStep,
      minimumBookingDuration: minDuration,
    );

    // If no time slots are available at all, return false
    if (allTimeSlots.isEmpty) return false;

    // Check if we're past operating hours for today
    final now = DateTime.now();
    final isToday = DateUtils.isSameDay(testDate, now);

    if (isToday) {
      final currentTimeInMinutes =
          TimeOfDay.now().hour * 60 + TimeOfDay.now().minute;
      final closingTimeInMinutes = _parseTimeToMinutes(
        venueData.venue.closingHours,
      );

      // If current time is past closing hours, no slots available
      if (currentTimeInMinutes >= closingTimeInMinutes) {
        return false;
      }
    }

    // Check each time slot to see if at least one court is available
    for (final timeSlot in allTimeSlots) {
      // Get all courts (not filtered by sport during date filtering)
      for (final court in venueData.court.where((c) => c.isBookable)) {
        // Temporarily set values to check availability
        final tempSelectedTime = selectedTime;
        final tempSelectedDateIndex = selectedDateIndex;

        selectedTime = timeSlot;
        // Set a temporary date index (we'll restore it)
        final tempDateIndex = availableDates.isNotEmpty
            ? availableDates.indexWhere(
                (date) => DateUtils.isSameDay(date, testDate),
              )
            : -1;
        if (tempDateIndex != -1) {
          selectedDateIndex = tempDateIndex;
        }

        final isCourtUnavailable = _isCourtUnavailable(
          court,
          testDate: testDate,
        );

        // Restore original values
        selectedTime = tempSelectedTime;
        selectedDateIndex = tempSelectedDateIndex;

        // If at least one court is available for this time slot, date has available slots
        if (!isCourtUnavailable) {
          return true;
        }
      }
    }

    return false; // No available slots found for this date
  }

  int _parseTimeToMinutes(String timeString) {
    try {
      final parts = timeString.split(':');
      if (parts.length >= 2) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        return hours * 60 + minutes;
      }
    } catch (e) {
      debugPrint('Error parsing time: $timeString');
    }
    return 0;
  }

  void _initializeFromVenueData(model.Datum venueData) {
    // Initialize selectedSportId with the sport from navigation if provided
    if (widget.sportName != null && selectedSportId == null) {
      // Find matching sport in venue courts
      final matchingSport = venueData.court
          .where((court) => court.isBookable)
          .map((court) => court.sportId)
          .firstWhere(
            (sportId) =>
                sportId.toLowerCase() == widget.sportName!.toLowerCase(),
            orElse: () => '',
          );
      if (matchingSport.isNotEmpty) {
        selectedSportId = matchingSport;
      }
    }

    // Auto-select sport if venue has only one sport and no sport is selected
    if (selectedSportId == null) {
      final availableSports = venueData.court
          .where((court) => court.isBookable)
          .map((court) => court.sportId)
          .toSet()
          .toList();

      if (availableSports.length == 1) {
        selectedSportId = availableSports.first;
      }
    }

    // Generate all potential dates based on venue operating days
    final allPotentialDates = VenueOperatingHours.generateAvailableDates(
      startDate: DateTime.now(),
      numberOfDays: 60, // Generate more days to account for filtering
      nonOperatingDays: venueData.venue.nonOperatingDays,
    );

    // Filter dates to only include those with available slots
    availableDates = [];
    for (final testDate in allPotentialDates) {
      if (_hasAvailableSlots(testDate, venueData)) {
        availableDates.add(testDate);
      }

      // Stop when we have enough available dates (30 is good)
      if (availableDates.length >= 30) break;
    }

    // Set first available date as selected
    selectedDateIndex = 0;

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
    final filteredCourts = _getFilteredCourts(venueData);

    // Check each filtered court for availability
    for (final court in filteredCourts) {
      if (_isCourtUnavailable(court)) {
        newUnavailableCourts.add(court.id);
      }
    }

    unavailableCourts = newUnavailableCourts;

    // Debug info for development (can be removed in production)
    if (newUnavailableCourts.isNotEmpty) {
      debugPrint(
        'Unavailable courts: ${newUnavailableCourts.length} out of ${filteredCourts.length}',
      );
    }

    // Remove any selected courts that are now unavailable
    selectedCourts.removeWhere(
      (courtId) => unavailableCourts.contains(courtId),
    );
  }

  bool _isCourtUnavailable(model.Court court, {DateTime? testDate}) {
    // Enhanced logic to work for venues with any number of arenas
    // This would be replaced with real booking data in production

    final selectedStartMinutes = selectedTime.hour * 60 + selectedTime.minute;
    final selectedEndMinutes = selectedStartMinutes + selectedDuration;

    // Use test date if provided, otherwise use the selected date from available dates
    final selectedDate =
        testDate ??
        (availableDates.isNotEmpty
            ? availableDates[selectedDateIndex]
            : DateTime.now());

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

      // Single arena is also unavailable during peak hours 8-10 PM on weekdays
      if (selectedDate.weekday >= DateTime.monday &&
          selectedDate.weekday <= DateTime.friday) {
        const peakStartMinutes = 20 * 60; // 8:00 PM
        const peakEndMinutes = 22 * 60; // 10:00 PM

        if (selectedStartMinutes < peakEndMinutes &&
            selectedEndMinutes > peakStartMinutes) {
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
            // For today, only reset time if current selected time is in the past
            final now = TimeOfDay.now();
            final currentMinutes = now.hour * 60 + now.minute;
            final selectedMinutes =
                selectedTime.hour * 60 + selectedTime.minute;

            // Only reset if selected time is in the past or not in available slots
            if (selectedMinutes <= currentMinutes ||
                !availableTimeSlots.any(
                  (slot) =>
                      slot.hour == selectedTime.hour &&
                      slot.minute == selectedTime.minute,
                )) {
              _initializeCurrentTime();

              // Ensure the new time is in available slots
              if (availableTimeSlots.isNotEmpty &&
                  !availableTimeSlots.any(
                    (slot) =>
                        slot.hour == selectedTime.hour &&
                        slot.minute == selectedTime.minute,
                  )) {
                selectedTime = availableTimeSlots.first;
              }
            }
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
    final selectedDate = availableDates[selectedDateIndex];
    final filteredCourts = _getFilteredCourts(venueData);
    final selectedCourtsList = filteredCourts
        .where((court) => selectedCourts.contains(court.id))
        .toList();

    final selectedCourt = selectedCourtsList.isNotEmpty
        ? selectedCourtsList.first
        : filteredCourts.first; // Fallback to first filtered court

    // Calculate the actual price as shown in booking summary
    final priceInDollars = selectedCourt.hourlyRate / 86.0;
    final totalCourtPrice = (priceInDollars * selectedDuration) / 60.0;

    // Create a Game object for booking
    final gameForBooking = Game.forBooking(
      gameId: 'booking_${DateTime.now().millisecondsSinceEpoch}',
      organiserUserId: 'current_user', // This should come from auth
      sportId: selectedCourt.sportId,
      gameDate: selectedDate,
      gameTime:
          '${selectedTime.hour.toString().padLeft(2, '0')}:${selectedTime.minute.toString().padLeft(2, '0')}:00',
      venueName: venueData.venue.name,
      venueId: venueData.venue.id,
      venueAddress: '${venueData.venue.address}, ${venueData.venue.city}',
      venueLatitude: venueData.venue.latitude,
      venueLongitude: venueData.venue.longitude,
      courtId: selectedCourt.id,
      courtName: selectedCourt.name,
      hourlyRate:
          totalCourtPrice, // Use calculated total price instead of raw hourly rate
      convenienceFee: 0.08, // $0.08 USD
      paymentSplit: PaymentSplit.halfAdvance,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentCheckPage(gameData: gameForBooking),
      ),
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
                      // Venue sport selector widget
                      VenueSportSelector(
                        venueData: venueData,
                        selectedSportId: selectedSportId,
                        onSportSelected: _onSportSelected,
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

                      // Available Arenas header - simplified since we only show available dates
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
                      courts: _getFilteredCourts(venueData),
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
                      selectedCourtsList: _getFilteredCourts(venueData)
                          .where((court) => selectedCourts.contains(court.id))
                          .toList(),
                      selectedTime: selectedTime,
                      selectedDuration: selectedDuration,
                      totalPrice: _calculateTotalPrice(
                        _getFilteredCourts(venueData)
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
