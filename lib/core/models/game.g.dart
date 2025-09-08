// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
  gameId: json['game_id'] as String,
  organiserUserId: json['organiser_user_id'] as String,
  sportId: json['sport_id'] as String,
  areaOfGame: json['area_of_game'] as String?,
  gameDate: json['game_date'] == null
      ? null
      : DateTime.parse(json['game_date'] as String),
  gameTime: json['game_time'] as String?,
  gameAccessType: json['game_access_type'] as String?,
  currentPlayersCount: (json['current_players_count'] as num?)?.toInt(),
  venueName: json['venue_name'] as String?,
  venueId: json['venue_id'] as String?,
  venueAddress: json['venue_address'] as String?,
  venueLatitude: (json['venue_latitude'] as num?)?.toDouble(),
  venueLongitude: (json['venue_longitude'] as num?)?.toDouble(),
  playerIds: (json['player_ids'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  waitlistUserIds: (json['waitlist_user_ids'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  gameRules: json['game_rules'] as String?,
  equipmentRequired: json['equipment_required'] as String?,
  equipmentProvided: json['equipment_provided'] as String?,
  requiresApproval: json['requires_approval'] as bool? ?? false,
  contactInformation: json['contact_information'] as String?,
  notes: json['notes'] as String?,
  viewCount: (json['view_count'] as num?)?.toInt() ?? 0,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  venuePartnerId: json['venue_partner_id'] as String?,
);

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
  'game_id': instance.gameId,
  'organiser_user_id': instance.organiserUserId,
  'sport_id': instance.sportId,
  'area_of_game': instance.areaOfGame,
  'game_date': instance.gameDate?.toIso8601String(),
  'game_time': instance.gameTime,
  'game_access_type': instance.gameAccessType,
  'current_players_count': instance.currentPlayersCount,
  'venue_name': instance.venueName,
  'venue_id': instance.venueId,
  'venue_address': instance.venueAddress,
  'venue_latitude': instance.venueLatitude,
  'venue_longitude': instance.venueLongitude,
  'player_ids': instance.playerIds,
  'waitlist_user_ids': instance.waitlistUserIds,
  'game_rules': instance.gameRules,
  'equipment_required': instance.equipmentRequired,
  'equipment_provided': instance.equipmentProvided,
  'requires_approval': instance.requiresApproval,
  'contact_information': instance.contactInformation,
  'notes': instance.notes,
  'view_count': instance.viewCount,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'venue_partner_id': instance.venuePartnerId,
};

GameInvite _$GameInviteFromJson(Map<String, dynamic> json) => GameInvite(
  inviteId: json['invite_id'] as String,
  gameId: json['game_id'] as String,
  inviterUserId: json['inviter_user_id'] as String,
  inviteeUserId: json['invitee_user_id'] as String,
  inviteStatus: json['invite_status'] as String?,
  sentAt: json['sent_at'] == null
      ? null
      : DateTime.parse(json['sent_at'] as String),
  respondedAt: json['responded_at'] == null
      ? null
      : DateTime.parse(json['responded_at'] as String),
  expiresAt: json['expires_at'] == null
      ? null
      : DateTime.parse(json['expires_at'] as String),
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$GameInviteToJson(GameInvite instance) =>
    <String, dynamic>{
      'invite_id': instance.inviteId,
      'game_id': instance.gameId,
      'inviter_user_id': instance.inviterUserId,
      'invitee_user_id': instance.inviteeUserId,
      'invite_status': instance.inviteStatus,
      'sent_at': instance.sentAt?.toIso8601String(),
      'responded_at': instance.respondedAt?.toIso8601String(),
      'expires_at': instance.expiresAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

GameParticipation _$GameParticipationFromJson(Map<String, dynamic> json) =>
    GameParticipation(
      participationId: json['participation_id'] as String,
      gameId: json['game_id'] as String,
      userId: json['user_id'] as String,
      participationStatus: json['participation_status'] as String?,
      joinedAt: json['joined_at'] == null
          ? null
          : DateTime.parse(json['joined_at'] as String),
      isOrganiser: json['is_organiser'] as bool? ?? false,
      hasPaid: json['has_paid'] as bool? ?? false,
      paidAt: json['paid_at'] == null
          ? null
          : DateTime.parse(json['paid_at'] as String),
      leftAt: json['left_at'] == null
          ? null
          : DateTime.parse(json['left_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$GameParticipationToJson(GameParticipation instance) =>
    <String, dynamic>{
      'participation_id': instance.participationId,
      'game_id': instance.gameId,
      'user_id': instance.userId,
      'participation_status': instance.participationStatus,
      'joined_at': instance.joinedAt?.toIso8601String(),
      'is_organiser': instance.isOrganiser,
      'has_paid': instance.hasPaid,
      'paid_at': instance.paidAt?.toIso8601String(),
      'left_at': instance.leftAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
