// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_User _$UserFromJson(Map<String, dynamic> json) => _User(
  userId: json['user_id'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String?,
  emailAddress: json['email_address'] as String,
  mobileNumber: json['mobile_number'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  locationArea: json['location_area'] as String?,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  favoriteSports: (json['favorite_sports'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  karmaScore: (json['karma_score'] as num?)?.toInt() ?? 0,
  gamesPlayedCount: (json['games_played_count'] as num?)?.toInt() ?? 0,
  playpalsUserIds: (json['playpals_user_ids'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  gender: json['gender'] as String?,
  bio: json['bio'] as String?,
  bookedSessionsIds: (json['booked_sessions_ids'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  blockedUserIds: (json['blocked_user_ids'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  isEmailVerified: json['is_email_verified'] as bool? ?? false,
  isMobileVerified: json['is_mobile_verified'] as bool? ?? false,
  userRole:
      $enumDecodeNullable(_$UserRoleEnumMap, json['user_role']) ??
      UserRole.user,
);

Map<String, dynamic> _$UserToJson(_User instance) => <String, dynamic>{
  'user_id': instance.userId,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'email_address': instance.emailAddress,
  'mobile_number': instance.mobileNumber,
  'avatar_url': instance.avatarUrl,
  'location_area': instance.locationArea,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'favorite_sports': instance.favoriteSports,
  'karma_score': instance.karmaScore,
  'games_played_count': instance.gamesPlayedCount,
  'playpals_user_ids': instance.playpalsUserIds,
  'gender': instance.gender,
  'bio': instance.bio,
  'booked_sessions_ids': instance.bookedSessionsIds,
  'blocked_user_ids': instance.blockedUserIds,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'is_email_verified': instance.isEmailVerified,
  'is_mobile_verified': instance.isMobileVerified,
  'user_role': _$UserRoleEnumMap[instance.userRole]!,
};

const _$UserRoleEnumMap = {
  UserRole.user: 'user',
  UserRole.trainer: 'trainer',
  UserRole.admin: 'admin',
  UserRole.venuePartner: 'venue_partner',
};
