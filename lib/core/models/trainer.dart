import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'trainer.g.dart';

/// Trainer profile model
@Entity()
@JsonSerializable()
class Trainer {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId; // References User.id
  String businessName;
  String? tagline;
  String? bio;
  List<String> sportIds;
  List<String> specializations;
  List<String> certifications;
  List<String> qualifications;
  int? yearsOfExperience;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  TrainerType? type;

  // Stable database field for enum storage
  int? get dbType {
    return type?.stableId;
  }

  set dbType(int? value) {
    if (value == null) {
      type = null;
    } else {
      type = TrainerType.fromStableId(value);
    }
  }

  List<String> serviceAreas; // cities/locations served
  List<String> audienceTypes; // kids, adults, seniors
  String? gymAffiliation;
  String? website;
  String? instagramHandle;
  String? youtubeChannel;
  List<String> languagesSpoken;
  double? hourlyRate;
  String? currency;
  bool isAvailable;
  bool isVerified;
  double rating;
  int totalReviews;
  int totalStudents;
  int completedSessions;
  String? profileVideoUrl;
  List<String> portfolioImages;
  List<String> achievements;
  List<String> tags;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  Trainer({
    this.localId = 0,
    required this.id,
    required this.userId,
    required this.businessName,
    this.tagline,
    this.bio,
    this.sportIds = const [],
    this.specializations = const [],
    this.certifications = const [],
    this.qualifications = const [],
    this.yearsOfExperience,
    TrainerType? type,
    this.serviceAreas = const [],
    this.audienceTypes = const [],
    this.gymAffiliation,
    this.website,
    this.instagramHandle,
    this.youtubeChannel,
    this.languagesSpoken = const [],
    this.hourlyRate,
    this.currency,
    this.isAvailable = true,
    this.isVerified = false,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.totalStudents = 0,
    this.completedSessions = 0,
    this.profileVideoUrl,
    this.portfolioImages = const [],
    this.achievements = const [],
    this.tags = const [],
    this.createdAt,
    this.updatedAt,
  }) {
    this.type = type;
  }

  factory Trainer.fromJson(Map<String, dynamic> json) =>
      _$TrainerFromJson(json);
  Map<String, dynamic> toJson() => _$TrainerToJson(this);
}

enum TrainerType {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('individual')
  individual,
  @JsonValue('academy')
  academy,
  @JsonValue('group')
  group;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case TrainerType.unknown:
        return 0;
      case TrainerType.individual:
        return 1;
      case TrainerType.academy:
        return 2;
      case TrainerType.group:
        return 3;
    }
  }

  static TrainerType fromStableId(int id) {
    switch (id) {
      case 0:
        return TrainerType.unknown;
      case 1:
        return TrainerType.individual;
      case 2:
        return TrainerType.academy;
      case 3:
        return TrainerType.group;
      default:
        return TrainerType.unknown;
    }
  }
}

/// Training service offered by trainers
@Entity()
@JsonSerializable()
class TrainingService {
  @Id()
  int localId;

  @Unique()
  String id;
  String trainerId;
  String sportId;
  String name;
  String? description;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  ServiceType? type;

  // Stable database field for enum storage
  int? get dbType {
    return type?.stableId;
  }

  set dbType(int? value) {
    if (value == null) {
      type = null;
    } else {
      type = ServiceType.fromStableId(value);
    }
  }

  int duration; // in minutes
  double price;
  String? currency;
  int? maxParticipants;
  List<String> skillLevels;
  List<String> ageGroups;
  List<String> equipmentProvided;
  List<String> equipmentRequired;
  String? location;
  bool isActive;
  bool isOnline;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  TrainingService({
    this.localId = 0,
    required this.id,
    required this.trainerId,
    required this.sportId,
    required this.name,
    this.description,
    ServiceType? serviceType,
    required this.duration,
    required this.price,
    this.currency,
    this.maxParticipants,
    this.skillLevels = const [],
    this.ageGroups = const [],
    this.equipmentProvided = const [],
    this.equipmentRequired = const [],
    this.location,
    this.isActive = true,
    this.isOnline = false,
    this.createdAt,
    this.updatedAt,
  }) {
    this.type = serviceType;
  }

  factory TrainingService.fromJson(Map<String, dynamic> json) =>
      _$TrainingServiceFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingServiceToJson(this);
}

