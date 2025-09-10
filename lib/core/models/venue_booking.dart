import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'venue_booking.g.dart';

// Enums for booking functionality
enum BookingStatus { pending, confirmed, cancelled, completed }

enum PaymentSplit { fullAdvance, halfAdvance, venueOnly, custom }

@JsonSerializable()
class VenueBooking {
  // Venue Information
  @JsonKey(name: 'venue_id')
  final String venueId;

  @JsonKey(name: 'venue_name')
  final String venueName;

  @JsonKey(name: 'venue_address')
  final String venueAddress;

  @JsonKey(name: 'venue_city')
  final String venueCity;

  @JsonKey(name: 'venue_latitude')
  final double venueLatitude;

  @JsonKey(name: 'venue_longitude')
  final double venueLongitude;

  @JsonKey(name: 'venue_phone')
  final String venuePhone;

  @JsonKey(name: 'venue_email')
  final String venueEmail;

  @JsonKey(name: 'opening_hours')
  final String openingHours;

  @JsonKey(name: 'closing_hours')
  final String closingHours;

  @JsonKey(name: 'non_operating_days')
  final List<String> nonOperatingDays;

  @JsonKey(name: 'venue_rating')
  final double venueRating;

  @JsonKey(name: 'cancellation_hours')
  final int cancellationHours;

  // Court Information
  @JsonKey(name: 'selected_courts')
  final List<BookingCourt> selectedCourts;

