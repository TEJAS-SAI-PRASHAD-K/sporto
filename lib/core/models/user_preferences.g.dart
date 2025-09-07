// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preferences.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences(
      preferenceId: json['preference_id'] as String,
      userId: json['user_id'] as String,
      notificationsEnabled: json['notifications_enabled'] as bool? ?? true,
      gameInvitesEnabled: json['game_invites_enabled'] as bool? ?? true,
      appTheme: json['app_theme'] as String? ?? 'dark',
      promotionalEmailsEnabled:
          json['promotional_emails_enabled'] as bool? ?? true,
      locationSharingEnabled: json['location_sharing_enabled'] as bool? ?? true,
      preferredLanguage: json['preferred_language'] as String? ?? 'en',
      distanceUnit: json['distance_unit'] as String? ?? 'km',
      timeFormat: json['time_format'] as String? ?? '24h',
      searchRadiusKm: (json['search_radius_km'] as num?)?.toDouble(),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'preference_id': instance.preferenceId,
      'user_id': instance.userId,
      'notifications_enabled': instance.notificationsEnabled,
      'game_invites_enabled': instance.gameInvitesEnabled,
      'app_theme': instance.appTheme,
      'promotional_emails_enabled': instance.promotionalEmailsEnabled,
      'location_sharing_enabled': instance.locationSharingEnabled,
      'preferred_language': instance.preferredLanguage,
      'distance_unit': instance.distanceUnit,
      'time_format': instance.timeFormat,
      'search_radius_km': instance.searchRadiusKm,
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
