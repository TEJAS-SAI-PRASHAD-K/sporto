// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_preferences.freezed.dart';
part 'user_preferences.g.dart';

@freezed
abstract class UserPreferences with _$UserPreferences {
  const factory UserPreferences({
    @JsonKey(name: 'preference_id') required String preferenceId,
    @JsonKey(name: 'user_id') required String userId,
    @Default(true)
    @JsonKey(name: 'notifications_enabled')
    bool notificationsEnabled,
    @Default(true)
    @JsonKey(name: 'game_invites_enabled')
    bool gameInvitesEnabled,
    @Default('dark') @JsonKey(name: 'app_theme') String appTheme,
    @Default(true)
    @JsonKey(name: 'promotional_emails_enabled')
    bool promotionalEmailsEnabled,
    @Default(true)
    @JsonKey(name: 'location_sharing_enabled')
    bool locationSharingEnabled,
    @Default('en')
    @JsonKey(name: 'preferred_language')
    String preferredLanguage,
    @Default('km') @JsonKey(name: 'distance_unit') String distanceUnit,
    @Default('24h') @JsonKey(name: 'time_format') String timeFormat,
    @JsonKey(name: 'search_radius_km') double? searchRadiusKm,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _UserPreferences;

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
}
