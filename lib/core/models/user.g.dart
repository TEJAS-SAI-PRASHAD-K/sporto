// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['id'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  fullName: json['full_name'] as String,
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  profilePictureUrl: json['profile_picture_url'] as String?,
  role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.player,
  authProvider:
      $enumDecodeNullable(_$AuthProviderEnumMap, json['auth_provider']) ??
      AuthProvider.email,
  subscriptionStatus:
      $enumDecodeNullable(
        _$SubscriptionStatusEnumMap,
        json['subscription_status'],
      ) ??
      SubscriptionStatus.free,
  bio: json['bio'] as String?,
  dateOfBirth: json['date_of_birth'] == null
      ? null
      : DateTime.parse(json['date_of_birth'] as String),
  gender: json['gender'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  preferredSports:
      (json['preferred_sports'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  subscriptionExpiresAt: json['subscription_expires_at'] == null
      ? null
      : DateTime.parse(json['subscription_expires_at'] as String),
  isActive: json['is_active'] as bool? ?? true,
  isEmailVerified: json['is_email_verified'] as bool? ?? false,
  isPhoneVerified: json['is_phone_verified'] as bool? ?? false,
  isProfileCompleted: json['is_profile_completed'] as bool? ?? false,
  fcmToken: json['fcm_token'] as String?,
  lastActiveAt: json['last_active_at'] == null
      ? null
      : DateTime.parse(json['last_active_at'] as String),
  isOnline: json['is_online'] as bool? ?? false,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'phone': instance.phone,
  'full_name': instance.fullName,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'profile_picture_url': instance.profilePictureUrl,
  'role': _$UserRoleEnumMap[instance.role],
  'auth_provider': _$AuthProviderEnumMap[instance.authProvider],
  'subscription_status':
      _$SubscriptionStatusEnumMap[instance.subscriptionStatus],
  'bio': instance.bio,
  'date_of_birth': instance.dateOfBirth?.toIso8601String(),
  'gender': instance.gender,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'preferred_sports': instance.preferredSports,
  'subscription_expires_at': instance.subscriptionExpiresAt?.toIso8601String(),
  'is_active': instance.isActive,
  'is_email_verified': instance.isEmailVerified,
  'is_phone_verified': instance.isPhoneVerified,
  'is_profile_completed': instance.isProfileCompleted,
  'fcm_token': instance.fcmToken,
  'last_active_at': instance.lastActiveAt?.toIso8601String(),
  'is_online': instance.isOnline,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

const _$UserRoleEnumMap = {
  UserRole.unknown: 'unknown',
  UserRole.player: 'player',
  UserRole.trainer: 'trainer',
  UserRole.admin: 'admin',
  UserRole.venueOwner: 'venue_owner',
};

const _$AuthProviderEnumMap = {
  AuthProvider.unknown: 'unknown',
  AuthProvider.email: 'email',
  AuthProvider.google: 'google',
  AuthProvider.apple: 'apple',
};

const _$SubscriptionStatusEnumMap = {
  SubscriptionStatus.unknown: 'unknown',
  SubscriptionStatus.free: 'free',
  SubscriptionStatus.premium: 'premium',
  SubscriptionStatus.pro: 'pro',
};

UserPreferences _$UserPreferencesFromJson(
  Map<String, dynamic> json,
) => UserPreferences(
  id: json['id'] as String,
  userId: json['user_id'] as String,
  notificationsEnabled: json['notifications_enabled'] as bool? ?? true,
  gameInvitesEnabled: json['game_invites_enabled'] as bool? ?? true,
  promotionalEmailsEnabled: json['promotional_emails_enabled'] as bool? ?? true,
  locationSharingEnabled: json['location_sharing_enabled'] as bool? ?? true,
  themeMode: json['theme_mode'] as String? ?? 'system',
  language: json['language'] as String? ?? 'en',
  distanceUnit: json['distance_unit'] as String? ?? 'km',
  timeFormat: json['time_format'] as String? ?? '24h',
  searchRadius: (json['search_radius'] as num?)?.toDouble() ?? 10.0,
  defaultSkillLevel: json['default_skill_level'] as String? ?? 'intermediate',
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'notifications_enabled': instance.notificationsEnabled,
      'game_invites_enabled': instance.gameInvitesEnabled,
      'promotional_emails_enabled': instance.promotionalEmailsEnabled,
      'location_sharing_enabled': instance.locationSharingEnabled,
      'theme_mode': instance.themeMode,
      'language': instance.language,
      'distance_unit': instance.distanceUnit,
      'time_format': instance.timeFormat,
      'search_radius': instance.searchRadius,
      'default_skill_level': instance.defaultSkillLevel,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

UserSportProfile _$UserSportProfileFromJson(Map<String, dynamic> json) =>
    UserSportProfile(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      sportName: json['sport_name'] as String,
      skillLevel: json['skill_level'] as String,
      yearsOfExperience: (json['years_of_experience'] as num?)?.toInt(),
      position: json['position'] as String?,
      achievements: (json['achievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bio: json['bio'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      totalGamesPlayed: (json['total_games_played'] as num?)?.toInt(),
      totalWins: (json['total_wins'] as num?)?.toInt(),
      totalLosses: (json['total_losses'] as num?)?.toInt(),
      preferredGameType: json['preferred_game_type'] as String?,
      certifications: (json['certifications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      equipmentOwned: json['equipment_owned'] as String?,
      isPublic: json['is_public'] as bool? ?? true,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserSportProfileToJson(UserSportProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'sport_name': instance.sportName,
      'skill_level': instance.skillLevel,
      'years_of_experience': instance.yearsOfExperience,
      'position': instance.position,
      'achievements': instance.achievements,
      'bio': instance.bio,
      'rating': instance.rating,
      'total_games_played': instance.totalGamesPlayed,
      'total_wins': instance.totalWins,
      'total_losses': instance.totalLosses,
      'preferred_game_type': instance.preferredGameType,
      'certifications': instance.certifications,
      'equipment_owned': instance.equipmentOwned,
      'is_public': instance.isPublic,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

UserConnection _$UserConnectionFromJson(Map<String, dynamic> json) =>
    UserConnection(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      connectedUserId: json['connected_user_id'] as String,
      status:
          $enumDecodeNullable(_$ConnectionStatusEnumMap, json['status']) ??
          ConnectionStatus.pending,
      requestedAt: json['requested_at'] == null
          ? null
          : DateTime.parse(json['requested_at'] as String),
      acceptedAt: json['accepted_at'] == null
          ? null
          : DateTime.parse(json['accepted_at'] as String),
      blockedAt: json['blocked_at'] == null
          ? null
          : DateTime.parse(json['blocked_at'] as String),
      notes: json['notes'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserConnectionToJson(UserConnection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'connected_user_id': instance.connectedUserId,
      'status': _$ConnectionStatusEnumMap[instance.status],
      'requested_at': instance.requestedAt?.toIso8601String(),
      'accepted_at': instance.acceptedAt?.toIso8601String(),
      'blocked_at': instance.blockedAt?.toIso8601String(),
      'notes': instance.notes,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.unknown: 'unknown',
  ConnectionStatus.pending: 'pending',
  ConnectionStatus.accepted: 'accepted',
  ConnectionStatus.blocked: 'blocked',
  ConnectionStatus.rejected: 'rejected',
};
