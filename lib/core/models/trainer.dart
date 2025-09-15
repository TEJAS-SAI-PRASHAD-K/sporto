import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'trainer.g.dart';

Trainer trainerFromJson(String str) => Trainer.fromJson(json.decode(str));

String trainerToJson(Trainer data) => json.encode(data.toJson());

@JsonSerializable()
class Trainer {
  @JsonKey(name: "data")
  final List<Datum> data;
  @JsonKey(name: "meta")
  final Meta meta;

  Trainer({required this.data, required this.meta});

  Trainer copyWith({List<Datum>? data, Meta? meta}) =>
      Trainer(data: data ?? this.data, meta: meta ?? this.meta);

  factory Trainer.fromJson(Map<String, dynamic> json) =>
      _$TrainerFromJson(json);

  Map<String, dynamic> toJson() => _$TrainerToJson(this);
}

@JsonSerializable()
class Datum {
  @JsonKey(name: "id")
  final int id;
  @JsonKey(name: "documentId")
  final String documentId;
  @JsonKey(name: "trainer")
  final TrainerClass trainer;
  @JsonKey(name: "trainingService")
  final TrainingService trainingService;
  @JsonKey(name: "trainerReview")
  final TrainerReview trainerReview;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  @JsonKey(name: "publishedAt")
  final DateTime publishedAt;

  Datum({
    required this.id,
    required this.documentId,
    required this.trainer,
    required this.trainingService,
    required this.trainerReview,
    required this.createdAt,
    required this.updatedAt,
    required this.publishedAt,
  });

  Datum copyWith({
    int? id,
    String? documentId,
    TrainerClass? trainer,
    TrainingService? trainingService,
    TrainerReview? trainerReview,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? publishedAt,
  }) => Datum(
    id: id ?? this.id,
    documentId: documentId ?? this.documentId,
    trainer: trainer ?? this.trainer,
    trainingService: trainingService ?? this.trainingService,
    trainerReview: trainerReview ?? this.trainerReview,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    publishedAt: publishedAt ?? this.publishedAt,
  );

  factory Datum.fromJson(Map<String, dynamic> json) => _$DatumFromJson(json);

  Map<String, dynamic> toJson() => _$DatumToJson(this);
}

