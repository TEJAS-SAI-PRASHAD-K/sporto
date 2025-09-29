import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.freezed.dart';
part 'auth.g.dart';

/// Authentication session data
@freezed
abstract class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String id,
    required String userId,
    required String accessToken,
    String? refreshToken,
    required DateTime expiresAt,
    String? deviceId,
    String? deviceName,
    String? ipAddress,
    String? userAgent,
    @Default(true) bool isActive,
    DateTime? lastUsedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AuthSession;

  factory AuthSession.fromJson(Map<String, dynamic> json) =>
      _$AuthSessionFromJson(json);
}

/// OTP verification data
@freezed
abstract class OTPVerification with _$OTPVerification {
  const factory OTPVerification({
    required String id,
    String? phone,
    String? email,
    required String otpCode,
    required OTPType type,
    @Default(false) bool isUsed,
    required DateTime expiresAt,
    @Default(0) int attemptCount,
    @Default(5) int maxAttempts,
    DateTime? verifiedAt,
    String? deviceId,
    String? ipAddress,
    DateTime? createdAt,
  }) = _OTPVerification;

  factory OTPVerification.fromJson(Map<String, dynamic> json) =>
      _$OTPVerificationFromJson(json);
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
@freezed
abstract class SocialLoginData with _$SocialLoginData {
  const factory SocialLoginData({
    required String id,
    required String provider, // google, facebook, apple, etc.
    required String socialId, // ID from the social provider
    String? email,
    String? name,
    String? profileImageUrl,
    String? accessToken,
    String? refreshToken,
    DateTime? tokenExpiresAt,
    Map<String, dynamic>? rawData, // store full response
    @Default(true) bool isActive,
    DateTime? lastUsedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SocialLoginData;

  factory SocialLoginData.fromJson(Map<String, dynamic> json) =>
      _$SocialLoginDataFromJson(json);
}

/// Password reset tokens
@freezed
abstract class PasswordResetToken with _$PasswordResetToken {
  const factory PasswordResetToken({
    required String id,
    required String userId,
    required String token,
    @Default(false) bool isUsed,
    required DateTime expiresAt,
    String? ipAddress,
    String? userAgent,
    DateTime? usedAt,
    DateTime? createdAt,
  }) = _PasswordResetToken;

  factory PasswordResetToken.fromJson(Map<String, dynamic> json) =>
      _$PasswordResetTokenFromJson(json);
}
