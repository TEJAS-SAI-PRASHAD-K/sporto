import 'package:json_annotation/json_annotation.dart';

part 'trainer.g.dart';

@JsonSerializable()
class Trainer {
  @JsonKey(name: 'trainer_id')
  String trainerId;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  String? bio;

  @JsonKey(name: 'sport_id')
  String? sportId;

  @JsonKey(name: 'service_area')
  String? serviceArea;

  @JsonKey(name: 'audience_type')
  String? audienceType;

  String? address;

  @JsonKey(name: 'hourly_rate')
  double? hourlyRate;

  double? ratings;

  @JsonKey(name: 'total_reviews')
  int totalReviews;

  @JsonKey(name: 'avatar_url')
  String? avatarUrl;

  @JsonKey(name: 'email_address')
  String emailAddress;

  @JsonKey(name: 'mobile_number')
  String? mobileNumber;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  @JsonKey(name: 'is_available')
  bool isAvailable;

  Trainer({
    required this.trainerId,
    required this.firstName,
    this.lastName,
    this.bio,
    this.sportId,
    this.serviceArea,
    this.audienceType,
    this.address,
    this.hourlyRate,
    this.ratings,
    this.totalReviews = 0,
    this.avatarUrl,
    required this.emailAddress,
    this.mobileNumber,
    this.createdAt,
    this.updatedAt,
    this.isAvailable = true,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) =>
      _$TrainerFromJson(json);
  Map<String, dynamic> toJson() => _$TrainerToJson(this);
}

@JsonSerializable()
class TrainingService {
  @JsonKey(name: 'service_id')
  String serviceId;

  @JsonKey(name: 'trainer_id')
  String trainerId;

  @JsonKey(name: 'sport_id')
  String sportId;

  @JsonKey(name: 'service_name')
  String? serviceName;

  @JsonKey(name: 'service_description')
  String? serviceDescription;

  @JsonKey(name: 'service_type')
  ServiceType? serviceType;

  double? price;

  @JsonKey(name: 'age_group')
  String? ageGroup;

  @JsonKey(name: 'maximum_participants')
  int? maximumParticipants;

  @JsonKey(name: 'is_service_active')
  bool isServiceActive;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  TrainingService({
    required this.serviceId,
    required this.trainerId,
    required this.sportId,
    this.serviceName,
    this.serviceDescription,
    this.serviceType,
    this.price,
    this.ageGroup,
    this.maximumParticipants,
    this.isServiceActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory TrainingService.fromJson(Map<String, dynamic> json) =>
      _$TrainingServiceFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingServiceToJson(this);
}

enum ServiceType {
  @JsonValue('one-on-one')
  oneOnOne,
  @JsonValue('group')
  group,
}

@JsonSerializable()
class TrainingSession {
  @JsonKey(name: 'session_id')
  String sessionId;

  @JsonKey(name: 'service_id')
  String serviceId;

  @JsonKey(name: 'trainer_id')
  String trainerId;

  @JsonKey(name: 'student_user_id')
  String studentUserId;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  TrainingSession({
    required this.sessionId,
    required this.serviceId,
    required this.trainerId,
    required this.studentUserId,
    this.createdAt,
    this.updatedAt,
  });

  factory TrainingSession.fromJson(Map<String, dynamic> json) =>
      _$TrainingSessionFromJson(json);
  Map<String, dynamic> toJson() => _$TrainingSessionToJson(this);
}
