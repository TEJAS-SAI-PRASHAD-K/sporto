import 'package:json_annotation/json_annotation.dart';

part 'user_preferences.g.dart';

@JsonSerializable()
class UserPreferences {
  @JsonKey(name: 'preference_id')
  String preferenceId;

  @JsonKey(name: 'user_id')
  String userId;

  @JsonKey(name: 'notifications_enabled')
  bool notificationsEnabled;

  @JsonKey(name: 'game_invites_enabled')
  bool gameInvitesEnabled;

  @JsonKey(name: 'app_theme')
  String appTheme; // dark, light

  @JsonKey(name: 'promotional_emails_enabled')
  bool promotionalEmailsEnabled;

  @JsonKey(name: 'location_sharing_enabled')
  bool locationSharingEnabled;

  @JsonKey(name: 'preferred_language')
  String preferredLanguage;

  @JsonKey(name: 'distance_unit')
  String distanceUnit; // km / mi

  @JsonKey(name: 'time_format')
  String timeFormat; // 24h / 12h

  @JsonKey(name: 'search_radius_km')
  double? searchRadiusKm;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  UserPreferences({
    required this.preferenceId,
    required this.userId,
    this.notificationsEnabled = true,
    this.gameInvitesEnabled = true,
    this.appTheme = 'dark',
    this.promotionalEmailsEnabled = true,
    this.locationSharingEnabled = true,
    this.preferredLanguage = 'en',
    this.distanceUnit = 'km',
    this.timeFormat = '24h',
    this.searchRadiusKm,
    this.updatedAt,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);
}
