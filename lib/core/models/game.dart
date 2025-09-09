import 'package:json_annotation/json_annotation.dart';

part 'game.g.dart';

@JsonSerializable()
class Game {
  @JsonKey(name: 'game_id')
  String gameId;

  @JsonKey(name: 'organiser_user_id')
  String organiserUserId;

  @JsonKey(name: 'sport_id')
  String sportId;

  @JsonKey(name: 'area_of_game')
  String? areaOfGame;

  @JsonKey(name: 'game_date')
  DateTime? gameDate; // Date only

  @JsonKey(name: 'game_time')
  String? gameTime; // store as HH:mm:ss

  @JsonKey(name: 'game_access_type')
  String? gameAccessType; // Public, Invite Only

  @JsonKey(name: 'current_players_count')
  int? currentPlayersCount;

  @JsonKey(name: 'venue_name')
  String? venueName;

  @JsonKey(name: 'venue_id')
  String? venueId;

  @JsonKey(name: 'venue_address')
  String? venueAddress;

  @JsonKey(name: 'venue_latitude')
  double? venueLatitude;

  @JsonKey(name: 'venue_longitude')
  double? venueLongitude;

  @JsonKey(name: 'player_ids')
  List<String>? playerIds;

  @JsonKey(name: 'waitlist_user_ids')
  List<String>? waitlistUserIds;

  @JsonKey(name: 'game_rules')
  String? gameRules;

  @JsonKey(name: 'equipment_required')
  String? equipmentRequired;

  @JsonKey(name: 'equipment_provided')
  String? equipmentProvided;

  @JsonKey(name: 'requires_approval')
  bool requiresApproval;

  @JsonKey(name: 'contact_information')
  String? contactInformation;

  String? notes;

  @JsonKey(name: 'view_count')
  int viewCount;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  @JsonKey(name: 'venue_partner_id')
  String? venuePartnerId;

  Game({
    required this.gameId,
    required this.organiserUserId,
    required this.sportId,
    this.areaOfGame,
    this.gameDate,
    this.gameTime,
    this.gameAccessType,
    this.currentPlayersCount,
    this.venueName,
    this.venueId,
    this.venueAddress,
    this.venueLatitude,
    this.venueLongitude,
    this.playerIds,
    this.waitlistUserIds,
    this.gameRules,
    this.equipmentRequired,
    this.equipmentProvided,
    this.requiresApproval = false,
    this.contactInformation,
    this.notes,
    this.viewCount = 0,
    this.createdAt,
    this.updatedAt,
    this.venuePartnerId,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}

@JsonSerializable()
class GameInvite {
  @JsonKey(name: 'invite_id')
  String inviteId;

  @JsonKey(name: 'game_id')
  String gameId;

  @JsonKey(name: 'inviter_user_id')
  String inviterUserId;

  @JsonKey(name: 'invitee_user_id')
  String inviteeUserId;

  @JsonKey(name: 'invite_status')
  String? inviteStatus; // Pending, Accepted, Rejected, Expired

  @JsonKey(name: 'sent_at')
  DateTime? sentAt;

  @JsonKey(name: 'responded_at')
  DateTime? respondedAt;

  @JsonKey(name: 'expires_at')
  DateTime? expiresAt;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  GameInvite({
    required this.inviteId,
    required this.gameId,
    required this.inviterUserId,
    required this.inviteeUserId,
    this.inviteStatus,
    this.sentAt,
    this.respondedAt,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
  });

  factory GameInvite.fromJson(Map<String, dynamic> json) =>
      _$GameInviteFromJson(json);
  Map<String, dynamic> toJson() => _$GameInviteToJson(this);
}

@JsonSerializable()
class GameParticipation {
  @JsonKey(name: 'participation_id')
  String participationId;

  @JsonKey(name: 'game_id')
  String gameId;

  @JsonKey(name: 'user_id')
  String userId;

  @JsonKey(name: 'participation_status')
  String? participationStatus; // Joined, Waitlisted, Cancelled

  @JsonKey(name: 'joined_at')
  DateTime? joinedAt;

  @JsonKey(name: 'is_organiser')
  bool isOrganiser;

  @JsonKey(name: 'has_paid')
  bool hasPaid;

  @JsonKey(name: 'paid_at')
  DateTime? paidAt;

  @JsonKey(name: 'left_at')
  DateTime? leftAt;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  GameParticipation({
    required this.participationId,
    required this.gameId,
    required this.userId,
    this.participationStatus,
    this.joinedAt,
    this.isOrganiser = false,
    this.hasPaid = false,
    this.paidAt,
    this.leftAt,
    this.createdAt,
    this.updatedAt,
  });

  factory GameParticipation.fromJson(Map<String, dynamic> json) =>
      _$GameParticipationFromJson(json);
  Map<String, dynamic> toJson() => _$GameParticipationToJson(this);
}
