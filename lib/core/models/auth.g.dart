// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthSession _$AuthSessionFromJson(Map<String, dynamic> json) => _AuthSession(
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

Map<String, dynamic> _$AuthSessionToJson(_AuthSession instance) =>
    <String, dynamic>{
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

_OTPVerification _$OTPVerificationFromJson(Map<String, dynamic> json) =>
    _OTPVerification(
      id: json['id'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      otpCode: json['otpCode'] as String,
      type: $enumDecode(_$OTPTypeEnumMap, json['type']),
      isUsed: json['isUsed'] as bool? ?? false,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      attemptCount: (json['attemptCount'] as num?)?.toInt() ?? 0,
      maxAttempts: (json['maxAttempts'] as num?)?.toInt() ?? 5,
      verifiedAt: json['verifiedAt'] == null
          ? null
          : DateTime.parse(json['verifiedAt'] as String),
      deviceId: json['deviceId'] as String?,
      ipAddress: json['ipAddress'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$OTPVerificationToJson(_OTPVerification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'email': instance.email,
      'otpCode': instance.otpCode,
      'type': _$OTPTypeEnumMap[instance.type]!,
      'isUsed': instance.isUsed,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'attemptCount': instance.attemptCount,
      'maxAttempts': instance.maxAttempts,
      'verifiedAt': instance.verifiedAt?.toIso8601String(),
      'deviceId': instance.deviceId,
      'ipAddress': instance.ipAddress,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$OTPTypeEnumMap = {
  OTPType.unknown: 'unknown',
  OTPType.phoneVerification: 'phone_verification',
  OTPType.emailVerification: 'email_verification',
  OTPType.passwordReset: 'password_reset',
  OTPType.twoFactor: 'two_factor',
  OTPType.loginVerification: 'login_verification',
};

_SocialLoginData _$SocialLoginDataFromJson(Map<String, dynamic> json) =>
    _SocialLoginData(
      id: json['id'] as String,
      provider: json['provider'] as String,
      socialId: json['socialId'] as String,
      email: json['email'] as String?,
      name: json['name'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      tokenExpiresAt: json['tokenExpiresAt'] == null
          ? null
          : DateTime.parse(json['tokenExpiresAt'] as String),
      rawData: json['rawData'] as Map<String, dynamic>?,
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

Map<String, dynamic> _$SocialLoginDataToJson(_SocialLoginData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'provider': instance.provider,
      'socialId': instance.socialId,
      'email': instance.email,
      'name': instance.name,
      'profileImageUrl': instance.profileImageUrl,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'tokenExpiresAt': instance.tokenExpiresAt?.toIso8601String(),
      'rawData': instance.rawData,
      'isActive': instance.isActive,
      'lastUsedAt': instance.lastUsedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_PasswordResetToken _$PasswordResetTokenFromJson(Map<String, dynamic> json) =>
    _PasswordResetToken(
      id: json['id'] as String,
      userId: json['userId'] as String,
      token: json['token'] as String,
      isUsed: json['isUsed'] as bool? ?? false,
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      ipAddress: json['ipAddress'] as String?,
      userAgent: json['userAgent'] as String?,
      usedAt: json['usedAt'] == null
          ? null
          : DateTime.parse(json['usedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$PasswordResetTokenToJson(_PasswordResetToken instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'token': instance.token,
      'isUsed': instance.isUsed,
      'expiresAt': instance.expiresAt.toIso8601String(),
      'ipAddress': instance.ipAddress,
      'userAgent': instance.userAgent,
      'usedAt': instance.usedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };
