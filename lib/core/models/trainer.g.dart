// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trainer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Trainer _$TrainerFromJson(Map<String, dynamic> json) => Trainer(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  userId: json['userId'] as String,
  businessName: json['businessName'] as String,
  tagline: json['tagline'] as String?,
  bio: json['bio'] as String?,
  sportIds:
      (json['sportIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  specializations:
      (json['specializations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  certifications:
      (json['certifications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  qualifications:
      (json['qualifications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt(),
  type: $enumDecodeNullable(_$TrainerTypeEnumMap, json['type']),
  serviceAreas:
      (json['serviceAreas'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  audienceTypes:
      (json['audienceTypes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  gymAffiliation: json['gymAffiliation'] as String?,
  website: json['website'] as String?,
  instagramHandle: json['instagramHandle'] as String?,
  youtubeChannel: json['youtubeChannel'] as String?,
  languagesSpoken:
      (json['languagesSpoken'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  hourlyRate: (json['hourlyRate'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
  isAvailable: json['isAvailable'] as bool? ?? true,
  isVerified: json['isVerified'] as bool? ?? false,
  rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
  totalReviews: (json['totalReviews'] as num?)?.toInt() ?? 0,
  totalStudents: (json['totalStudents'] as num?)?.toInt() ?? 0,
  completedSessions: (json['completedSessions'] as num?)?.toInt() ?? 0,
  profileVideoUrl: json['profileVideoUrl'] as String?,
  portfolioImages:
      (json['portfolioImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  achievements:
      (json['achievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
)..dbType = (json['dbType'] as num?)?.toInt();

Map<String, dynamic> _$TrainerToJson(Trainer instance) => <String, dynamic>{
  'localId': instance.localId,
  'id': instance.id,
  'userId': instance.userId,
  'businessName': instance.businessName,
  'tagline': instance.tagline,
  'bio': instance.bio,
  'sportIds': instance.sportIds,
  'specializations': instance.specializations,
  'certifications': instance.certifications,
  'qualifications': instance.qualifications,
  'yearsOfExperience': instance.yearsOfExperience,
  'type': _$TrainerTypeEnumMap[instance.type],
  'dbType': instance.dbType,
  'serviceAreas': instance.serviceAreas,
  'audienceTypes': instance.audienceTypes,
  'gymAffiliation': instance.gymAffiliation,
  'website': instance.website,
  'instagramHandle': instance.instagramHandle,
  'youtubeChannel': instance.youtubeChannel,
  'languagesSpoken': instance.languagesSpoken,
  'hourlyRate': instance.hourlyRate,
  'currency': instance.currency,
  'isAvailable': instance.isAvailable,
  'isVerified': instance.isVerified,
  'rating': instance.rating,
  'totalReviews': instance.totalReviews,
  'totalStudents': instance.totalStudents,
  'completedSessions': instance.completedSessions,
  'profileVideoUrl': instance.profileVideoUrl,
  'portfolioImages': instance.portfolioImages,
  'achievements': instance.achievements,
  'tags': instance.tags,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$TrainerTypeEnumMap = {
  TrainerType.unknown: 'unknown',
  TrainerType.individual: 'individual',
  TrainerType.academy: 'academy',
  TrainerType.group: 'group',
};

TrainingService _$TrainingServiceFromJson(Map<String, dynamic> json) =>
    TrainingService(
        localId: (json['localId'] as num?)?.toInt() ?? 0,
        id: json['id'] as String,
        trainerId: json['trainerId'] as String,
        sportId: json['sportId'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        duration: (json['duration'] as num).toInt(),
        price: (json['price'] as num).toDouble(),
        currency: json['currency'] as String?,
        maxParticipants: (json['maxParticipants'] as num?)?.toInt(),
        skillLevels:
            (json['skillLevels'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        ageGroups:
            (json['ageGroups'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        equipmentProvided:
            (json['equipmentProvided'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        equipmentRequired:
            (json['equipmentRequired'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        location: json['location'] as String?,
        isActive: json['isActive'] as bool? ?? true,
        isOnline: json['isOnline'] as bool? ?? false,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      )
      ..type = $enumDecodeNullable(_$ServiceTypeEnumMap, json['type'])
      ..dbType = (json['dbType'] as num?)?.toInt();

Map<String, dynamic> _$TrainingServiceToJson(TrainingService instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'trainerId': instance.trainerId,
      'sportId': instance.sportId,
      'name': instance.name,
      'description': instance.description,
      'type': _$ServiceTypeEnumMap[instance.type],
      'dbType': instance.dbType,
      'duration': instance.duration,
      'price': instance.price,
      'currency': instance.currency,
      'maxParticipants': instance.maxParticipants,
      'skillLevels': instance.skillLevels,
      'ageGroups': instance.ageGroups,
      'equipmentProvided': instance.equipmentProvided,
      'equipmentRequired': instance.equipmentRequired,
      'location': instance.location,
      'isActive': instance.isActive,
      'isOnline': instance.isOnline,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ServiceTypeEnumMap = {
  ServiceType.unknown: 'unknown',
  ServiceType.oneOnOne: 'one_on_one',
  ServiceType.group: 'group',
  ServiceType.workshop: 'workshop',
  ServiceType.camp: 'camp',
  ServiceType.online: 'online',
};

TrainingSession _$TrainingSessionFromJson(Map<String, dynamic> json) =>
    TrainingSession(
        localId: (json['localId'] as num?)?.toInt() ?? 0,
        id: json['id'] as String,
        serviceId: json['serviceId'] as String,
        trainerId: json['trainerId'] as String,
        studentId: json['studentId'] as String,
        scheduledAt: DateTime.parse(json['scheduledAt'] as String),
        endsAt: DateTime.parse(json['endsAt'] as String),
        location: json['location'] as String?,
        notes: json['notes'] as String?,
        trainerNotes: json['trainerNotes'] as String?,
        studentNotes: json['studentNotes'] as String?,
        participantIds:
            (json['participantIds'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        amount: (json['amount'] as num?)?.toDouble(),
        currency: json['currency'] as String?,
        isPaid: json['isPaid'] as bool? ?? false,
        paidAt: json['paidAt'] == null
            ? null
            : DateTime.parse(json['paidAt'] as String),
        paymentId: json['paymentId'] as String?,
        studentRating: (json['studentRating'] as num?)?.toDouble(),
        studentFeedback: json['studentFeedback'] as String?,
        trainerRating: (json['trainerRating'] as num?)?.toDouble(),
        trainerFeedback: json['trainerFeedback'] as String?,
        completedAt: json['completedAt'] == null
            ? null
            : DateTime.parse(json['completedAt'] as String),
        cancelledAt: json['cancelledAt'] == null
            ? null
            : DateTime.parse(json['cancelledAt'] as String),
        cancellationReason: json['cancellationReason'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      )
      ..status = $enumDecodeNullable(_$SessionStatusEnumMap, json['status'])
      ..dbStatus = (json['dbStatus'] as num?)?.toInt();

Map<String, dynamic> _$TrainingSessionToJson(TrainingSession instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'serviceId': instance.serviceId,
      'trainerId': instance.trainerId,
      'studentId': instance.studentId,
      'status': _$SessionStatusEnumMap[instance.status],
      'dbStatus': instance.dbStatus,
      'scheduledAt': instance.scheduledAt.toIso8601String(),
      'endsAt': instance.endsAt.toIso8601String(),
      'location': instance.location,
      'notes': instance.notes,
      'trainerNotes': instance.trainerNotes,
      'studentNotes': instance.studentNotes,
      'participantIds': instance.participantIds,
      'amount': instance.amount,
      'currency': instance.currency,
      'isPaid': instance.isPaid,
      'paidAt': instance.paidAt?.toIso8601String(),
      'paymentId': instance.paymentId,
      'studentRating': instance.studentRating,
      'studentFeedback': instance.studentFeedback,
      'trainerRating': instance.trainerRating,
      'trainerFeedback': instance.trainerFeedback,
      'completedAt': instance.completedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'cancellationReason': instance.cancellationReason,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$SessionStatusEnumMap = {
  SessionStatus.unknown: 'unknown',
  SessionStatus.scheduled: 'scheduled',
  SessionStatus.confirmed: 'confirmed',
  SessionStatus.inProgress: 'in_progress',
  SessionStatus.completed: 'completed',
  SessionStatus.cancelled: 'cancelled',
  SessionStatus.noShow: 'no_show',
  SessionStatus.rescheduled: 'rescheduled',
};

TrainerReview _$TrainerReviewFromJson(Map<String, dynamic> json) =>
    TrainerReview(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      trainerId: json['trainerId'] as String,
      reviewerId: json['reviewerId'] as String,
      sessionId: json['sessionId'] as String?,
      rating: (json['rating'] as num).toDouble(),
      comment: json['comment'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      isAnonymous: json['isAnonymous'] as bool? ?? false,
      isPublic: json['isPublic'] as bool? ?? true,
      isReported: json['isReported'] as bool? ?? false,
      trainerResponse: json['trainerResponse'] as String?,
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

Map<String, dynamic> _$TrainerReviewToJson(TrainerReview instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'trainerId': instance.trainerId,
      'reviewerId': instance.reviewerId,
      'sessionId': instance.sessionId,
      'rating': instance.rating,
      'comment': instance.comment,
      'tags': instance.tags,
      'isAnonymous': instance.isAnonymous,
      'isPublic': instance.isPublic,
      'isReported': instance.isReported,
      'trainerResponse': instance.trainerResponse,
      'respondedAt': instance.respondedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
