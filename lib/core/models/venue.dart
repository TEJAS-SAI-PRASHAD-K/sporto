import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'venue.g.dart';

/// Venue model for booking sports facilities
@Entity()
@JsonSerializable()
class Venue {
  @Id()
  int localId;

  @Unique()
  String id;
  String ownerId; // References User.id
  String name;
  String? description;
  String address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  double latitude;
  double longitude;
  String? phone;
  String? email;
  String? website;
  List<String> images;
  String? primaryImage;
  List<String> sportIds;
  List<String> amenities;
  List<String> facilities;
  List<String> equipment;
  List<String> rules;
  String? openingHours; // JSON string of operating hours
  String? closingHours;
  List<String> nonOperatingDays;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  VenueType? type;

  // Stable database field for enum storage
  int? get dbType {
    return type?.stableId;
  }

  set dbType(int? value) {
    if (value == null) {
      type = null;
    } else {
      type = VenueType.fromStableId(value);
    }
  }

  double rating;
  int totalReviews;
  int totalBookings;
  bool isActive;
  bool isVerified;
  bool allowsOnlineBooking;
  bool requiresApproval;
  double? cancellationHours; // hours before booking can be cancelled
  List<String> tags;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  Venue({
    this.localId = 0,
    required this.id,
    required this.ownerId,
    required this.name,
    this.description,
    required this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    required this.latitude,
    required this.longitude,
    this.phone,
    this.email,
    this.website,
    this.images = const [],
    this.primaryImage,
    this.sportIds = const [],
    this.amenities = const [],
    this.facilities = const [],
    this.equipment = const [],
    this.rules = const [],
    this.openingHours,
    this.closingHours,
    this.nonOperatingDays = const [],
    VenueType? type,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.totalBookings = 0,
    this.isActive = true,
    this.isVerified = false,
    this.allowsOnlineBooking = true,
    this.requiresApproval = false,
    this.cancellationHours,
    this.tags = const [],
    this.createdAt,
    this.updatedAt,
  }) {
    this.type = type;
  }

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
  Map<String, dynamic> toJson() => _$VenueToJson(this);
}

enum VenueType {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('outdoor')
  outdoor,
  @JsonValue('indoor')
  indoor,
  @JsonValue('mixed')
  mixed,
  @JsonValue('club')
  club,
  @JsonValue('academy')
  academy,
  @JsonValue('public')
  public,
  @JsonValue('private')
  private;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case VenueType.unknown:
        return 0;
      case VenueType.outdoor:
        return 1;
      case VenueType.indoor:
        return 2;
      case VenueType.mixed:
        return 3;
      case VenueType.club:
        return 4;
      case VenueType.academy:
        return 5;
      case VenueType.public:
        return 6;
      case VenueType.private:
        return 7;
    }
  }

  static VenueType fromStableId(int id) {
    switch (id) {
      case 0:
        return VenueType.unknown;
      case 1:
        return VenueType.outdoor;
      case 2:
        return VenueType.indoor;
      case 3:
        return VenueType.mixed;
      case 4:
        return VenueType.club;
      case 5:
        return VenueType.academy;
      case 6:
        return VenueType.public;
      case 7:
        return VenueType.private;
      default:
        return VenueType.unknown;
    }
  }
}

/// Court/Field within a venue
@Entity()
@JsonSerializable()
class Court {
  @Id()
  int localId;

  @Unique()
  String id;
  String venueId;
  String name;
  String? description;
  String sportId;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  CourtType? type;

  // Stable database field for enum storage
  int? get dbType {
    return type?.stableId;
  }

  set dbType(int? value) {
    if (value == null) {
      type = null;
    } else {
      type = CourtType.fromStableId(value);
    }
  }

  String? surface; // grass, concrete, clay, synthetic
  List<String> features;
  List<String> equipment;
  bool isActive;
  bool isBookable;
  double? hourlyRate;
  String? currency;
  List<String> images;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  Court({
    this.localId = 0,
    required this.id,
    required this.venueId,
    required this.name,
    this.description,
    required this.sportId,
    CourtType type = CourtType.standard,
    this.surface,
    this.features = const [],
    this.equipment = const [],
    this.isActive = true,
    this.isBookable = true,
    this.hourlyRate,
    this.currency,
    this.images = const [],
    this.createdAt,
    this.updatedAt,
  }) {
    this.type = type;
  }

  factory Court.fromJson(Map<String, dynamic> json) => _$CourtFromJson(json);
  Map<String, dynamic> toJson() => _$CourtToJson(this);
}

enum CourtType {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('standard')
  standard,
  @JsonValue('premium')
  premium,
  @JsonValue('tournament')
  tournament,
  @JsonValue('training')
  training;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case CourtType.unknown:
        return 0;
      case CourtType.standard:
        return 1;
      case CourtType.premium:
        return 2;
      case CourtType.tournament:
        return 3;
      case CourtType.training:
        return 4;
    }
  }

  static CourtType fromStableId(int id) {
    switch (id) {
      case 0:
        return CourtType.unknown;
      case 1:
        return CourtType.standard;
      case 2:
        return CourtType.premium;
      case 3:
        return CourtType.tournament;
      case 4:
        return CourtType.training;
      default:
        return CourtType.unknown;
    }
  }
}

/// Venue booking model
@Entity()
@JsonSerializable()
class VenueBooking {
  @Id()
  int localId;

  @Unique()
  String id;
  String venueId;
  String? courtId;
  String userId;
  String sportId;

  // Store enums as stable int for ObjectBox compatibility
  @Transient()
  BookingStatus? status;

  @Transient()
  BookingType? type;

  // Stable database fields for enum storage
  int? get dbStatus {
    return status?.stableId;
  }

