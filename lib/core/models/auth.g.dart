// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) => AuthSession(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  userId: json['userId'] as String,
  accessToken: json['accessToken'] as String,
  refreshToken: json['refreshToken'] as String?,
  expiresAt: DateTime.parse(json['expiresAt'] as String),
  deviceId: json['deviceId'] as String?,
  deviceName: json['deviceName'] as String?,
  ipAddress: json['ipAddress'] as String?,
  userAgent: json['userAgent'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  lastUsedAt: json['lastUsedAt'] == null
      ? null
      : DateTime.parse(json['lastUsedAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$AuthSessionToJson(AuthSession instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'userId': instance.userId,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
      'ipAddress': instance.ipAddress,
      'userAgent': instance.userAgent,
      'isActive': instance.isActive,
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

OTPVerification _$OTPVerificationFromJson(Map<String, dynamic> json) =>
    OTPVerification(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      identifier: json['identifier'] as String,
      code: json['code'] as String,
      type: $enumDecodeNullable(_$OTPTypeEnumMap, json['type']) ?? OTPType.sms,
      purpose:
          $enumDecodeNullable(_$OTPPurposeEnumMap, json['purpose']) ??
          OTPPurpose.registration,
      isVerified: json['isVerified'] as bool? ?? false,
      isUsed: json['isUsed'] as bool? ?? false,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      attempts: (json['attempts'] as num?)?.toInt(),
      maxAttempts: (json['maxAttempts'] as num?)?.toInt() ?? 3,
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$OTPVerificationToJson(OTPVerification instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'identifier': instance.identifier,
      'code': instance.code,
      'type': _$OTPTypeEnumMap[instance.type]!,
      'purpose': _$OTPPurposeEnumMap[instance.purpose]!,
      'isVerified': instance.isVerified,
      'isUsed': instance.isUsed,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'attempts': instance.attempts,
      'maxAttempts': instance.maxAttempts,
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$OTPTypeEnumMap = {OTPType.email: 'email', OTPType.sms: 'sms'};

const _$OTPPurposeEnumMap = {
  OTPPurpose.registration: 'registration',
  OTPPurpose.login: 'login',
  OTPPurpose.passwordReset: 'password_reset',
  OTPPurpose.emailVerification: 'email_verification',
  OTPPurpose.phoneVerification: 'phone_verification',
};

SocialAuthProfile _$SocialAuthProfileFromJson(Map<String, dynamic> json) =>
    SocialAuthProfile(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      userId: json['userId'] as String,
      provider: json['provider'] as String,
      providerId: json['providerId'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      pictureUrl: json['pictureUrl'] as String?,
      connectedAt: json['connectedAt'] == null
          ? null
          : DateTime.parse(json['connectedAt'] as String),
      lastSyncAt: json['lastSyncAt'] == null
          ? null
          : DateTime.parse(json['lastSyncAt'] as String),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SocialAuthProfileToJson(SocialAuthProfile instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'userId': instance.userId,
      'provider': instance.provider,
      'providerId': instance.providerId,
      'email': instance.email,
      'name': instance.name,
      'pictureUrl': instance.pictureUrl,
      'connectedAt': instance.connectedAt?.toIso8601String(),
      'lastSyncAt': instance.lastSyncAt?.toIso8601String(),
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  userId: json['userId'] as String,
  deviceId: json['deviceId'] as String,
  deviceName: json['deviceName'] as String?,
  platform: json['platform'] as String?,
  osVersion: json['osVersion'] as String?,
  appVersion: json['appVersion'] as String?,
  fcmToken: json['fcmToken'] as String?,
  isActive: json['isActive'] as bool? ?? true,
  lastSeenAt: json['lastSeenAt'] == null
      ? null
      : DateTime.parse(json['lastSeenAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'userId': instance.userId,
      'deviceId': instance.deviceId,
      'deviceName': instance.deviceName,
      'platform': instance.platform,
      'osVersion': instance.osVersion,
      'appVersion': instance.appVersion,
      'fcmToken': instance.fcmToken,
      'isActive': instance.isActive,
      'lastSeenAt': instance.lastSeenAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
