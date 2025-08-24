// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) =>
    User(
        localId: (json['localId'] as num?)?.toInt() ?? 0,
        id: json['id'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String?,
        fullName: json['fullName'] as String,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        profilePictureUrl: json['profilePictureUrl'] as String?,
        role:
            $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ??
            UserRole.player,
        authProvider:
            $enumDecodeNullable(_$AuthProviderEnumMap, json['authProvider']) ??
            AuthProvider.email,
        bio: json['bio'] as String?,
        dateOfBirth: json['dateOfBirth'] == null
            ? null
            : DateTime.parse(json['dateOfBirth'] as String),
        gender: json['gender'] as String?,
        city: json['city'] as String?,
        state: json['state'] as String?,
        country: json['country'] as String?,
        latitude: (json['latitude'] as num?)?.toDouble(),
        longitude: (json['longitude'] as num?)?.toDouble(),
        preferredSports:
            (json['preferredSports'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        subscriptionStatus:
            $enumDecodeNullable(
              _$SubscriptionStatusEnumMap,
              json['subscriptionStatus'],
            ) ??
            SubscriptionStatus.free,
        subscriptionExpiresAt: json['subscriptionExpiresAt'] == null
            ? null
            : DateTime.parse(json['subscriptionExpiresAt'] as String),
        isActive: json['isActive'] as bool? ?? true,
        isEmailVerified: json['isEmailVerified'] as bool? ?? false,
        isPhoneVerified: json['isPhoneVerified'] as bool? ?? false,
        isProfileCompleted: json['isProfileCompleted'] as bool? ?? false,
        fcmToken: json['fcmToken'] as String?,
        lastActiveAt: json['lastActiveAt'] == null
            ? null
            : DateTime.parse(json['lastActiveAt'] as String),
        isOnline: json['isOnline'] as bool? ?? false,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      )
      ..dbRole = (json['dbRole'] as num?)?.toInt()
      ..dbAuthProvider = (json['dbAuthProvider'] as num?)?.toInt()
      ..dbSubscriptionStatus = (json['dbSubscriptionStatus'] as num?)?.toInt();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'localId': instance.localId,
  'id': instance.id,
  'email': instance.email,
  'phone': instance.phone,
  'fullName': instance.fullName,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'profilePictureUrl': instance.profilePictureUrl,
  'role': _$UserRoleEnumMap[instance.role],
  'dbRole': instance.dbRole,
  'authProvider': _$AuthProviderEnumMap[instance.authProvider],
  'dbAuthProvider': instance.dbAuthProvider,
  'subscriptionStatus':
      _$SubscriptionStatusEnumMap[instance.subscriptionStatus],
  'dbSubscriptionStatus': instance.dbSubscriptionStatus,
  'bio': instance.bio,
  'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
  'gender': instance.gender,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'preferredSports': instance.preferredSports,
  'subscriptionExpiresAt': instance.subscriptionExpiresAt?.toIso8601String(),
  'isActive': instance.isActive,
  'isEmailVerified': instance.isEmailVerified,
  'isPhoneVerified': instance.isPhoneVerified,
  'isProfileCompleted': instance.isProfileCompleted,
  'fcmToken': instance.fcmToken,
  'lastActiveAt': instance.lastActiveAt?.toIso8601String(),
  'isOnline': instance.isOnline,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
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

UserPreferences _$UserPreferencesFromJson(Map<String, dynamic> json) =>
    UserPreferences(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      userId: json['userId'] as String,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      gameInvitesEnabled: json['gameInvitesEnabled'] as bool? ?? true,
      promotionalEmailsEnabled:
          json['promotionalEmailsEnabled'] as bool? ?? true,
      locationSharingEnabled: json['locationSharingEnabled'] as bool? ?? true,
      themeMode: json['themeMode'] as String? ?? 'system',
      language: json['language'] as String? ?? 'en',
      distanceUnit: json['distanceUnit'] as String? ?? 'km',
      timeFormat: json['timeFormat'] as String? ?? '24h',
      searchRadius: (json['searchRadius'] as num?)?.toDouble() ?? 10.0,
      defaultSkillLevel: json['defaultSkillLevel'] as String? ?? 'intermediate',
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserPreferencesToJson(UserPreferences instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'userId': instance.userId,
      'notificationsEnabled': instance.notificationsEnabled,
      'gameInvitesEnabled': instance.gameInvitesEnabled,
      'promotionalEmailsEnabled': instance.promotionalEmailsEnabled,
      'locationSharingEnabled': instance.locationSharingEnabled,
      'themeMode': instance.themeMode,
      'language': instance.language,
      'distanceUnit': instance.distanceUnit,
      'timeFormat': instance.timeFormat,
      'searchRadius': instance.searchRadius,
      'defaultSkillLevel': instance.defaultSkillLevel,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

UserSportProfile _$UserSportProfileFromJson(Map<String, dynamic> json) =>
    UserSportProfile(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      userId: json['userId'] as String,
      sportName: json['sportName'] as String,
      skillLevel: json['skillLevel'] as String,
      yearsOfExperience: (json['yearsOfExperience'] as num?)?.toInt(),
      position: json['position'] as String?,
      achievements: (json['achievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bio: json['bio'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      totalGamesPlayed: (json['totalGamesPlayed'] as num?)?.toInt(),
      totalWins: (json['totalWins'] as num?)?.toInt(),
      totalLosses: (json['totalLosses'] as num?)?.toInt(),
      preferredGameType: json['preferredGameType'] as String?,
      certifications: (json['certifications'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      equipmentOwned: json['equipmentOwned'] as String?,
      isPublic: json['isPublic'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserSportProfileToJson(UserSportProfile instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'userId': instance.userId,
      'sportName': instance.sportName,
      'skillLevel': instance.skillLevel,
      'yearsOfExperience': instance.yearsOfExperience,
      'position': instance.position,
      'achievements': instance.achievements,
      'bio': instance.bio,
      'rating': instance.rating,
      'totalGamesPlayed': instance.totalGamesPlayed,
      'totalWins': instance.totalWins,
      'totalLosses': instance.totalLosses,
      'preferredGameType': instance.preferredGameType,
      'certifications': instance.certifications,
      'equipmentOwned': instance.equipmentOwned,
      'isPublic': instance.isPublic,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

UserConnection _$UserConnectionFromJson(Map<String, dynamic> json) =>
    UserConnection(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      userId: json['userId'] as String,
      connectedUserId: json['connectedUserId'] as String,
      status:
          $enumDecodeNullable(_$ConnectionStatusEnumMap, json['status']) ??
          ConnectionStatus.pending,
      requestedAt: json['requestedAt'] == null
          ? null
          : DateTime.parse(json['requestedAt'] as String),
      acceptedAt: json['acceptedAt'] == null
          ? null
          : DateTime.parse(json['acceptedAt'] as String),
      blockedAt: json['blockedAt'] == null
          ? null
          : DateTime.parse(json['blockedAt'] as String),
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    )..dbStatus = (json['dbStatus'] as num?)?.toInt();

Map<String, dynamic> _$UserConnectionToJson(UserConnection instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'userId': instance.userId,
      'connectedUserId': instance.connectedUserId,
      'status': _$ConnectionStatusEnumMap[instance.status],
      'dbStatus': instance.dbStatus,
      'requestedAt': instance.requestedAt?.toIso8601String(),
      'acceptedAt': instance.acceptedAt?.toIso8601String(),
      'blockedAt': instance.blockedAt?.toIso8601String(),
      'notes': instance.notes,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$ConnectionStatusEnumMap = {
  ConnectionStatus.unknown: 'unknown',
  ConnectionStatus.pending: 'pending',
  ConnectionStatus.accepted: 'accepted',
  ConnectionStatus.blocked: 'blocked',
  ConnectionStatus.rejected: 'rejected',
};