  set dbStatus(int? value) {
    if (value == null) {
      status = null;
    } else {
      status = BookingStatus.fromStableId(value);
    }
  }

  int? get dbType {
    return type?.stableId;
  }

  set dbType(int? value) {
    if (value == null) {
      type = null;
    } else {
      type = BookingType.fromStableId(value);
    }
  }

  @Property(type: PropertyType.date)
  DateTime startTime;
  @Property(type: PropertyType.date)
  DateTime endTime;
  double totalAmount;
  String? currency;
  String? purpose; // training, match, event
  String? notes;
  String? specialRequests;
  List<String> participantIds;
  int? expectedParticipants;
  List<String> equipmentRequested;
  String? paymentId;
  bool isPaid;
  @Property(type: PropertyType.date)
  DateTime? paidAt;
  @Property(type: PropertyType.date)
  DateTime? confirmedAt;
  @Property(type: PropertyType.date)
  DateTime? cancelledAt;
  String? cancellationReason;
  double? cancellationFee;
  double? refundAmount;
  String? venueResponse;
  @Property(type: PropertyType.date)
  DateTime? checkedInAt;
  @Property(type: PropertyType.date)
  DateTime? checkedOutAt;
  double? userRating;
  String? userFeedback;
  double? venueRating;
  String? venueFeedback;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  VenueBooking({
    this.localId = 0,
    required this.id,
    required this.venueId,
    this.courtId,
    required this.userId,
    required this.sportId,
    BookingStatus? bookingStatus,
    required this.startTime,
    required this.endTime,
    required this.totalAmount,
    this.currency,
    this.purpose,
    this.notes,
    this.specialRequests,
    this.participantIds = const [],
    this.expectedParticipants,
    this.equipmentRequested = const [],
    BookingType? bookingType,
    this.paymentId,
    this.isPaid = false,
    this.paidAt,
    this.confirmedAt,
    this.cancelledAt,
    this.cancellationReason,
    this.cancellationFee,
    this.refundAmount,
    this.venueResponse,
    this.checkedInAt,
    this.checkedOutAt,
    this.userRating,
    this.userFeedback,
    this.venueRating,
    this.venueFeedback,
    this.createdAt,
    this.updatedAt,
  }) {
    this.status = bookingStatus;
    this.type = bookingType;
  }

  factory VenueBooking.fromJson(Map<String, dynamic> json) =>
      _$VenueBookingFromJson(json);
  Map<String, dynamic> toJson() => _$VenueBookingToJson(this);
}

enum BookingStatus {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('pending')
  pending,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('paid')
  paid,
  @JsonValue('checked_in')
  checkedIn,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('refunded')
  refunded,
  @JsonValue('no_show')
  noShow;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case BookingStatus.unknown:
        return 0;
      case BookingStatus.pending:
        return 1;
      case BookingStatus.confirmed:
        return 2;
      case BookingStatus.paid:
        return 3;
      case BookingStatus.checkedIn:
        return 4;
      case BookingStatus.completed:
        return 5;
      case BookingStatus.cancelled:
        return 6;
      case BookingStatus.refunded:
        return 7;
      case BookingStatus.noShow:
        return 8;
    }
  }

  static BookingStatus fromStableId(int id) {
    switch (id) {
      case 0:
        return BookingStatus.unknown;
      case 1:
        return BookingStatus.pending;
      case 2:
        return BookingStatus.confirmed;
      case 3:
        return BookingStatus.paid;
      case 4:
        return BookingStatus.checkedIn;
      case 5:
        return BookingStatus.completed;
      case 6:
        return BookingStatus.cancelled;
      case 7:
        return BookingStatus.refunded;
      case 8:
        return BookingStatus.noShow;
      default:
        return BookingStatus.unknown;
    }
  }
}

enum BookingType {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('hourly')
  hourly,
  @JsonValue('daily')
  daily,
  @JsonValue('event')
  event,
  @JsonValue('tournament')
  tournament,
  @JsonValue('membership')
  membership;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case BookingType.unknown:
        return 0;
      case BookingType.hourly:
        return 1;
      case BookingType.daily:
        return 2;
      case BookingType.event:
        return 3;
      case BookingType.tournament:
        return 4;
      case BookingType.membership:
        return 5;
    }
  }

  static BookingType fromStableId(int id) {
    switch (id) {
      case 0:
        return BookingType.unknown;
      case 1:
        return BookingType.hourly;
      case 2:
        return BookingType.daily;
      case 3:
        return BookingType.event;
      case 4:
        return BookingType.tournament;
      case 5:
        return BookingType.membership;
      default:
        return BookingType.unknown;
    }
  }
}

/// Venue reviews and ratings
@Entity()
@JsonSerializable()
class VenueReview {
  @Id()
  int localId;

  @Unique()
  String id;
  String venueId;
  String reviewerId;
  String? bookingId;
  double rating;
  String? comment;
  List<String> tags; // clean, well-maintained, good-location
  List<String> images;
  bool isAnonymous;
  bool isPublic;
  bool isReported;
  String? venueResponse;
  @Property(type: PropertyType.date)
  DateTime? respondedAt;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  VenueReview({
    this.localId = 0,
    required this.id,
    required this.venueId,
    required this.reviewerId,
    this.bookingId,
    required this.rating,
    this.comment,
    this.tags = const [],
    this.images = const [],
    this.isAnonymous = false,
    this.isPublic = true,
    this.isReported = false,
    this.venueResponse,
    this.respondedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory VenueReview.fromJson(Map<String, dynamic> json) =>
      _$VenueReviewFromJson(json);
  Map<String, dynamic> toJson() => _$VenueReviewToJson(this);
}
