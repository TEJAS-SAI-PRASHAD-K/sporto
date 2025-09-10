// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue_booking.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VenueBooking _$VenueBookingFromJson(Map<String, dynamic> json) => VenueBooking(
  venueId: json['venue_id'] as String,
  venueName: json['venue_name'] as String,
  venueAddress: json['venue_address'] as String,
  venueCity: json['venue_city'] as String,
  venueLatitude: (json['venue_latitude'] as num).toDouble(),
  venueLongitude: (json['venue_longitude'] as num).toDouble(),
  venuePhone: json['venue_phone'] as String,
  venueEmail: json['venue_email'] as String,
  openingHours: json['opening_hours'] as String,
  closingHours: json['closing_hours'] as String,
  nonOperatingDays: (json['non_operating_days'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  venueRating: (json['venue_rating'] as num).toDouble(),
  cancellationHours: (json['cancellation_hours'] as num).toInt(),
  selectedCourts: (json['selected_courts'] as List<dynamic>)
      .map((e) => BookingCourt.fromJson(e as Map<String, dynamic>))
      .toList(),
  bookingId: json['booking_id'] as String,
  userId: json['user_id'] as String,
  sportId: json['sport_id'] as String,
  bookingDate: DateTime.parse(json['booking_date'] as String),
  bookingTime: json['booking_time'] as String,
  totalDuration: (json['total_duration'] as num).toInt(),
  bookingStatus: $enumDecode(_$BookingStatusEnumMap, json['booking_status']),
  subtotal: (json['subtotal'] as num).toDouble(),
  convenienceFee: (json['convenience_fee'] as num).toDouble(),
  couponDiscount: (json['coupon_discount'] as num).toDouble(),
  karmaDiscount: (json['karma_discount'] as num).toDouble(),
  totalAmount: (json['total_amount'] as num).toDouble(),
  currency: json['currency'] as String,
  paymentSplit: $enumDecode(_$PaymentSplitEnumMap, json['payment_split']),
  couponCode: json['coupon_code'] as String?,
  isKarmaRedeemEnabled: json['is_karma_redeem_enabled'] as bool,
  karmaPointsUsed: (json['karma_points_used'] as num).toDouble(),
  specialRequests: json['special_requests'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  updatedAt: DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$VenueBookingToJson(VenueBooking instance) =>
    <String, dynamic>{
      'venue_id': instance.venueId,
      'venue_name': instance.venueName,
      'venue_address': instance.venueAddress,
      'venue_city': instance.venueCity,
      'venue_latitude': instance.venueLatitude,
      'venue_longitude': instance.venueLongitude,
      'venue_phone': instance.venuePhone,
      'venue_email': instance.venueEmail,
      'opening_hours': instance.openingHours,
      'closing_hours': instance.closingHours,
      'non_operating_days': instance.nonOperatingDays,
      'venue_rating': instance.venueRating,
      'cancellation_hours': instance.cancellationHours,
      'selected_courts': instance.selectedCourts,
      'booking_id': instance.bookingId,
      'user_id': instance.userId,
      'sport_id': instance.sportId,
      'booking_date': instance.bookingDate.toIso8601String(),
      'booking_time': instance.bookingTime,
      'total_duration': instance.totalDuration,
      'booking_status': _$BookingStatusEnumMap[instance.bookingStatus]!,
      'subtotal': instance.subtotal,
      'convenience_fee': instance.convenienceFee,
      'coupon_discount': instance.couponDiscount,
      'karma_discount': instance.karmaDiscount,
      'total_amount': instance.totalAmount,
      'currency': instance.currency,
      'payment_split': _$PaymentSplitEnumMap[instance.paymentSplit]!,
      'coupon_code': instance.couponCode,
      'is_karma_redeem_enabled': instance.isKarmaRedeemEnabled,
      'karma_points_used': instance.karmaPointsUsed,
      'special_requests': instance.specialRequests,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$BookingStatusEnumMap = {
  BookingStatus.pending: 'pending',
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.cancelled: 'cancelled',
  BookingStatus.completed: 'completed',
};

const _$PaymentSplitEnumMap = {
  PaymentSplit.fullAdvance: 'fullAdvance',
  PaymentSplit.halfAdvance: 'halfAdvance',
  PaymentSplit.venueOnly: 'venueOnly',
  PaymentSplit.custom: 'custom',
};

BookingCourt _$BookingCourtFromJson(Map<String, dynamic> json) => BookingCourt(
  courtId: json['court_id'] as String,
  courtName: json['court_name'] as String,
  sportId: json['sport_id'] as String,
  courtType: json['court_type'] as String,
  courtSurface: json['court_surface'] as String,
  hourlyRate: (json['hourly_rate'] as num).toDouble(),
  durationMinutes: (json['duration_minutes'] as num).toInt(),
  totalPrice: (json['total_price'] as num).toDouble(),
  features: (json['features'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  equipment: (json['equipment'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$BookingCourtToJson(BookingCourt instance) =>
    <String, dynamic>{
      'court_id': instance.courtId,
      'court_name': instance.courtName,
      'sport_id': instance.sportId,
      'court_type': instance.courtType,
      'court_surface': instance.courtSurface,
      'hourly_rate': instance.hourlyRate,
      'duration_minutes': instance.durationMinutes,
      'total_price': instance.totalPrice,
      'features': instance.features,
      'equipment': instance.equipment,
    };

VenueInfo _$VenueInfoFromJson(Map<String, dynamic> json) => VenueInfo(
  venueId: json['venue_id'] as String,
  venueName: json['venue_name'] as String,
  venueAddress: json['venue_address'] as String,
  venueCity: json['venue_city'] as String,
  venueLatitude: (json['venue_latitude'] as num).toDouble(),
  venueLongitude: (json['venue_longitude'] as num).toDouble(),
  venuePhone: json['venue_phone'] as String,
  venueEmail: json['venue_email'] as String,
  openingHours: json['opening_hours'] as String,
  closingHours: json['closing_hours'] as String,
  nonOperatingDays: (json['non_operating_days'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  venueRating: (json['venue_rating'] as num).toDouble(),
  cancellationHours: (json['cancellation_hours'] as num).toInt(),
);

Map<String, dynamic> _$VenueInfoToJson(VenueInfo instance) => <String, dynamic>{
  'venue_id': instance.venueId,
  'venue_name': instance.venueName,
  'venue_address': instance.venueAddress,
  'venue_city': instance.venueCity,
  'venue_latitude': instance.venueLatitude,
  'venue_longitude': instance.venueLongitude,
  'venue_phone': instance.venuePhone,
  'venue_email': instance.venueEmail,
  'opening_hours': instance.openingHours,
  'closing_hours': instance.closingHours,
  'non_operating_days': instance.nonOperatingDays,
  'venue_rating': instance.venueRating,
  'cancellation_hours': instance.cancellationHours,
};

BookingAvailability _$BookingAvailabilityFromJson(Map<String, dynamic> json) =>
    BookingAvailability(
      date: DateTime.parse(json['date'] as String),
      timeSlot: json['time_slot'] as String,
      isAvailable: json['is_available'] as bool,
      availableCourts: (json['available_courts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      unavailableCourts: (json['unavailable_courts'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$BookingAvailabilityToJson(
  BookingAvailability instance,
) => <String, dynamic>{
  'date': instance.date.toIso8601String(),
  'time_slot': instance.timeSlot,
  'is_available': instance.isAvailable,
  'available_courts': instance.availableCourts,
  'unavailable_courts': instance.unavailableCourts,
  'reason': instance.reason,
};
