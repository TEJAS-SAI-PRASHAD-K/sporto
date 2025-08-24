import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'user.g.dart';

/// User roles in the system
enum UserRole {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('player')
  player,
  @JsonValue('trainer')
  trainer,
  @JsonValue('admin')
  admin,
  @JsonValue('venue_owner')
  venueOwner;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case UserRole.unknown:
        return 0;
      case UserRole.player:
        return 1;
      case UserRole.trainer:
        return 2;
      case UserRole.admin:
        return 3;
      case UserRole.venueOwner:
        return 4;
    }
  }

  static UserRole fromStableId(int id) {
    switch (id) {
      case 0:
        return UserRole.unknown;
      case 1:
        return UserRole.player;
      case 2:
        return UserRole.trainer;
      case 3:
        return UserRole.admin;
      case 4:
        return UserRole.venueOwner;
      default:
        return UserRole.unknown;
    }
  }
}

/// Authentication provider types
enum AuthProvider {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('email')
  email,
  @JsonValue('google')
  google,
  @JsonValue('apple')
  apple;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case AuthProvider.unknown:
        return 0;
      case AuthProvider.email:
        return 1;
      case AuthProvider.google:
        return 2;
      case AuthProvider.apple:
        return 3;
    }
  }

  static AuthProvider fromStableId(int id) {
    switch (id) {
      case 0:
        return AuthProvider.unknown;
      case 1:
        return AuthProvider.email;
      case 2:
        return AuthProvider.google;
      case 3:
        return AuthProvider.apple;
      default:
        return AuthProvider.unknown;
    }
  }
}

/// User subscription status
enum SubscriptionStatus {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('free')
  free,
  @JsonValue('premium')
  premium,
  @JsonValue('pro')
  pro;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case SubscriptionStatus.unknown:
        return 0;
      case SubscriptionStatus.free:
        return 1;
      case SubscriptionStatus.premium:
        return 2;
      case SubscriptionStatus.pro:
        return 3;
    }
  }

  static SubscriptionStatus fromStableId(int id) {
    switch (id) {
      case 0:
        return SubscriptionStatus.unknown;
      case 1:
        return SubscriptionStatus.free;
      case 2:
        return SubscriptionStatus.premium;
      case 3:
        return SubscriptionStatus.pro;
      default:
        return SubscriptionStatus.unknown;
    }
  }
}

/// Main User model representing a user in the system
@Entity()
@JsonSerializable()
class User {
  @Id()
  int localId;

  @Unique()
  String id; // Supabase UUID
  String email;
  String? phone;
  String fullName;
  String? firstName;
  String? lastName;
  String? profilePictureUrl;

  // User role - using ObjectBox recommended enum pattern
  @Transient()
  UserRole? role;

  int? get dbRole {
    return role?.stableId;
  }

  set dbRole(int? value) {
    if (value == null) {
      role = null;
    } else {
      role = UserRole.fromStableId(value);
    }
  }

  // Auth provider - using ObjectBox recommended enum pattern
  @Transient()
  AuthProvider? authProvider;

  int? get dbAuthProvider {
    return authProvider?.stableId;
  }

  set dbAuthProvider(int? value) {
    if (value == null) {
      authProvider = null;
    } else {
      authProvider = AuthProvider.fromStableId(value);
    }
  }

  // Subscription status - using ObjectBox recommended enum pattern
  @Transient()
  SubscriptionStatus? subscriptionStatus;

  int? get dbSubscriptionStatus {
    return subscriptionStatus?.stableId;
  }

  set dbSubscriptionStatus(int? value) {
    if (value == null) {
      subscriptionStatus = null;
    } else {
      subscriptionStatus = SubscriptionStatus.fromStableId(value);
    }
  }

