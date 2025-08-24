// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  organizerId: json['organizerId'] as String,
  sportId: json['sportId'] as String,
  title: json['title'] as String,
  description: json['description'] as String?,
  gameType: json['gameType'] as String,
  skillLevel: json['skillLevel'] as String,
  status:
      $enumDecodeNullable(_$GameStatusEnumMap, json['status']) ??
      GameStatus.draft,
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
  venueId: json['venueId'] as String?,
  venueName: json['venueName'] as String?,
  venueAddress: json['venueAddress'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  capacity: (json['capacity'] as num).toInt(),
  currentPlayers: (json['currentPlayers'] as num?)?.toInt() ?? 0,
  playerIds:
      (json['playerIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  waitlistIds:
      (json['waitlistIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  entryFee: (json['entryFee'] as num?)?.toDouble(),
  currency: json['currency'] as String?,
  rules:
      (json['rules'] as List<dynamic>?)?.map((e) => e as String).toList() ??
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
  isPublic: json['isPublic'] as bool? ?? true,
  allowWaitlist: json['allowWaitlist'] as bool? ?? false,
  requiresApproval: json['requiresApproval'] as bool? ?? false,
  contactInfo: json['contactInfo'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  notes: json['notes'] as String?,
  rating: (json['rating'] as num?)?.toInt(),
  viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
)..dbStatus = (json['dbStatus'] as num?)?.toInt();

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
  'localId': instance.localId,
  'id': instance.id,
  'organizerId': instance.organizerId,
  'sportId': instance.sportId,
  'title': instance.title,
  'description': instance.description,
  'gameType': instance.gameType,
  'skillLevel': instance.skillLevel,
  'status': _$GameStatusEnumMap[instance.status],
  'dbStatus': instance.dbStatus,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'venueId': instance.venueId,
  'venueName': instance.venueName,
  'venueAddress': instance.venueAddress,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'capacity': instance.capacity,
  'currentPlayers': instance.currentPlayers,
  'playerIds': instance.playerIds,
  'waitlistIds': instance.waitlistIds,
  'entryFee': instance.entryFee,
  'currency': instance.currency,
  'rules': instance.rules,
  'equipmentProvided': instance.equipmentProvided,
  'equipmentRequired': instance.equipmentRequired,
  'isPublic': instance.isPublic,
  'allowWaitlist': instance.allowWaitlist,
  'requiresApproval': instance.requiresApproval,
  'contactInfo': instance.contactInfo,
  'tags': instance.tags,
  'notes': instance.notes,
  'rating': instance.rating,
  'viewCount': instance.viewCount,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$GameStatusEnumMap = {
  GameStatus.unknown: 'unknown',
  GameStatus.draft: 'draft',
  GameStatus.published: 'published',
  GameStatus.full: 'full',
  GameStatus.inProgress: 'in_progress',
  GameStatus.completed: 'completed',
  GameStatus.cancelled: 'cancelled',
};

GameParticipation _$GameParticipationFromJson(Map<String, dynamic> json) =>
    GameParticipation(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      gameId: json['gameId'] as String,
      userId: json['userId'] as String,
      status:
          $enumDecodeNullable(_$ParticipationStatusEnumMap, json['status']) ??
          ParticipationStatus.requested,
      joinedAt: DateTime.parse(json['joinedAt'] as String),
      position: json['position'] as String?,
      partnerUserId: json['partnerUserId'] as String?,
      notes: json['notes'] as String?,
      ratingGiven: (json['ratingGiven'] as num?)?.toDouble(),
      feedback: json['feedback'] as String?,
      isOrganizer: json['isOrganizer'] as bool? ?? false,
      isPaid: json['isPaid'] as bool? ?? false,
      paidAt: json['paidAt'] == null
          ? null
          : DateTime.parse(json['paidAt'] as String),
      leftAt: json['leftAt'] == null
          ? null
          : DateTime.parse(json['leftAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    )..dbStatus = (json['dbStatus'] as num?)?.toInt();

Map<String, dynamic> _$GameParticipationToJson(GameParticipation instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'gameId': instance.gameId,
      'userId': instance.userId,
      'status': _$ParticipationStatusEnumMap[instance.status],
      'dbStatus': instance.dbStatus,
      'joinedAt': instance.joinedAt.toIso8601String(),
      'position': instance.position,
      'partnerUserId': instance.partnerUserId,
      'notes': instance.notes,
      'ratingGiven': instance.ratingGiven,
      'feedback': instance.feedback,
      'isOrganizer': instance.isOrganizer,
      'isPaid': instance.isPaid,
      'paidAt': instance.paidAt?.toIso8601String(),
      'leftAt': instance.leftAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ParticipationStatusEnumMap = {
  ParticipationStatus.unknown: 'unknown',
  ParticipationStatus.requested: 'requested',
  ParticipationStatus.confirmed: 'confirmed',
  ParticipationStatus.waitlisted: 'waitlisted',
  ParticipationStatus.declined: 'declined',
  ParticipationStatus.cancelled: 'cancelled',
  ParticipationStatus.attended: 'attended',
  ParticipationStatus.noShow: 'no_show',
};

GameInvite _$GameInviteFromJson(Map<String, dynamic> json) => GameInvite(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  gameId: json['gameId'] as String,
  inviterId: json['inviterId'] as String,
  inviteeId: json['inviteeId'] as String,
  status:
      $enumDecodeNullable(_$InviteStatusEnumMap, json['status']) ??
      InviteStatus.pending,
  message: json['message'] as String?,
  sentAt: json['sentAt'] == null
      ? null
      : DateTime.parse(json['sentAt'] as String),
  respondedAt: json['respondedAt'] == null
      ? null
      : DateTime.parse(json['respondedAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  response: json['response'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
)..dbStatus = (json['dbStatus'] as num?)?.toInt();

Map<String, dynamic> _$GameInviteToJson(GameInvite instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'gameId': instance.gameId,
      'inviterId': instance.inviterId,
      'inviteeId': instance.inviteeId,
      'status': _$InviteStatusEnumMap[instance.status],
      'dbStatus': instance.dbStatus,
      'message': instance.message,
      'sentAt': instance.sentAt?.toIso8601String(),
      'respondedAt': instance.respondedAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'response': instance.response,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$InviteStatusEnumMap = {
  InviteStatus.unknown: 'unknown',
  InviteStatus.pending: 'pending',
  InviteStatus.accepted: 'accepted',
  InviteStatus.declined: 'declined',
  InviteStatus.expired: 'expired',
  InviteStatus.cancelled: 'cancelled',
};