@JsonSerializable()
class TrainerClass {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "bio")
  final String bio;
  @JsonKey(name: "email")
  final String email;
  @JsonKey(name: "avatar")
  final List<String> avatar;
  @JsonKey(name: "rating")
  final double rating;
  @JsonKey(name: "userId")
  final String userId;
  @JsonKey(name: "currency")
  final String currency;
  @JsonKey(name: "lastName")
  final String lastName;
  @JsonKey(name: "schedule")
  final List<String> schedule;
  @JsonKey(name: "sportIds")
  final List<String> sportIds;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "firstName")
  final String firstName;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  @JsonKey(name: "hourlyRate")
  final int hourlyRate;
  @JsonKey(name: "isVerified")
  final bool isVerified;
  @JsonKey(name: "isAvailable")
  final bool isAvailable;
  @JsonKey(name: "achievements")
  final List<String> achievements;
  @JsonKey(name: "businessName")
  final String businessName;
  @JsonKey(name: "serviceAreas")
  final List<String> serviceAreas;
  @JsonKey(name: "serviceVenue")
  final String serviceVenue;
  @JsonKey(name: "sessionTypes")
  final List<String> sessionTypes;
  @JsonKey(name: "totalReviews")
  final int totalReviews;
  @JsonKey(name: "audienceTypes")
  final List<String> audienceTypes;
  @JsonKey(name: "languagesSpoken")
  final List<String> languagesSpoken;
  @JsonKey(name: "specializations")
  final List<String> specializations;
  @JsonKey(name: "completedSessions")
  final int completedSessions;

  TrainerClass({
    required this.id,
    required this.bio,
    required this.email,
    required this.avatar,
    required this.rating,
    required this.userId,
    required this.currency,
    required this.lastName,
    required this.schedule,
    required this.sportIds,
    required this.createdAt,
    required this.firstName,
    required this.updatedAt,
    required this.hourlyRate,
    required this.isVerified,
    required this.isAvailable,
    required this.achievements,
    required this.businessName,
    required this.serviceAreas,
    required this.serviceVenue,
    required this.sessionTypes,
    required this.totalReviews,
    required this.audienceTypes,
    required this.languagesSpoken,
    required this.specializations,
    required this.completedSessions,
  });

  TrainerClass copyWith({
    String? id,
    String? bio,
    String? email,
    List<String>? avatar,
    double? rating,
    String? userId,
    String? currency,
    String? lastName,
    List<String>? schedule,
    List<String>? sportIds,
    DateTime? createdAt,
    String? firstName,
    DateTime? updatedAt,
    int? hourlyRate,
    bool? isVerified,
    bool? isAvailable,
    List<String>? achievements,
    String? businessName,
    List<String>? serviceAreas,
    String? serviceVenue,
    List<String>? sessionTypes,
    int? totalReviews,
    List<String>? audienceTypes,
    List<String>? languagesSpoken,
    List<String>? specializations,
    int? completedSessions,
  }) => TrainerClass(
    id: id ?? this.id,
    bio: bio ?? this.bio,
    email: email ?? this.email,
    avatar: avatar ?? this.avatar,
    rating: rating ?? this.rating,
    userId: userId ?? this.userId,
    currency: currency ?? this.currency,
    lastName: lastName ?? this.lastName,
    schedule: schedule ?? this.schedule,
    sportIds: sportIds ?? this.sportIds,
    createdAt: createdAt ?? this.createdAt,
    firstName: firstName ?? this.firstName,
    updatedAt: updatedAt ?? this.updatedAt,
    hourlyRate: hourlyRate ?? this.hourlyRate,
    isVerified: isVerified ?? this.isVerified,
    isAvailable: isAvailable ?? this.isAvailable,
    achievements: achievements ?? this.achievements,
    businessName: businessName ?? this.businessName,
    serviceAreas: serviceAreas ?? this.serviceAreas,
    serviceVenue: serviceVenue ?? this.serviceVenue,
    sessionTypes: sessionTypes ?? this.sessionTypes,
    totalReviews: totalReviews ?? this.totalReviews,
    audienceTypes: audienceTypes ?? this.audienceTypes,
    languagesSpoken: languagesSpoken ?? this.languagesSpoken,
    specializations: specializations ?? this.specializations,
    completedSessions: completedSessions ?? this.completedSessions,
  );

  factory TrainerClass.fromJson(Map<String, dynamic> json) =>
      _$TrainerClassFromJson(json);

  Map<String, dynamic> toJson() => _$TrainerClassToJson(this);
}

@JsonSerializable()
class TrainerReview {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "tags")
  final List<String> tags;
  @JsonKey(name: "rating")
  final double rating;
  @JsonKey(name: "comment")
  final String comment;
  @JsonKey(name: "isPublic")
  final bool isPublic;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "sessionId")
  final String sessionId;
  @JsonKey(name: "trainerId")
  final String trainerId;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  @JsonKey(name: "isReported")
  final bool isReported;
  @JsonKey(name: "reviewerId")
  final String reviewerId;
  @JsonKey(name: "isAnonymous")
  final bool isAnonymous;
  @JsonKey(name: "respondedAt")
  final DateTime respondedAt;
  @JsonKey(name: "trainerResponse")
  final String trainerResponse;

  TrainerReview({
    required this.id,
    required this.tags,
    required this.rating,
    required this.comment,
    required this.isPublic,
    required this.createdAt,
    required this.sessionId,
    required this.trainerId,
    required this.updatedAt,
    required this.isReported,
    required this.reviewerId,
    required this.isAnonymous,
    required this.respondedAt,
    required this.trainerResponse,
  });

  TrainerReview copyWith({
    String? id,
    List<String>? tags,
    double? rating,
    String? comment,
    bool? isPublic,
    DateTime? createdAt,
    String? sessionId,
    String? trainerId,
    DateTime? updatedAt,
    bool? isReported,
    String? reviewerId,
    bool? isAnonymous,
    DateTime? respondedAt,
    String? trainerResponse,
  }) => TrainerReview(
    id: id ?? this.id,
    tags: tags ?? this.tags,
    rating: rating ?? this.rating,
    comment: comment ?? this.comment,
    isPublic: isPublic ?? this.isPublic,
    createdAt: createdAt ?? this.createdAt,
    sessionId: sessionId ?? this.sessionId,
    trainerId: trainerId ?? this.trainerId,
    updatedAt: updatedAt ?? this.updatedAt,
    isReported: isReported ?? this.isReported,
    reviewerId: reviewerId ?? this.reviewerId,
    isAnonymous: isAnonymous ?? this.isAnonymous,
    respondedAt: respondedAt ?? this.respondedAt,
    trainerResponse: trainerResponse ?? this.trainerResponse,
  );

  factory TrainerReview.fromJson(Map<String, dynamic> json) =>
      _$TrainerReviewFromJson(json);

  Map<String, dynamic> toJson() => _$TrainerReviewToJson(this);
}

