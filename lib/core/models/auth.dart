import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'auth.g.dart';

/// Authentication session data
@Entity()
@JsonSerializable()
class AuthSession {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId;
  String accessToken;
  String? refreshToken;
  @Property(type: PropertyType.date)
  DateTime expiresAt;
  String? deviceId;
  String? deviceName;
  String? ipAddress;
  String? userAgent;
  bool isActive;
  @Property(type: PropertyType.date)
  DateTime? lastUsedAt;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  AuthSession({
    this.localId = 0,
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
@Entity()
@JsonSerializable()
class OTPVerification {
  @Id()
  int localId;

  @Unique()
  String id;
  String identifier; // email or phone
  String code;

  // Store enums as int for ObjectBox compatibility
  int _type;
  int _purpose;

  // Getters and setters for enum properties
  OTPType get type => OTPType.values[_type];
  set type(OTPType value) => _type = value.index;

  OTPPurpose get purpose => OTPPurpose.values[_purpose];
  set purpose(OTPPurpose value) => _purpose = value.index;

  bool isVerified;
  bool isUsed;
  @Property(type: PropertyType.date)
  DateTime expiresAt;
  int? attempts;
  int maxAttempts;
  @Property(type: PropertyType.date)
  DateTime? verifiedAt;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  OTPVerification({
    this.localId = 0,
    required this.id,
    required this.identifier,
    required this.code,
    OTPType type = OTPType.sms,
    OTPPurpose purpose = OTPPurpose.registration,
    this.isVerified = false,
    this.isUsed = false,
    required this.expiresAt,
    this.attempts,
    this.maxAttempts = 3,
    this.verifiedAt,
    this.createdAt,
    this.updatedAt,
  }) : _type = type.index,
       _purpose = purpose.index;

  factory OTPVerification.fromJson(Map<String, dynamic> json) =>
      _$OTPVerificationFromJson(json);
  Map<String, dynamic> toJson() => _$OTPVerificationToJson(this);
}

enum OTPType {
  @JsonValue('email')
  email,
  @JsonValue('sms')
  sms,
}

enum OTPPurpose {
  @JsonValue('registration')
  registration,
  @JsonValue('login')
  login,
  @JsonValue('password_reset')
  passwordReset,
  @JsonValue('email_verification')
  emailVerification,
  @JsonValue('phone_verification')
  phoneVerification,
}

/// Social auth profile data
@Entity()
@JsonSerializable()
class SocialAuthProfile {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId;
  String provider; // google, apple, facebook
  String providerId;
  String? email;
  String? name;
  String? pictureUrl;
  @Property(type: PropertyType.date)
  DateTime? connectedAt;
  @Property(type: PropertyType.date)
  DateTime? lastSyncAt;
  bool isActive;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  SocialAuthProfile({
    this.localId = 0,
    required this.id,
    required this.userId,
    required this.provider,
    required this.providerId,
    this.email,
    this.name,
    this.pictureUrl,
    this.connectedAt,
    this.lastSyncAt,
    this.isActive = true,
    this.createdAt,
    this.updatedAt,
  });

  factory SocialAuthProfile.fromJson(Map<String, dynamic> json) =>
      _$SocialAuthProfileFromJson(json);
  Map<String, dynamic> toJson() => _$SocialAuthProfileToJson(this);
}

/// Device info for security tracking
@Entity()
@JsonSerializable()
class DeviceInfo {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId;
  String deviceId;
  String? deviceName;
  String? platform; // iOS, Android
  String? osVersion;
  String? appVersion;
  String? fcmToken;
  bool isActive;
  @Property(type: PropertyType.date)
  DateTime? lastSeenAt;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  DeviceInfo({
    this.localId = 0,
    required this.id,
    required this.userId,
    required this.deviceId,
    this.deviceName,
    this.platform,
    this.osVersion,
    this.appVersion,
    this.fcmToken,
    this.isActive = true,
    this.lastSeenAt,
    this.createdAt,
    this.updatedAt,
  });

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
}
