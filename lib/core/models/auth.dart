import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

/// Authentication session data
@JsonSerializable()
class AuthSession {
  String id;
  String userId;
  String accessToken;
  String? refreshToken;
  DateTime expiresAt;
  String? deviceId;
  String? deviceName;
  String? ipAddress;
  String? userAgent;
  bool isActive;
  DateTime? lastUsedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  AuthSession({
    required this.id,
    required this.userId,
    required this.accessToken,
    this.refreshToken,
    required this.expiresAt,
    this.deviceId,
    this.deviceName,
    this.ipAddress,
    this.userAgent,
    this.isActive = true,
    this.lastUsedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
  Map<String, dynamic> toJson() => _$AuthSessionToJson(this);
}

/// OTP verification data
@JsonSerializable()
class OTPVerification {
  String id;
  String? phone;
  String? email;
  String otpCode;
  OTPType type;
  bool isUsed;
  DateTime expiresAt;
  int attemptCount;
  int maxAttempts;
  DateTime? verifiedAt;
  String? deviceId;
  String? ipAddress;
  DateTime? createdAt;

  OTPVerification({
    required this.id,
    this.phone,
    this.email,
    required this.otpCode,
    required this.type,
    this.isUsed = false,
    required this.expiresAt,
    this.attemptCount = 0,
    this.maxAttempts = 5,
    this.verifiedAt,
    this.deviceId,
    this.ipAddress,
    this.createdAt,
  });

  factory OTPVerification.fromJson(Map<String, dynamic> json) =>
      _$OTPVerificationFromJson(json);
  Map<String, dynamic> toJson() => _$OTPVerificationToJson(this);
}

enum OTPType {
  @JsonValue('unknown')
  unknown,
  @JsonValue('phone_verification')
  phoneVerification,
  @JsonValue('email_verification')
  emailVerification,
  @JsonValue('password_reset')
  passwordReset,
  @JsonValue('two_factor')
  twoFactor,
  @JsonValue('login_verification')
  loginVerification,
}

/// Social login data
@JsonSerializable()
class SocialLoginData {
  String id;
  String provider; // google, facebook, apple, etc.
  String socialId; // ID from the social provider
  String? email;
  String? name;
  String? profileImageUrl;
  String? accessToken;
  String? refreshToken;
  DateTime? tokenExpiresAt;
  Map<String, dynamic>? rawData; // store full response
  bool isActive;
  DateTime? lastUsedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  SocialLoginData({
    required this.id,
    required this.provider,
    required this.socialId,
    this.email,
    this.name,
    this.profileImageUrl,
    this.accessToken,
    this.refreshToken,
    this.tokenExpiresAt,
    this.rawData,
    this.isActive = true,
    this.lastUsedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory SocialLoginData.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginDataFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLoginDataToJson(this);
}

/// Password reset tokens
@JsonSerializable()
class PasswordResetToken {
  String id;
  String userId;
  String token;
  bool isUsed;
  DateTime expiresAt;
  String? ipAddress;
  String? userAgent;
  DateTime? usedAt;
  DateTime? createdAt;

  PasswordResetToken({
    required this.id,
    required this.userId,
    required this.token,
    this.isUsed = false,
    required this.expiresAt,
    this.ipAddress,
    this.userAgent,
    this.usedAt,
    this.createdAt,
  });

  factory PasswordResetToken.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetTokenFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordResetTokenToJson(this);
}
