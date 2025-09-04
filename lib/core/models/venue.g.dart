// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Venue _$VenueFromJson(Map<String, dynamic> json) => Venue(
  id: json['id'] as String,
  ownerId: json['ownerId'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  address: json['address'] as String,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  zipCode: json['zipCode'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  primaryImage: json['primaryImage'] as String?,
  sportIds:
      (json['sportIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  amenities:
      (json['amenities'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  rules:
      (json['rules'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  openingHours: json['openingHours'] as String?,
  closingHours: json['closingHours'] as String?,
  nonOperatingDays:
      (json['nonOperatingDays'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  type: $enumDecodeNullable(_$VenueTypeEnumMap, json['type']),
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  totalReviews: (json['totalReviews'] as num?)?.toInt() ?? 0,
  totalBookings: (json['totalBookings'] as num?)?.toInt() ?? 0,
  isActive: json['isActive'] as bool? ?? true,
  cancellationHours: (json['cancellationHours'] as num?)?.toDouble(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
)..dbType = (json['dbType'] as num?)?.toInt();

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
  'id': instance.id,
  'ownerId': instance.ownerId,
  'name': instance.name,
  'description': instance.description,
  'address': instance.address,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'zipCode': instance.zipCode,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'phone': instance.phone,
  'email': instance.email,
  'images': instance.images,
  'primaryImage': instance.primaryImage,
  'sportIds': instance.sportIds,
  'amenities': instance.amenities,
  'rules': instance.rules,
  'openingHours': instance.openingHours,
  'closingHours': instance.closingHours,
  'nonOperatingDays': instance.nonOperatingDays,
  'type': _$VenueTypeEnumMap[instance.type],
  'dbType': instance.dbType,
  'rating': instance.rating,
  'totalReviews': instance.totalReviews,
  'totalBookings': instance.totalBookings,
  'isActive': instance.isActive,
  'cancellationHours': instance.cancellationHours,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$VenueTypeEnumMap = {
  VenueType.unknown: 'unknown',
  VenueType.outdoor: 'outdoor',
  VenueType.indoor: 'indoor',
  VenueType.mixed: 'mixed',
  VenueType.club: 'club',
  VenueType.academy: 'academy',
  VenueType.public: 'public',
  VenueType.private: 'private',
};

Court _$CourtFromJson(Map<String, dynamic> json) => Court(
  id: json['id'] as String,
  venueId: json['venueId'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  sportId: json['sportId'] as String,
  type:
      $enumDecodeNullable(_$CourtTypeEnumMap, json['type']) ??
      CourtType.standard,
  surface: json['surface'] as String?,
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  equipment:
      (json['equipment'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isBookable: json['isBookable'] as bool? ?? true,
  hourlyRate: (json['hourlyRate'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
)..dbType = (json['dbType'] as num?)?.toInt();

Map<String, dynamic> _$CourtToJson(Court instance) => <String, dynamic>{
  'id': instance.id,
  'venueId': instance.venueId,
  'name': instance.name,
  'description': instance.description,
  'sportId': instance.sportId,
  'type': _$CourtTypeEnumMap[instance.type],
  'dbType': instance.dbType,
  'surface': instance.surface,
  'features': instance.features,
  'equipment': instance.equipment,
  'isBookable': instance.isBookable,
  'hourlyRate': instance.hourlyRate,
  'currency': instance.currency,
  'images': instance.images,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$CourtTypeEnumMap = {
  CourtType.unknown: 'unknown',
  CourtType.standard: 'standard',
  CourtType.premium: 'premium',
  CourtType.tournament: 'tournament',
  CourtType.training: 'training',
};

VenueBooking _$VenueBookingFromJson(Map<String, dynamic> json) =>
    VenueBooking(
        localId: (json['localId'] as num?)?.toInt() ?? 0,
        id: json['id'] as String,
        venueId: json['venueId'] as String,
        courtId: json['courtId'] as String?,
        userId: json['userId'] as String,
        sportId: json['sportId'] as String,
        startTime: DateTime.parse(json['startTime'] as String),
        endTime: DateTime.parse(json['endTime'] as String),
        totalAmount: (json['totalAmount'] as num).toDouble(),
        currency: json['currency'] as String?,
        purpose: json['purpose'] as String?,
        notes: json['notes'] as String?,
        specialRequests: json['specialRequests'] as String?,
        participantIds:
            (json['participantIds'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        expectedParticipants: (json['expectedParticipants'] as num?)?.toInt(),
        equipmentRequested:
            (json['equipmentRequested'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        paymentId: json['paymentId'] as String?,
        isPaid: json['isPaid'] as bool? ?? false,
        paidAt: json['paidAt'] == null
            ? null
            : DateTime.parse(json['paidAt'] as String),
        confirmedAt: json['confirmedAt'] == null
            ? null
            : DateTime.parse(json['confirmedAt'] as String),
        cancelledAt: json['cancelledAt'] == null
            ? null
            : DateTime.parse(json['cancelledAt'] as String),
        cancellationReason: json['cancellationReason'] as String?,
        cancellationFee: (json['cancellationFee'] as num?)?.toDouble(),
        refundAmount: (json['refundAmount'] as num?)?.toDouble(),
        venueResponse: json['venueResponse'] as String?,
        checkedInAt: json['checkedInAt'] == null
            ? null
            : DateTime.parse(json['checkedInAt'] as String),
        checkedOutAt: json['checkedOutAt'] == null
            ? null
            : DateTime.parse(json['checkedOutAt'] as String),
        userRating: (json['userRating'] as num?)?.toDouble(),
        userFeedback: json['userFeedback'] as String?,
        venueRating: (json['venueRating'] as num?)?.toDouble(),
        venueFeedback: json['venueFeedback'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      )
      ..status = $enumDecodeNullable(_$BookingStatusEnumMap, json['status'])
      ..type = $enumDecodeNullable(_$BookingTypeEnumMap, json['type'])
      ..dbStatus = (json['dbStatus'] as num?)?.toInt()
      ..dbType = (json['dbType'] as num?)?.toInt();

Map<String, dynamic> _$VenueBookingToJson(VenueBooking instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'venueId': instance.venueId,
      'courtId': instance.courtId,
      'userId': instance.userId,
      'sportId': instance.sportId,
      'status': _$BookingStatusEnumMap[instance.status],
      'type': _$BookingTypeEnumMap[instance.type],
      'dbStatus': instance.dbStatus,
      'dbType': instance.dbType,
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'totalAmount': instance.totalAmount,
      'currency': instance.currency,
      'purpose': instance.purpose,
      'notes': instance.notes,
      'specialRequests': instance.specialRequests,
      'participantIds': instance.participantIds,
      'expectedParticipants': instance.expectedParticipants,
      'equipmentRequested': instance.equipmentRequested,
      'paymentId': instance.paymentId,
      'isPaid': instance.isPaid,
      'paidAt': instance.paidAt?.toIso8601String(),
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'cancellationReason': instance.cancellationReason,
      'cancellationFee': instance.cancellationFee,
      'refundAmount': instance.refundAmount,
      'venueResponse': instance.venueResponse,
      'checkedInAt': instance.checkedInAt?.toIso8601String(),
      'checkedOutAt': instance.checkedOutAt?.toIso8601String(),
      'userRating': instance.userRating,
      'userFeedback': instance.userFeedback,
      'venueRating': instance.venueRating,
      'venueFeedback': instance.venueFeedback,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$BookingStatusEnumMap = {
  BookingStatus.unknown: 'unknown',
  BookingStatus.pending: 'pending',
  BookingStatus.confirmed: 'confirmed',
  BookingStatus.paid: 'paid',
  BookingStatus.checkedIn: 'checked_in',
  BookingStatus.completed: 'completed',
  BookingStatus.cancelled: 'cancelled',
  BookingStatus.refunded: 'refunded',
  BookingStatus.noShow: 'no_show',
};

const _$BookingTypeEnumMap = {
  BookingType.unknown: 'unknown',
  BookingType.hourly: 'hourly',
  BookingType.daily: 'daily',
  BookingType.event: 'event',
  BookingType.tournament: 'tournament',
  BookingType.membership: 'membership',
};

VenueReview _$VenueReviewFromJson(Map<String, dynamic> json) => VenueReview(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  venueId: json['venueId'] as String,
  reviewerId: json['reviewerId'] as String,
  bookingId: json['bookingId'] as String?,
  rating: (json['rating'] as num).toDouble(),
  comment: json['comment'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  images:
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isAnonymous: json['isAnonymous'] as bool? ?? false,
  isPublic: json['isPublic'] as bool? ?? true,
  isReported: json['isReported'] as bool? ?? false,
  venueResponse: json['venueResponse'] as String?,
  respondedAt: json['respondedAt'] == null
      ? null
      : DateTime.parse(json['respondedAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$VenueReviewToJson(VenueReview instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'venueId': instance.venueId,
      'reviewerId': instance.reviewerId,
      'bookingId': instance.bookingId,
      'rating': instance.rating,
      'comment': instance.comment,
      'tags': instance.tags,
      'images': instance.images,
      'isAnonymous': instance.isAnonymous,
      'isPublic': instance.isPublic,
      'isReported': instance.isReported,
      'venueResponse': instance.venueResponse,
      'respondedAt': instance.respondedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
