// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

/// User roles in the system (matches DB values)
enum UserRole {
  @JsonValue('user')
  user,
  @JsonValue('trainer')
  trainer,
  @JsonValue('admin')
  admin,
  @JsonValue('venue_partner')
  venuePartner,
}

/// Supabase users table model
@freezed
abstract class User with _$User {
  const factory User({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'email_address') required String emailAddress,
    @JsonKey(name: 'mobile_number') String? mobileNumber,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'location_area') String? locationArea,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'favorite_sports') List<String>? favoriteSports,
    @Default(0) @JsonKey(name: 'karma_score') int karmaScore,
    @Default(0) @JsonKey(name: 'games_played_count') int gamesPlayedCount,
    @JsonKey(name: 'playpals_user_ids') List<String>? playpalsUserIds,
    String? gender,
    String? bio,
    @JsonKey(name: 'booked_sessions_ids') List<String>? bookedSessionsIds,
    @JsonKey(name: 'blocked_user_ids') List<String>? blockedUserIds,
    String? city,
    String? state,
    String? country,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @Default(false) @JsonKey(name: 'is_email_verified') bool isEmailVerified,
    @Default(false) @JsonKey(name: 'is_mobile_verified') bool isMobileVerified,
    @Default(UserRole.user) @JsonKey(name: 'user_role') UserRole userRole,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