enum ServiceType {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('one_on_one')
  oneOnOne,
  @JsonValue('group')
  group,
  @JsonValue('workshop')
  workshop,
  @JsonValue('camp')
  camp,
  @JsonValue('online')
  online;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case ServiceType.unknown:
        return 0;
      case ServiceType.oneOnOne:
        return 1;
      case ServiceType.group:
        return 2;
      case ServiceType.workshop:
        return 3;
      case ServiceType.camp:
        return 4;
      case ServiceType.online:
        return 5;
    }
  }

  static ServiceType fromStableId(int id) {
    switch (id) {
      case 0:
        return ServiceType.unknown;
      case 1:
        return ServiceType.oneOnOne;
      case 2:
        return ServiceType.group;
      case 3:
        return ServiceType.workshop;
      case 4:
        return ServiceType.camp;
      case 5:
        return ServiceType.online;
      default:
        return ServiceType.unknown;
    }
  }
}

/// Training session bookings
@Entity()
@JsonSerializable()
class TrainingSession {
  @Id()
  int localId;

  @Unique()
  String id;
  String serviceId;
  String trainerId;
  String studentId;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  SessionStatus? status;

  // Stable database field for enum storage
  int? get dbStatus {
    return status?.stableId;
  }

  set dbStatus(int? value) {
    if (value == null) {
      status = null;
    } else {
      status = SessionStatus.fromStableId(value);
    }
  }

  @Property(type: PropertyType.date)
  DateTime scheduledAt;
  @Property(type: PropertyType.date)
  DateTime endsAt;
  String? location;
  String? notes;
  String? trainerNotes;
  String? studentNotes;
  List<String> participantIds; // for group sessions
  double? amount;
  String? currency;
  bool isPaid;
  @Property(type: PropertyType.date)
  DateTime? paidAt;
  String? paymentId;
  double? studentRating;
  String? studentFeedback;
  double? trainerRating;
  String? trainerFeedback;
  @Property(type: PropertyType.date)
  DateTime? completedAt;
  @Property(type: PropertyType.date)
  DateTime? cancelledAt;
  String? cancellationReason;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  TrainingSession({
    this.localId = 0,
    required this.id,
    required this.serviceId,
    required this.trainerId,
    required this.studentId,
    SessionStatus? sessionStatus,
    required this.scheduledAt,
    required this.endsAt,
    this.location,
    this.notes,
    this.trainerNotes,
    this.studentNotes,
    this.participantIds = const [],
    this.amount,
    this.currency,
    this.isPaid = false,
    this.paidAt,
    this.paymentId,
    this.studentRating,
    this.studentFeedback,
    this.trainerRating,
    this.trainerFeedback,
    this.completedAt,
    this.cancelledAt,
    this.cancellationReason,
    this.createdAt,
    this.updatedAt,
  }) {
    this.status = sessionStatus;
  }

  factory TrainingSession.fromJson(Map<String, dynamic> json) =>
      _$TrainingSessionFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingSessionToJson(this);
}

enum SessionStatus {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('scheduled')
  scheduled,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('no_show')
  noShow,
  @JsonValue('rescheduled')
  rescheduled;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case SessionStatus.unknown:
        return 0;
      case SessionStatus.scheduled:
        return 1;
      case SessionStatus.confirmed:
        return 2;
      case SessionStatus.inProgress:
        return 3;
      case SessionStatus.completed:
        return 4;
      case SessionStatus.cancelled:
        return 5;
      case SessionStatus.noShow:
        return 6;
      case SessionStatus.rescheduled:
        return 7;
    }
  }

  static SessionStatus fromStableId(int id) {
    switch (id) {
      case 0:
        return SessionStatus.unknown;
      case 1:
        return SessionStatus.scheduled;
      case 2:
        return SessionStatus.confirmed;
      case 3:
        return SessionStatus.inProgress;
      case 4:
        return SessionStatus.completed;
      case 5:
        return SessionStatus.cancelled;
      case 6:
        return SessionStatus.noShow;
      case 7:
        return SessionStatus.rescheduled;
      default:
        return SessionStatus.unknown;
    }
  }
}

/// Trainer reviews and ratings
@Entity()
@JsonSerializable()
class TrainerReview {
  @Id()
  int localId;

  @Unique()
  String id;
  String trainerId;
  String reviewerId;
  String? sessionId;
  double rating;
  String? comment;
  List<String> tags; // helpful, punctual, knowledgeable
  bool isAnonymous;
  bool isPublic;
  bool isReported;
  String? trainerResponse;
  @Property(type: PropertyType.date)
  DateTime? respondedAt;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  TrainerReview({
    this.localId = 0,
    required this.id,
    required this.trainerId,
    required this.reviewerId,
    this.sessionId,
    required this.rating,
    this.comment,
    this.tags = const [],
    this.isAnonymous = false,
    this.isPublic = true,
    this.isReported = false,
    this.trainerResponse,
    this.respondedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory TrainerReview.fromJson(Map<String, dynamic> json) =>
      _$TrainerReviewFromJson(json);
  Map<String, dynamic> toJson() => _$TrainerReviewToJson(this);
}
