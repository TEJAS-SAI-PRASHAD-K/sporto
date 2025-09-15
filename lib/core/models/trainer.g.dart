// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trainer _$TrainerFromJson(Map<String, dynamic> json) => Trainer(
  data: (json['data'] as List<dynamic>)
      .map((e) => Datum.fromJson(e as Map<String, dynamic>))
      .toList(),
  meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TrainerToJson(Trainer instance) => <String, dynamic>{
  'data': instance.data,
  'meta': instance.meta,
};

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
  id: (json['id'] as num).toInt(),
  documentId: json['documentId'] as String,
  trainer: TrainerClass.fromJson(json['trainer'] as Map<String, dynamic>),
  trainingService: TrainingService.fromJson(
    json['trainingService'] as Map<String, dynamic>,
  ),
  trainerReview: TrainerReview.fromJson(
    json['trainerReview'] as Map<String, dynamic>,
  ),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  publishedAt: DateTime.parse(json['publishedAt'] as String),
);

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
  'id': instance.id,
  'documentId': instance.documentId,
  'trainer': instance.trainer,
  'trainingService': instance.trainingService,
  'trainerReview': instance.trainerReview,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  'publishedAt': instance.publishedAt.toIso8601String(),
};

TrainerClass _$TrainerClassFromJson(Map<String, dynamic> json) => TrainerClass(
  id: json['id'] as String,
  bio: json['bio'] as String,
  email: json['email'] as String,
  avatar: (json['avatar'] as List<dynamic>).map((e) => e as String).toList(),
  rating: (json['rating'] as num).toDouble(),
  userId: json['userId'] as String,
  currency: json['currency'] as String,
  lastName: json['lastName'] as String,
  schedule: (json['schedule'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  sportIds: (json['sportIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  firstName: json['firstName'] as String,
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  hourlyRate: (json['hourlyRate'] as num).toInt(),
  isVerified: json['isVerified'] as bool,
  isAvailable: json['isAvailable'] as bool,
  achievements: (json['achievements'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  businessName: json['businessName'] as String,
  serviceAreas: (json['serviceAreas'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  serviceVenue: json['serviceVenue'] as String,
  sessionTypes: (json['sessionTypes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  totalReviews: (json['totalReviews'] as num).toInt(),
  audienceTypes: (json['audienceTypes'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  languagesSpoken: (json['languagesSpoken'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  specializations: (json['specializations'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  completedSessions: (json['completedSessions'] as num).toInt(),
);

Map<String, dynamic> _$TrainerClassToJson(TrainerClass instance) =>
    <String, dynamic>{
      'id': instance.id,
      'bio': instance.bio,
      'email': instance.email,
      'avatar': instance.avatar,
      'rating': instance.rating,
      'userId': instance.userId,
      'currency': instance.currency,
      'lastName': instance.lastName,
      'schedule': instance.schedule,
      'sportIds': instance.sportIds,
      'createdAt': instance.createdAt.toIso8601String(),
      'firstName': instance.firstName,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'hourlyRate': instance.hourlyRate,
      'isVerified': instance.isVerified,
      'isAvailable': instance.isAvailable,
      'achievements': instance.achievements,
      'businessName': instance.businessName,
      'serviceAreas': instance.serviceAreas,
      'serviceVenue': instance.serviceVenue,
      'sessionTypes': instance.sessionTypes,
      'totalReviews': instance.totalReviews,
      'audienceTypes': instance.audienceTypes,
      'languagesSpoken': instance.languagesSpoken,
      'specializations': instance.specializations,
      'completedSessions': instance.completedSessions,
    };

TrainerReview _$TrainerReviewFromJson(Map<String, dynamic> json) =>
    TrainerReview(
      id: json['id'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String,
      isPublic: json['isPublic'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      sessionId: json['sessionId'] as String,
      trainerId: json['trainerId'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      isReported: json['isReported'] as bool,
      reviewerId: json['reviewerId'] as String,
      isAnonymous: json['isAnonymous'] as bool,
      respondedAt: DateTime.parse(json['respondedAt'] as String),
      trainerResponse: json['trainerResponse'] as String,
    );

Map<String, dynamic> _$TrainerReviewToJson(TrainerReview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
      'rating': instance.rating,
      'comment': instance.comment,
      'isPublic': instance.isPublic,
      'createdAt': instance.createdAt.toIso8601String(),
      'sessionId': instance.sessionId,
      'trainerId': instance.trainerId,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'isReported': instance.isReported,
      'reviewerId': instance.reviewerId,
      'isAnonymous': instance.isAnonymous,
      'respondedAt': instance.respondedAt.toIso8601String(),
      'trainerResponse': instance.trainerResponse,
    };

TrainingService _$TrainingServiceFromJson(Map<String, dynamic> json) =>
    TrainingService(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      price: (json['price'] as num).toInt(),
      sportId: json['sportId'] as String,
      currency: json['currency'] as String,
      duration: (json['duration'] as num).toInt(),
      isActive: json['isActive'] as bool,
      isOnline: json['isOnline'] as bool,
      location: json['location'] as String,
      ageGroups: (json['ageGroups'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      trainerId: json['trainerId'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      description: json['description'] as String,
      skillLevels: (json['skillLevels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      maxParticipants: (json['maxParticipants'] as num).toInt(),
    );

Map<String, dynamic> _$TrainingServiceToJson(TrainingService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'price': instance.price,
      'sportId': instance.sportId,
      'currency': instance.currency,
      'duration': instance.duration,
      'isActive': instance.isActive,
      'isOnline': instance.isOnline,
      'location': instance.location,
      'ageGroups': instance.ageGroups,
      'createdAt': instance.createdAt.toIso8601String(),
      'trainerId': instance.trainerId,
      'updatedAt': instance.updatedAt.toIso8601String(),
      'description': instance.description,
      'skillLevels': instance.skillLevels,
      'maxParticipants': instance.maxParticipants,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  pagination: Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
);

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  'pagination': instance.pagination,
};

Pagination _$PaginationFromJson(Map<String, dynamic> json) => Pagination(
  page: (json['page'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  pageCount: (json['pageCount'] as num).toInt(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$PaginationToJson(Pagination instance) =>
    <String, dynamic>{
      'page': instance.page,
      'pageSize': instance.pageSize,
      'pageCount': instance.pageCount,
      'total': instance.total,
    };
