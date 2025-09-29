// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

@freezed
abstract class Game with _$Game {
  const factory Game({
    @JsonKey(name: 'game_id') required String gameId,
    @JsonKey(name: 'organiser_user_id') required String organiserUserId,
    @JsonKey(name: 'sport_id') required String sportId,
    @JsonKey(name: 'area_of_game') String? areaOfGame,
    @JsonKey(name: 'game_date') DateTime? gameDate,
    @JsonKey(name: 'game_time') String? gameTime, // HH:mm:ss
    @JsonKey(name: 'game_access_type') String? gameAccessType,
    @JsonKey(name: 'current_players_count') int? currentPlayersCount,
    @JsonKey(name: 'venue_name') String? venueName,
    @JsonKey(name: 'venue_id') String? venueId,
    @JsonKey(name: 'venue_address') String? venueAddress,
    @JsonKey(name: 'venue_latitude') double? venueLatitude,
    @JsonKey(name: 'venue_longitude') double? venueLongitude,
    @JsonKey(name: 'player_ids') List<String>? playerIds,
    @JsonKey(name: 'waitlist_user_ids') List<String>? waitlistUserIds,
    @JsonKey(name: 'game_rules') String? gameRules,
    @JsonKey(name: 'equipment_required') String? equipmentRequired,
    @JsonKey(name: 'equipment_provided') String? equipmentProvided,
    @Default(false) @JsonKey(name: 'requires_approval') bool requiresApproval,
    @JsonKey(name: 'contact_information') String? contactInformation,
    String? notes,
    @Default(0) @JsonKey(name: 'view_count') int viewCount,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'venue_partner_id') String? venuePartnerId,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
}

@freezed
abstract class GameInvite with _$GameInvite {
  const factory GameInvite({
    @JsonKey(name: 'invite_id') required String inviteId,
    @JsonKey(name: 'game_id') required String gameId,
    @JsonKey(name: 'inviter_user_id') required String inviterUserId,
    @JsonKey(name: 'invitee_user_id') required String inviteeUserId,
    @JsonKey(name: 'invite_status')
    String? inviteStatus, // Pending, Accepted, Rejected, Expired
    @JsonKey(name: 'sent_at') DateTime? sentAt,
    @JsonKey(name: 'responded_at') DateTime? respondedAt,
    @JsonKey(name: 'expires_at') DateTime? expiresAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _GameInvite;

  factory GameInvite.fromJson(Map<String, dynamic> json) =>
      _$GameInviteFromJson(json);
}

@freezed
abstract class GameParticipation with _$GameParticipation {
  const factory GameParticipation({
    @JsonKey(name: 'participation_id') required String participationId,
    @JsonKey(name: 'game_id') required String gameId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'participation_status')
    String? participationStatus, // Joined, Waitlisted, Cancelled
    @JsonKey(name: 'joined_at') DateTime? joinedAt,
    @Default(false) @JsonKey(name: 'is_organiser') bool isOrganiser,
    @Default(false) @JsonKey(name: 'has_paid') bool hasPaid,
    @JsonKey(name: 'paid_at') DateTime? paidAt,
    @JsonKey(name: 'left_at') DateTime? leftAt,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _GameParticipation;

  factory GameParticipation.fromJson(Map<String, dynamic> json) =>
      _$GameParticipationFromJson(json);
}
