import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/// User roles in the system (matches DB values)
enum UserRole {
  @JsonValue('user')
  user,
  @JsonValue('trainer')
  trainer,
  @JsonValue('admin')
  admin,
  @JsonValue('venue_partner')
  venuePartner,
}

/// Supabase users table model
@JsonSerializable()
class User {
  @JsonKey(name: 'user_id')
  String userId;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String? lastName;

  @JsonKey(name: 'email_address')
  String emailAddress;

  @JsonKey(name: 'mobile_number')
  String? mobileNumber;

  @JsonKey(name: 'avatar_url')
  String? avatarUrl;

  @JsonKey(name: 'location_area')
  String? locationArea;

  double? latitude;
  double? longitude;

  @JsonKey(name: 'favorite_sports')
  List<String>? favoriteSports;

  @JsonKey(name: 'karma_score')
  int karmaScore;

  @JsonKey(name: 'games_played_count')
  int gamesPlayedCount;

  @JsonKey(name: 'playpals_user_ids')
  List<String>? playpalsUserIds;

  String? gender;
  String? bio;

  @JsonKey(name: 'booked_sessions_ids')
  List<String>? bookedSessionsIds;

  @JsonKey(name: 'blocked_user_ids')
  List<String>? blockedUserIds;

  String? city;
  String? state;
  String? country;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  @JsonKey(name: 'is_email_verified')
  bool isEmailVerified;

  @JsonKey(name: 'is_mobile_verified')
  bool isMobileVerified;

  @JsonKey(name: 'user_role')
  UserRole userRole;

  User({
    required this.userId,
    required this.firstName,
    this.lastName,
    required this.emailAddress,
    this.mobileNumber,
    this.avatarUrl,
    this.locationArea,
    this.latitude,
    this.longitude,
    this.favoriteSports,
    this.karmaScore = 0,
    this.gamesPlayedCount = 0,
    this.playpalsUserIds,
    this.gender,
    this.bio,
    this.bookedSessionsIds,
    this.blockedUserIds,
    this.city,
    this.state,
    this.country,
    this.createdAt,
    this.updatedAt,
    this.isEmailVerified = false,
    this.isMobileVerified = false,
    this.userRole = UserRole.user,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