  // Booking Details
  @JsonKey(name: 'booking_id')
  final String bookingId;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'sport_id')
  final String sportId;

  @JsonKey(name: 'booking_date')
  final DateTime bookingDate;

  @JsonKey(name: 'booking_time')
  final String bookingTime; // HH:mm:ss format

  @JsonKey(name: 'total_duration')
  final int totalDuration; // in minutes

  @JsonKey(name: 'booking_status')
  final BookingStatus bookingStatus;

  // Pricing Information
  @JsonKey(name: 'subtotal')
  final double subtotal;

  @JsonKey(name: 'convenience_fee')
  final double convenienceFee;

  @JsonKey(name: 'coupon_discount')
  final double couponDiscount;

  @JsonKey(name: 'karma_discount')
  final double karmaDiscount;

  @JsonKey(name: 'total_amount')
  final double totalAmount;

  @JsonKey(name: 'currency')
  final String currency;

  @JsonKey(name: 'payment_split')
  final PaymentSplit paymentSplit;

  // Additional Booking Info
  @JsonKey(name: 'coupon_code')
  final String? couponCode;

  @JsonKey(name: 'is_karma_redeem_enabled')
  final bool isKarmaRedeemEnabled;

  @JsonKey(name: 'karma_points_used')
  final double karmaPointsUsed;

  @JsonKey(name: 'special_requests')
  final String? specialRequests;

  // Timestamps
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  VenueBooking({
    required this.venueId,
    required this.venueName,
    required this.venueAddress,
    required this.venueCity,
    required this.venueLatitude,
    required this.venueLongitude,
    required this.venuePhone,
    required this.venueEmail,
    required this.openingHours,
    required this.closingHours,
    required this.nonOperatingDays,
    required this.venueRating,
    required this.cancellationHours,
    required this.selectedCourts,
    required this.bookingId,
    required this.userId,
    required this.sportId,
    required this.bookingDate,
    required this.bookingTime,
    required this.totalDuration,
    required this.bookingStatus,
    required this.subtotal,
    required this.convenienceFee,
    required this.couponDiscount,
    required this.karmaDiscount,
    required this.totalAmount,
    required this.currency,
    required this.paymentSplit,
    this.couponCode,
    required this.isKarmaRedeemEnabled,
    required this.karmaPointsUsed,
    this.specialRequests,
    required this.createdAt,
    required this.updatedAt,
  });

  factory VenueBooking.fromJson(Map<String, dynamic> json) =>
      _$VenueBookingFromJson(json);
  Map<String, dynamic> toJson() => _$VenueBookingToJson(this);

  // Computed Properties
  double get advancePayable {
    switch (paymentSplit) {
      case PaymentSplit.fullAdvance:
        return totalAmount;
      case PaymentSplit.halfAdvance:
        return totalAmount * 0.5;
      case PaymentSplit.venueOnly:
        return 0.0;
      case PaymentSplit.custom:
        return totalAmount * 0.3; // Default 30% for custom
    }
  }

  double get toBePayedAtVenue => totalAmount - advancePayable;

  String get formattedDate {
    final date = bookingDate;
    final day = date.day;
    final suffix = _getDaySuffix(day);
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '$day$suffix ${months[date.month]}, ${date.year}';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String get formattedTimeSlot {
    final timeParts = bookingTime.split(':');
    if (timeParts.length >= 2) {
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final startTime = TimeOfDay(hour: hour, minute: minute);

      // Calculate end time based on total duration
      final totalMinutes = hour * 60 + minute + totalDuration;
      final endHour = (totalMinutes ~/ 60) % 24;
      final endMinute = totalMinutes % 60;
      final endTime = TimeOfDay(hour: endHour, minute: endMinute);

      return '${_formatTime(startTime)} to ${_formatTime(endTime)}';
    }
    return bookingTime;
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  String get courtNames {
    if (selectedCourts.length == 1) {
      return selectedCourts.first.courtName;
    } else {
      return '${selectedCourts.length} Courts Selected';
    }
  }

  // Factory constructor for creating booking from venue and court selection
  factory VenueBooking.fromVenueSelection({
    required String bookingId,
    required String userId,
    required VenueInfo venueInfo,
    required List<BookingCourt> selectedCourts,
    required String sportId,
    required DateTime bookingDate,
    required String bookingTime,
    required int totalDuration,
    required String currency,
    PaymentSplit paymentSplit = PaymentSplit.halfAdvance,
    double convenienceFee = 0.08,
    String? couponCode,
    double couponDiscount = 0.0,
    bool isKarmaRedeemEnabled = false,
    double karmaPointsUsed = 0.0,
    String? specialRequests,
  }) {
    // Calculate subtotal from all selected courts
    final subtotal = selectedCourts.fold<double>(
      0.0,
      (total, court) => total + court.totalPrice,
    );

    // Calculate karma discount
    final karmaDiscount = isKarmaRedeemEnabled ? karmaPointsUsed * 0.01 : 0.0;

    // Calculate total amount
    final totalAmount =
        (subtotal + convenienceFee - couponDiscount - karmaDiscount).clamp(
          0.0,
          double.infinity,
        );

    final now = DateTime.now();

    return VenueBooking(
      venueId: venueInfo.venueId,
      venueName: venueInfo.venueName,
      venueAddress: venueInfo.venueAddress,
      venueCity: venueInfo.venueCity,
      venueLatitude: venueInfo.venueLatitude,
      venueLongitude: venueInfo.venueLongitude,
      venuePhone: venueInfo.venuePhone,
      venueEmail: venueInfo.venueEmail,
      openingHours: venueInfo.openingHours,
      closingHours: venueInfo.closingHours,
      nonOperatingDays: venueInfo.nonOperatingDays,
      venueRating: venueInfo.venueRating,
      cancellationHours: venueInfo.cancellationHours,
      selectedCourts: selectedCourts,
      bookingId: bookingId,
      userId: userId,
      sportId: sportId,
      bookingDate: bookingDate,
      bookingTime: bookingTime,
      totalDuration: totalDuration,
      bookingStatus: BookingStatus.pending,
      subtotal: subtotal,
      convenienceFee: convenienceFee,
      couponDiscount: couponDiscount,
      karmaDiscount: karmaDiscount,
      totalAmount: totalAmount,
      currency: currency,
      paymentSplit: paymentSplit,
      couponCode: couponCode,
      isKarmaRedeemEnabled: isKarmaRedeemEnabled,
      karmaPointsUsed: karmaPointsUsed,
      specialRequests: specialRequests,
      createdAt: now,
      updatedAt: now,
    );
  }
}

@JsonSerializable()
class BookingCourt {
  @JsonKey(name: 'court_id')
  final String courtId;

  @JsonKey(name: 'court_name')
  final String courtName;

  @JsonKey(name: 'sport_id')
  final String sportId;

  @JsonKey(name: 'court_type')
  final String courtType;

  @JsonKey(name: 'court_surface')
  final String courtSurface;

  @JsonKey(name: 'hourly_rate')
  final double hourlyRate;

  @JsonKey(name: 'duration_minutes')
  final int durationMinutes;

  @JsonKey(name: 'total_price')
  final double totalPrice;

  @JsonKey(name: 'features')
  final List<String> features;

  @JsonKey(name: 'equipment')
  final List<String> equipment;

  BookingCourt({
    required this.courtId,
    required this.courtName,
    required this.sportId,
    required this.courtType,
    required this.courtSurface,
    required this.hourlyRate,
    required this.durationMinutes,
    required this.totalPrice,
    required this.features,
    required this.equipment,
  });

  factory BookingCourt.fromJson(Map<String, dynamic> json) =>
      _$BookingCourtFromJson(json);
  Map<String, dynamic> toJson() => _$BookingCourtToJson(this);

  // Create BookingCourt from venue Court model
  factory BookingCourt.fromCourt({
    required String courtId,
    required String courtName,
    required String sportId,
    required String courtType,
    required String courtSurface,
    required double hourlyRate,
    required int durationMinutes,
    required List<String> features,
    required List<String> equipment,
  }) {
    final totalPrice = (hourlyRate * durationMinutes) / 60.0;

    return BookingCourt(
      courtId: courtId,
      courtName: courtName,
      sportId: sportId,
      courtType: courtType,
      courtSurface: courtSurface,
      hourlyRate: hourlyRate,
      durationMinutes: durationMinutes,
      totalPrice: totalPrice,
      features: features,
      equipment: equipment,
    );
  }

  String get formattedDuration {
    if (durationMinutes < 60) {
      return '${durationMinutes}m';
    } else {
      final hours = durationMinutes ~/ 60;
      final minutes = durationMinutes % 60;
      if (minutes == 0) {
        return '${hours}h';
      } else {
        return '${hours}h ${minutes}m';
      }
    }
  }
}

@JsonSerializable()
class VenueInfo {
  @JsonKey(name: 'venue_id')
  final String venueId;

  @JsonKey(name: 'venue_name')
  final String venueName;

  @JsonKey(name: 'venue_address')
  final String venueAddress;

  @JsonKey(name: 'venue_city')
  final String venueCity;

  @JsonKey(name: 'venue_latitude')
  final double venueLatitude;

  @JsonKey(name: 'venue_longitude')
  final double venueLongitude;

  @JsonKey(name: 'venue_phone')
  final String venuePhone;

  @JsonKey(name: 'venue_email')
  final String venueEmail;

  @JsonKey(name: 'opening_hours')
  final String openingHours;

  @JsonKey(name: 'closing_hours')
  final String closingHours;

  @JsonKey(name: 'non_operating_days')
  final List<String> nonOperatingDays;

  @JsonKey(name: 'venue_rating')
  final double venueRating;

  @JsonKey(name: 'cancellation_hours')
  final int cancellationHours;

  VenueInfo({
    required this.venueId,
    required this.venueName,
    required this.venueAddress,
    required this.venueCity,
    required this.venueLatitude,
    required this.venueLongitude,
    required this.venuePhone,
    required this.venueEmail,
    required this.openingHours,
    required this.closingHours,
    required this.nonOperatingDays,
    required this.venueRating,
    required this.cancellationHours,
  });

  factory VenueInfo.fromJson(Map<String, dynamic> json) =>
      _$VenueInfoFromJson(json);
  Map<String, dynamic> toJson() => _$VenueInfoToJson(this);

  // Create VenueInfo from venue model
  factory VenueInfo.fromVenueModel({
    required String venueId,
    required String venueName,
    required String venueAddress,
    required String venueCity,
    required double venueLatitude,
    required double venueLongitude,
    required String venuePhone,
    required String venueEmail,
    required String openingHours,
    required String closingHours,
    required List<String> nonOperatingDays,
    required double venueRating,
    required int cancellationHours,
  }) {
    return VenueInfo(
      venueId: venueId,
      venueName: venueName,
      venueAddress: venueAddress,
      venueCity: venueCity,
      venueLatitude: venueLatitude,
      venueLongitude: venueLongitude,
      venuePhone: venuePhone,
      venueEmail: venueEmail,
      openingHours: openingHours,
      closingHours: closingHours,
      nonOperatingDays: nonOperatingDays,
      venueRating: venueRating,
      cancellationHours: cancellationHours,
    );
  }
}

// Helper class for booking availability
@JsonSerializable()
class BookingAvailability {
  @JsonKey(name: 'date')
  final DateTime date;

  @JsonKey(name: 'time_slot')
  final String timeSlot;

  @JsonKey(name: 'is_available')
  final bool isAvailable;

  @JsonKey(name: 'available_courts')
  final List<String> availableCourts;

  @JsonKey(name: 'unavailable_courts')
  final List<String> unavailableCourts;

  @JsonKey(name: 'reason')
  final String? reason;

  BookingAvailability({
    required this.date,
    required this.timeSlot,
    required this.isAvailable,
    required this.availableCourts,
    required this.unavailableCourts,
    this.reason,
  });

  factory BookingAvailability.fromJson(Map<String, dynamic> json) =>
      _$BookingAvailabilityFromJson(json);
  Map<String, dynamic> toJson() => _$BookingAvailabilityToJson(this);
}
