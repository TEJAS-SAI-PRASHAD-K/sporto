// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trainer _$TrainerFromJson(Map<String, dynamic> json) => Trainer(
  trainerId: json['trainer_id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String?,
  bio: json['bio'] as String?,
  sportId: json['sport_id'] as String?,
  serviceArea: json['service_area'] as String?,
  audienceType: json['audience_type'] as String?,
  address: json['address'] as String?,
  hourlyRate: (json['hourly_rate'] as num?)?.toDouble(),
  ratings: (json['ratings'] as num?)?.toDouble(),
  totalReviews: (json['total_reviews'] as num?)?.toInt() ?? 0,
  avatarUrl: json['avatar_url'] as String?,
  emailAddress: json['email_address'] as String,
  mobileNumber: json['mobile_number'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  isAvailable: json['is_available'] as bool? ?? true,
);

Map<String, dynamic> _$TrainerToJson(Trainer instance) => <String, dynamic>{
  'trainer_id': instance.trainerId,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'bio': instance.bio,
  'sport_id': instance.sportId,
  'service_area': instance.serviceArea,
  'audience_type': instance.audienceType,
  'address': instance.address,
  'hourly_rate': instance.hourlyRate,
  'ratings': instance.ratings,
  'total_reviews': instance.totalReviews,
  'avatar_url': instance.avatarUrl,
  'email_address': instance.emailAddress,
  'mobile_number': instance.mobileNumber,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'is_available': instance.isAvailable,
};

TrainingService _$TrainingServiceFromJson(Map<String, dynamic> json) =>
    TrainingService(
      serviceId: json['service_id'] as String,
      trainerId: json['trainer_id'] as String,
      sportId: json['sport_id'] as String,
      serviceName: json['service_name'] as String?,
      serviceDescription: json['service_description'] as String?,
      serviceType: $enumDecodeNullable(
        _$ServiceTypeEnumMap,
        json['service_type'],
      ),
      price: (json['price'] as num?)?.toDouble(),
      ageGroup: json['age_group'] as String?,
      maximumParticipants: (json['maximum_participants'] as num?)?.toInt(),
      isServiceActive: json['is_service_active'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TrainingServiceToJson(TrainingService instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'trainer_id': instance.trainerId,
      'sport_id': instance.sportId,
      'service_name': instance.serviceName,
      'service_description': instance.serviceDescription,
      'service_type': _$ServiceTypeEnumMap[instance.serviceType],
      'price': instance.price,
      'age_group': instance.ageGroup,
      'maximum_participants': instance.maximumParticipants,
      'is_service_active': instance.isServiceActive,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$ServiceTypeEnumMap = {
  ServiceType.oneOnOne: 'one-on-one',
  ServiceType.group: 'group',
};

TrainingSession _$TrainingSessionFromJson(Map<String, dynamic> json) =>
    TrainingSession(
      sessionId: json['session_id'] as String,
      serviceId: json['service_id'] as String,
      trainerId: json['trainer_id'] as String,
      studentUserId: json['student_user_id'] as String,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$TrainingSessionToJson(TrainingSession instance) =>
    <String, dynamic>{
      'session_id': instance.sessionId,
      'service_id': instance.serviceId,
      'trainer_id': instance.trainerId,
      'student_user_id': instance.studentUserId,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
