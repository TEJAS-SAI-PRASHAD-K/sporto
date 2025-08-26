import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User roles in the system
enum UserRole {
  @JsonValue('unknown')
  unknown,
  @JsonValue('player')
  player,
  @JsonValue('trainer')
  trainer,
  @JsonValue('admin')
  admin,
  @JsonValue('venue_owner')
  venueOwner,
}

/// Authentication provider types
enum AuthProvider {
  @JsonValue('unknown')
  unknown,
  @JsonValue('email')
  email,
  @JsonValue('google')
  google,
  @JsonValue('apple')
  apple,
}

/// User subscription status
enum SubscriptionStatus {
  @JsonValue('unknown')
  unknown,
  @JsonValue('free')
  free,
  @JsonValue('premium')
  premium,
  @JsonValue('pro')
  pro,
}

/// Main User model representing a user in the system
@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  String id; // Supabase UUID
  String email;
  String? phone;
  @JsonKey(name: 'full_name')
  String fullName;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'profile_picture_url')
  String? profilePictureUrl;

  // User role - stored as string
  UserRole? role;

  // Auth provider - stored as string
  @JsonKey(name: 'auth_provider')
  AuthProvider? authProvider;

  // Subscription status - stored as string
  @JsonKey(name: 'subscription_status')
  SubscriptionStatus? subscriptionStatus;

  String? bio;
  @JsonKey(name: 'date_of_birth')
  DateTime? dateOfBirth;
  String? gender;
  String? city;
  String? state;
  String? country;
  double? latitude;
  double? longitude;
  @JsonKey(name: 'preferred_sports')
  List<String> preferredSports;
  @JsonKey(name: 'subscription_expires_at')
  DateTime? subscriptionExpiresAt;
  @JsonKey(name: 'is_active')
  bool isActive;
  @JsonKey(name: 'is_email_verified')
  bool isEmailVerified;
  @JsonKey(name: 'is_phone_verified')
  bool isPhoneVerified;
  @JsonKey(name: 'is_profile_completed')
  bool isProfileCompleted;
  @JsonKey(name: 'fcm_token')
  String? fcmToken;
  @JsonKey(name: 'last_active_at')
  DateTime? lastActiveAt;
  @JsonKey(name: 'is_online')
  bool isOnline;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  User({
    required this.id,
    required this.email,
    this.phone,
    required this.fullName,
    this.firstName,
    this.lastName,
    this.profilePictureUrl,
    this.role = UserRole.player,
    this.authProvider = AuthProvider.email,
    this.subscriptionStatus = SubscriptionStatus.free,
    this.bio,
    this.dateOfBirth,
    this.gender,
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.preferredSports = const [],
    this.subscriptionExpiresAt,
    this.isActive = true,
    this.isEmailVerified = false,
    this.isPhoneVerified = false,
    this.isProfileCompleted = false,
    this.fcmToken,
    this.lastActiveAt,
    this.isOnline = false,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  factory User.fromDatabaseJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Creates a copy of this User with the given fields replaced with new values
  User copyWith({
    String? id,
    String? email,
    String? phone,
    String? fullName,
    String? firstName,
    String? lastName,
    String? profilePictureUrl,
    UserRole? role,
    AuthProvider? authProvider,
    String? bio,
    DateTime? dateOfBirth,
    String? gender,
    String? city,
    String? state,
    String? country,
    double? latitude,
    double? longitude,
    List<String>? preferredSports,
    SubscriptionStatus? subscriptionStatus,
    DateTime? subscriptionExpiresAt,
    bool? isActive,
    bool? isEmailVerified,
    bool? isPhoneVerified,
    bool? isProfileCompleted,
    String? fcmToken,
    DateTime? lastActiveAt,
    bool? isOnline,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      role: role ?? this.role,
      authProvider: authProvider ?? this.authProvider,
      bio: bio ?? this.bio,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      preferredSports: preferredSports ?? this.preferredSports,
      subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
      subscriptionExpiresAt:
          subscriptionExpiresAt ?? this.subscriptionExpiresAt,
      isActive: isActive ?? this.isActive,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
      fcmToken: fcmToken ?? this.fcmToken,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
      isOnline: isOnline ?? this.isOnline,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// User preferences for app settings
@JsonSerializable()
class UserPreferences {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'notifications_enabled')
  bool notificationsEnabled;
  @JsonKey(name: 'game_invites_enabled')
  bool gameInvitesEnabled;
  @JsonKey(name: 'promotional_emails_enabled')
  bool promotionalEmailsEnabled;
  @JsonKey(name: 'location_sharing_enabled')
  bool locationSharingEnabled;
  @JsonKey(name: 'theme_mode')
  String themeMode; // light, dark, system
  String language;
  @JsonKey(name: 'distance_unit')
  String distanceUnit; // km, miles
  @JsonKey(name: 'time_format')
  String timeFormat; // 12h, 24h
  @JsonKey(name: 'search_radius')
  double searchRadius; // in km
  @JsonKey(name: 'default_skill_level')
  String defaultSkillLevel;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  UserPreferences({
    required this.id,
    required this.userId,
    this.notificationsEnabled = true,
    this.gameInvitesEnabled = true,
    this.promotionalEmailsEnabled = true,
    this.locationSharingEnabled = true,
    this.themeMode = 'system',
    this.language = 'en',
    this.distanceUnit = 'km',
    this.timeFormat = '24h',
    this.searchRadius = 10.0,
    this.defaultSkillLevel = 'intermediate',
    this.createdAt,
    this.updatedAt,
  });

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);
  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);
}

/// User sports profiles for different sports
@JsonSerializable()
class UserSportProfile {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'sport_name')
  String sportName;
  @JsonKey(name: 'skill_level')
  String skillLevel; // beginner, amateur, intermediate, advanced, professional
  @JsonKey(name: 'years_of_experience')
  int? yearsOfExperience;
  String? position; // for team sports
  List<String>? achievements;
  String? bio;
  double? rating;
  @JsonKey(name: 'total_games_played')
  int? totalGamesPlayed;
  @JsonKey(name: 'total_wins')
  int? totalWins;
  @JsonKey(name: 'total_losses')
  int? totalLosses;
  @JsonKey(name: 'preferred_game_type')
  String? preferredGameType; // singles, doubles, team
  List<String>? certifications;
  @JsonKey(name: 'equipment_owned')
  String? equipmentOwned;
  @JsonKey(name: 'is_public')
  bool isPublic;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  UserSportProfile({
    required this.id,
    required this.userId,
    required this.sportName,
    required this.skillLevel,
    this.yearsOfExperience,
    this.position,
    this.achievements,
    this.bio,
    this.rating,
    this.totalGamesPlayed,
    this.totalWins,
    this.totalLosses,
    this.preferredGameType,
    this.certifications,
    this.equipmentOwned,
    this.isPublic = true,
    this.createdAt,
    this.updatedAt,
  });

  factory UserSportProfile.fromJson(Map<String, dynamic> json) =>
      _$UserSportProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserSportProfileToJson(this);
}

/// User connections/friendships
@JsonSerializable()
class UserConnection {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'connected_user_id')
  String connectedUserId;
  ConnectionStatus? status;
  @JsonKey(name: 'requested_at')
  DateTime? requestedAt;
  @JsonKey(name: 'accepted_at')
  DateTime? acceptedAt;
  @JsonKey(name: 'blocked_at')
  DateTime? blockedAt;
  String? notes;
  @JsonKey(name: 'created_at')
  DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  UserConnection({
    required this.id,
    required this.userId,
    required this.connectedUserId,
    this.status = ConnectionStatus.pending,
    this.requestedAt,
    this.acceptedAt,
    this.blockedAt,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory UserConnection.fromJson(Map<String, dynamic> json) =>
      _$UserConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$UserConnectionToJson(this);
}

enum ConnectionStatus {
  @JsonValue('unknown')
  unknown,
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('blocked')
  blocked,
  @JsonValue('rejected')
  rejected,
}