@JsonSerializable()
class TrainingService {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "type")
  final String type;
  @JsonKey(name: "price")
  final int price;
  @JsonKey(name: "sportId")
  final String sportId;
  @JsonKey(name: "currency")
  final String currency;
  @JsonKey(name: "duration")
  final int duration;
  @JsonKey(name: "isActive")
  final bool isActive;
  @JsonKey(name: "isOnline")
  final bool isOnline;
  @JsonKey(name: "location")
  final String location;
  @JsonKey(name: "ageGroups")
  final List<String> ageGroups;
  @JsonKey(name: "createdAt")
  final DateTime createdAt;
  @JsonKey(name: "trainerId")
  final String trainerId;
  @JsonKey(name: "updatedAt")
  final DateTime updatedAt;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "skillLevels")
  final List<String> skillLevels;
  @JsonKey(name: "maxParticipants")
  final int maxParticipants;

  TrainingService({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.sportId,
    required this.currency,
    required this.duration,
    required this.isActive,
    required this.isOnline,
    required this.location,
    required this.ageGroups,
    required this.createdAt,
    required this.trainerId,
    required this.updatedAt,
    required this.description,
    required this.skillLevels,
    required this.maxParticipants,
  });

  TrainingService copyWith({
    String? id,
    String? name,
    String? type,
    int? price,
    String? sportId,
    String? currency,
    int? duration,
    bool? isActive,
    bool? isOnline,
    String? location,
    List<String>? ageGroups,
    DateTime? createdAt,
    String? trainerId,
    DateTime? updatedAt,
    String? description,
    List<String>? skillLevels,
    int? maxParticipants,
  }) => TrainingService(
    id: id ?? this.id,
    name: name ?? this.name,
    type: type ?? this.type,
    price: price ?? this.price,
    sportId: sportId ?? this.sportId,
    currency: currency ?? this.currency,
    duration: duration ?? this.duration,
    isActive: isActive ?? this.isActive,
    isOnline: isOnline ?? this.isOnline,
    location: location ?? this.location,
    ageGroups: ageGroups ?? this.ageGroups,
    createdAt: createdAt ?? this.createdAt,
    trainerId: trainerId ?? this.trainerId,
    updatedAt: updatedAt ?? this.updatedAt,
    description: description ?? this.description,
    skillLevels: skillLevels ?? this.skillLevels,
    maxParticipants: maxParticipants ?? this.maxParticipants,
  );

  factory TrainingService.fromJson(Map<String, dynamic> json) =>
      _$TrainingServiceFromJson(json);

  Map<String, dynamic> toJson() => _$TrainingServiceToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "pagination")
  final Pagination pagination;

  Meta({required this.pagination});

  Meta copyWith({Pagination? pagination}) =>
      Meta(pagination: pagination ?? this.pagination);

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class Pagination {
  @JsonKey(name: "page")
  final int page;
  @JsonKey(name: "pageSize")
  final int pageSize;
  @JsonKey(name: "pageCount")
  final int pageCount;
  @JsonKey(name: "total")
  final int total;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.pageCount,
    required this.total,
  });

  Pagination copyWith({int? page, int? pageSize, int? pageCount, int? total}) =>
      Pagination(
        page: page ?? this.page,
        pageSize: pageSize ?? this.pageSize,
        pageCount: pageCount ?? this.pageCount,
        total: total ?? this.total,
      );

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}