  String? bio;
  @Property(type: PropertyType.date)
  DateTime? dateOfBirth;
  String? gender;
  String? city;
  String? state;
  String? country;
  double? latitude;
  double? longitude;
  List<String> preferredSports;
  @Property(type: PropertyType.date)
  DateTime? subscriptionExpiresAt;
  bool isActive;
  bool isEmailVerified;
  bool isPhoneVerified;
  bool isProfileCompleted;
  String? fcmToken;
  @Property(type: PropertyType.date)
  DateTime? lastActiveAt;
  bool isOnline;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  User({
    this.localId = 0,
    required this.id,
    required this.email,
    this.phone,
    required this.fullName,
    this.firstName,
    this.lastName,
    this.profilePictureUrl,
    UserRole role = UserRole.player,
    AuthProvider authProvider = AuthProvider.email,
    this.bio,
    this.dateOfBirth,
    this.gender,
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.preferredSports = const [],
    SubscriptionStatus subscriptionStatus = SubscriptionStatus.free,
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
  }) {
    this.role = role;
    this.authProvider = authProvider;
    this.subscriptionStatus = subscriptionStatus;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

/// User preferences for app settings
@Entity()
@JsonSerializable()
class UserPreferences {
  @Id()
  int localId;

  @Unique()
  String userId;
  bool notificationsEnabled;
  bool gameInvitesEnabled;
  bool promotionalEmailsEnabled;
  bool locationSharingEnabled;
  String themeMode; // light, dark, system
  String language;
  String distanceUnit; // km, miles
  String timeFormat; // 12h, 24h
  double searchRadius; // in km
  String defaultSkillLevel;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  UserPreferences({
    this.localId = 0,
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
@Entity()
@JsonSerializable()
class UserSportProfile {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId;
  String sportName;
  String skillLevel; // beginner, amateur, intermediate, advanced, professional
  int? yearsOfExperience;
  String? position; // for team sports
  List<String>? achievements;
  String? bio;
  double? rating;
  int? totalGamesPlayed;
  int? totalWins;
  int? totalLosses;
  String? preferredGameType; // singles, doubles, team
  List<String>? certifications;
  String? equipmentOwned;
  bool isPublic;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  UserSportProfile({
    this.localId = 0,
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
@Entity()
@JsonSerializable()
class UserConnection {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId;
  String connectedUserId;

  // Connection status - using ObjectBox recommended enum pattern
  @Transient()
  ConnectionStatus? status;

  int? get dbStatus {
    return status?.stableId;
  }

  set dbStatus(int? value) {
    if (value == null) {
      status = null;
    } else {
      status = ConnectionStatus.fromStableId(value);
    }
  }

  @Property(type: PropertyType.date)
  DateTime? requestedAt;
  @Property(type: PropertyType.date)
  DateTime? acceptedAt;
  @Property(type: PropertyType.date)
  DateTime? blockedAt;
  String? notes;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  UserConnection({
    this.localId = 0,
    required this.id,
    required this.userId,
    required this.connectedUserId,
    ConnectionStatus status = ConnectionStatus.pending,
    this.requestedAt,
    this.acceptedAt,
    this.blockedAt,
    this.notes,
    this.createdAt,
    this.updatedAt,
  }) {
    this.status = status;
  }

  factory UserConnection.fromJson(Map<String, dynamic> json) =>
      _$UserConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$UserConnectionToJson(this);
}

enum ConnectionStatus {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('blocked')
  blocked,
  @JsonValue('rejected')
  rejected;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case ConnectionStatus.unknown:
        return 0;
      case ConnectionStatus.pending:
        return 1;
      case ConnectionStatus.accepted:
        return 2;
      case ConnectionStatus.blocked:
        return 3;
      case ConnectionStatus.rejected:
        return 4;
    }
  }

  static ConnectionStatus fromStableId(int id) {
    switch (id) {
      case 0:
        return ConnectionStatus.unknown;
      case 1:
        return ConnectionStatus.pending;
      case 2:
        return ConnectionStatus.accepted;
      case 3:
        return ConnectionStatus.blocked;
      case 4:
        return ConnectionStatus.rejected;
      default:
        return ConnectionStatus.unknown;
    }
  }
}
