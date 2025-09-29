// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'first_name') String get firstName;@JsonKey(name: 'last_name') String? get lastName;@JsonKey(name: 'email_address') String get emailAddress;@JsonKey(name: 'mobile_number') String? get mobileNumber;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'location_area') String? get locationArea; double? get latitude; double? get longitude;@JsonKey(name: 'favorite_sports') List<String>? get favoriteSports;@JsonKey(name: 'karma_score') int get karmaScore;@JsonKey(name: 'games_played_count') int get gamesPlayedCount;@JsonKey(name: 'playpals_user_ids') List<String>? get playpalsUserIds; String? get gender; String? get bio;@JsonKey(name: 'booked_sessions_ids') List<String>? get bookedSessionsIds;@JsonKey(name: 'blocked_user_ids') List<String>? get blockedUserIds; String? get city; String? get state; String? get country;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;@JsonKey(name: 'is_email_verified') bool get isEmailVerified;@JsonKey(name: 'is_mobile_verified') bool get isMobileVerified;@JsonKey(name: 'user_role') UserRole get userRole;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.emailAddress, emailAddress) || other.emailAddress == emailAddress)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.locationArea, locationArea) || other.locationArea == locationArea)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other.favoriteSports, favoriteSports)&&(identical(other.karmaScore, karmaScore) || other.karmaScore == karmaScore)&&(identical(other.gamesPlayedCount, gamesPlayedCount) || other.gamesPlayedCount == gamesPlayedCount)&&const DeepCollectionEquality().equals(other.playpalsUserIds, playpalsUserIds)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.bio, bio) || other.bio == bio)&&const DeepCollectionEquality().equals(other.bookedSessionsIds, bookedSessionsIds)&&const DeepCollectionEquality().equals(other.blockedUserIds, blockedUserIds)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.country, country) || other.country == country)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.isMobileVerified, isMobileVerified) || other.isMobileVerified == isMobileVerified)&&(identical(other.userRole, userRole) || other.userRole == userRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,firstName,lastName,emailAddress,mobileNumber,avatarUrl,locationArea,latitude,longitude,const DeepCollectionEquality().hash(favoriteSports),karmaScore,gamesPlayedCount,const DeepCollectionEquality().hash(playpalsUserIds),gender,bio,const DeepCollectionEquality().hash(bookedSessionsIds),const DeepCollectionEquality().hash(blockedUserIds),city,state,country,createdAt,updatedAt,isEmailVerified,isMobileVerified,userRole]);

@override
String toString() {
  return 'User(userId: $userId, firstName: $firstName, lastName: $lastName, emailAddress: $emailAddress, mobileNumber: $mobileNumber, avatarUrl: $avatarUrl, locationArea: $locationArea, latitude: $latitude, longitude: $longitude, favoriteSports: $favoriteSports, karmaScore: $karmaScore, gamesPlayedCount: $gamesPlayedCount, playpalsUserIds: $playpalsUserIds, gender: $gender, bio: $bio, bookedSessionsIds: $bookedSessionsIds, blockedUserIds: $blockedUserIds, city: $city, state: $state, country: $country, createdAt: $createdAt, updatedAt: $updatedAt, isEmailVerified: $isEmailVerified, isMobileVerified: $isMobileVerified, userRole: $userRole)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String? lastName,@JsonKey(name: 'email_address') String emailAddress,@JsonKey(name: 'mobile_number') String? mobileNumber,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'location_area') String? locationArea, double? latitude, double? longitude,@JsonKey(name: 'favorite_sports') List<String>? favoriteSports,@JsonKey(name: 'karma_score') int karmaScore,@JsonKey(name: 'games_played_count') int gamesPlayedCount,@JsonKey(name: 'playpals_user_ids') List<String>? playpalsUserIds, String? gender, String? bio,@JsonKey(name: 'booked_sessions_ids') List<String>? bookedSessionsIds,@JsonKey(name: 'blocked_user_ids') List<String>? blockedUserIds, String? city, String? state, String? country,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'is_email_verified') bool isEmailVerified,@JsonKey(name: 'is_mobile_verified') bool isMobileVerified,@JsonKey(name: 'user_role') UserRole userRole
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? firstName = null,Object? lastName = freezed,Object? emailAddress = null,Object? mobileNumber = freezed,Object? avatarUrl = freezed,Object? locationArea = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? favoriteSports = freezed,Object? karmaScore = null,Object? gamesPlayedCount = null,Object? playpalsUserIds = freezed,Object? gender = freezed,Object? bio = freezed,Object? bookedSessionsIds = freezed,Object? blockedUserIds = freezed,Object? city = freezed,Object? state = freezed,Object? country = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isEmailVerified = null,Object? isMobileVerified = null,Object? userRole = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,emailAddress: null == emailAddress ? _self.emailAddress : emailAddress // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,locationArea: freezed == locationArea ? _self.locationArea : locationArea // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,favoriteSports: freezed == favoriteSports ? _self.favoriteSports : favoriteSports // ignore: cast_nullable_to_non_nullable
as List<String>?,karmaScore: null == karmaScore ? _self.karmaScore : karmaScore // ignore: cast_nullable_to_non_nullable
as int,gamesPlayedCount: null == gamesPlayedCount ? _self.gamesPlayedCount : gamesPlayedCount // ignore: cast_nullable_to_non_nullable
as int,playpalsUserIds: freezed == playpalsUserIds ? _self.playpalsUserIds : playpalsUserIds // ignore: cast_nullable_to_non_nullable
as List<String>?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,bookedSessionsIds: freezed == bookedSessionsIds ? _self.bookedSessionsIds : bookedSessionsIds // ignore: cast_nullable_to_non_nullable
as List<String>?,blockedUserIds: freezed == blockedUserIds ? _self.blockedUserIds : blockedUserIds // ignore: cast_nullable_to_non_nullable
as List<String>?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,isMobileVerified: null == isMobileVerified ? _self.isMobileVerified : isMobileVerified // ignore: cast_nullable_to_non_nullable
as bool,userRole: null == userRole ? _self.userRole : userRole // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'email_address')  String emailAddress, @JsonKey(name: 'mobile_number')  String? mobileNumber, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'location_area')  String? locationArea,  double? latitude,  double? longitude, @JsonKey(name: 'favorite_sports')  List<String>? favoriteSports, @JsonKey(name: 'karma_score')  int karmaScore, @JsonKey(name: 'games_played_count')  int gamesPlayedCount, @JsonKey(name: 'playpals_user_ids')  List<String>? playpalsUserIds,  String? gender,  String? bio, @JsonKey(name: 'booked_sessions_ids')  List<String>? bookedSessionsIds, @JsonKey(name: 'blocked_user_ids')  List<String>? blockedUserIds,  String? city,  String? state,  String? country, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'is_email_verified')  bool isEmailVerified, @JsonKey(name: 'is_mobile_verified')  bool isMobileVerified, @JsonKey(name: 'user_role')  UserRole userRole)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.userId,_that.firstName,_that.lastName,_that.emailAddress,_that.mobileNumber,_that.avatarUrl,_that.locationArea,_that.latitude,_that.longitude,_that.favoriteSports,_that.karmaScore,_that.gamesPlayedCount,_that.playpalsUserIds,_that.gender,_that.bio,_that.bookedSessionsIds,_that.blockedUserIds,_that.city,_that.state,_that.country,_that.createdAt,_that.updatedAt,_that.isEmailVerified,_that.isMobileVerified,_that.userRole);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'email_address')  String emailAddress, @JsonKey(name: 'mobile_number')  String? mobileNumber, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'location_area')  String? locationArea,  double? latitude,  double? longitude, @JsonKey(name: 'favorite_sports')  List<String>? favoriteSports, @JsonKey(name: 'karma_score')  int karmaScore, @JsonKey(name: 'games_played_count')  int gamesPlayedCount, @JsonKey(name: 'playpals_user_ids')  List<String>? playpalsUserIds,  String? gender,  String? bio, @JsonKey(name: 'booked_sessions_ids')  List<String>? bookedSessionsIds, @JsonKey(name: 'blocked_user_ids')  List<String>? blockedUserIds,  String? city,  String? state,  String? country, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'is_email_verified')  bool isEmailVerified, @JsonKey(name: 'is_mobile_verified')  bool isMobileVerified, @JsonKey(name: 'user_role')  UserRole userRole)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.userId,_that.firstName,_that.lastName,_that.emailAddress,_that.mobileNumber,_that.avatarUrl,_that.locationArea,_that.latitude,_that.longitude,_that.favoriteSports,_that.karmaScore,_that.gamesPlayedCount,_that.playpalsUserIds,_that.gender,_that.bio,_that.bookedSessionsIds,_that.blockedUserIds,_that.city,_that.state,_that.country,_that.createdAt,_that.updatedAt,_that.isEmailVerified,_that.isMobileVerified,_that.userRole);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'first_name')  String firstName, @JsonKey(name: 'last_name')  String? lastName, @JsonKey(name: 'email_address')  String emailAddress, @JsonKey(name: 'mobile_number')  String? mobileNumber, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'location_area')  String? locationArea,  double? latitude,  double? longitude, @JsonKey(name: 'favorite_sports')  List<String>? favoriteSports, @JsonKey(name: 'karma_score')  int karmaScore, @JsonKey(name: 'games_played_count')  int gamesPlayedCount, @JsonKey(name: 'playpals_user_ids')  List<String>? playpalsUserIds,  String? gender,  String? bio, @JsonKey(name: 'booked_sessions_ids')  List<String>? bookedSessionsIds, @JsonKey(name: 'blocked_user_ids')  List<String>? blockedUserIds,  String? city,  String? state,  String? country, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'is_email_verified')  bool isEmailVerified, @JsonKey(name: 'is_mobile_verified')  bool isMobileVerified, @JsonKey(name: 'user_role')  UserRole userRole)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.userId,_that.firstName,_that.lastName,_that.emailAddress,_that.mobileNumber,_that.avatarUrl,_that.locationArea,_that.latitude,_that.longitude,_that.favoriteSports,_that.karmaScore,_that.gamesPlayedCount,_that.playpalsUserIds,_that.gender,_that.bio,_that.bookedSessionsIds,_that.blockedUserIds,_that.city,_that.state,_that.country,_that.createdAt,_that.updatedAt,_that.isEmailVerified,_that.isMobileVerified,_that.userRole);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User implements User {
  const _User({@JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'first_name') required this.firstName, @JsonKey(name: 'last_name') this.lastName, @JsonKey(name: 'email_address') required this.emailAddress, @JsonKey(name: 'mobile_number') this.mobileNumber, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'location_area') this.locationArea, this.latitude, this.longitude, @JsonKey(name: 'favorite_sports') final  List<String>? favoriteSports, @JsonKey(name: 'karma_score') this.karmaScore = 0, @JsonKey(name: 'games_played_count') this.gamesPlayedCount = 0, @JsonKey(name: 'playpals_user_ids') final  List<String>? playpalsUserIds, this.gender, this.bio, @JsonKey(name: 'booked_sessions_ids') final  List<String>? bookedSessionsIds, @JsonKey(name: 'blocked_user_ids') final  List<String>? blockedUserIds, this.city, this.state, this.country, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'is_email_verified') this.isEmailVerified = false, @JsonKey(name: 'is_mobile_verified') this.isMobileVerified = false, @JsonKey(name: 'user_role') this.userRole = UserRole.user}): _favoriteSports = favoriteSports,_playpalsUserIds = playpalsUserIds,_bookedSessionsIds = bookedSessionsIds,_blockedUserIds = blockedUserIds;
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'first_name') final  String firstName;
@override@JsonKey(name: 'last_name') final  String? lastName;
@override@JsonKey(name: 'email_address') final  String emailAddress;
@override@JsonKey(name: 'mobile_number') final  String? mobileNumber;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'location_area') final  String? locationArea;
@override final  double? latitude;
@override final  double? longitude;
 final  List<String>? _favoriteSports;
@override@JsonKey(name: 'favorite_sports') List<String>? get favoriteSports {
  final value = _favoriteSports;
  if (value == null) return null;
  if (_favoriteSports is EqualUnmodifiableListView) return _favoriteSports;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'karma_score') final  int karmaScore;
@override@JsonKey(name: 'games_played_count') final  int gamesPlayedCount;
 final  List<String>? _playpalsUserIds;
@override@JsonKey(name: 'playpals_user_ids') List<String>? get playpalsUserIds {
  final value = _playpalsUserIds;
  if (value == null) return null;
  if (_playpalsUserIds is EqualUnmodifiableListView) return _playpalsUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? gender;
@override final  String? bio;
 final  List<String>? _bookedSessionsIds;
@override@JsonKey(name: 'booked_sessions_ids') List<String>? get bookedSessionsIds {
  final value = _bookedSessionsIds;
  if (value == null) return null;
  if (_bookedSessionsIds is EqualUnmodifiableListView) return _bookedSessionsIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _blockedUserIds;
@override@JsonKey(name: 'blocked_user_ids') List<String>? get blockedUserIds {
  final value = _blockedUserIds;
  if (value == null) return null;
  if (_blockedUserIds is EqualUnmodifiableListView) return _blockedUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? city;
@override final  String? state;
@override final  String? country;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
@override@JsonKey(name: 'is_email_verified') final  bool isEmailVerified;
@override@JsonKey(name: 'is_mobile_verified') final  bool isMobileVerified;
@override@JsonKey(name: 'user_role') final  UserRole userRole;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.emailAddress, emailAddress) || other.emailAddress == emailAddress)&&(identical(other.mobileNumber, mobileNumber) || other.mobileNumber == mobileNumber)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.locationArea, locationArea) || other.locationArea == locationArea)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&const DeepCollectionEquality().equals(other._favoriteSports, _favoriteSports)&&(identical(other.karmaScore, karmaScore) || other.karmaScore == karmaScore)&&(identical(other.gamesPlayedCount, gamesPlayedCount) || other.gamesPlayedCount == gamesPlayedCount)&&const DeepCollectionEquality().equals(other._playpalsUserIds, _playpalsUserIds)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.bio, bio) || other.bio == bio)&&const DeepCollectionEquality().equals(other._bookedSessionsIds, _bookedSessionsIds)&&const DeepCollectionEquality().equals(other._blockedUserIds, _blockedUserIds)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.country, country) || other.country == country)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.isMobileVerified, isMobileVerified) || other.isMobileVerified == isMobileVerified)&&(identical(other.userRole, userRole) || other.userRole == userRole));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,userId,firstName,lastName,emailAddress,mobileNumber,avatarUrl,locationArea,latitude,longitude,const DeepCollectionEquality().hash(_favoriteSports),karmaScore,gamesPlayedCount,const DeepCollectionEquality().hash(_playpalsUserIds),gender,bio,const DeepCollectionEquality().hash(_bookedSessionsIds),const DeepCollectionEquality().hash(_blockedUserIds),city,state,country,createdAt,updatedAt,isEmailVerified,isMobileVerified,userRole]);

@override
String toString() {
  return 'User(userId: $userId, firstName: $firstName, lastName: $lastName, emailAddress: $emailAddress, mobileNumber: $mobileNumber, avatarUrl: $avatarUrl, locationArea: $locationArea, latitude: $latitude, longitude: $longitude, favoriteSports: $favoriteSports, karmaScore: $karmaScore, gamesPlayedCount: $gamesPlayedCount, playpalsUserIds: $playpalsUserIds, gender: $gender, bio: $bio, bookedSessionsIds: $bookedSessionsIds, blockedUserIds: $blockedUserIds, city: $city, state: $state, country: $country, createdAt: $createdAt, updatedAt: $updatedAt, isEmailVerified: $isEmailVerified, isMobileVerified: $isMobileVerified, userRole: $userRole)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'first_name') String firstName,@JsonKey(name: 'last_name') String? lastName,@JsonKey(name: 'email_address') String emailAddress,@JsonKey(name: 'mobile_number') String? mobileNumber,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'location_area') String? locationArea, double? latitude, double? longitude,@JsonKey(name: 'favorite_sports') List<String>? favoriteSports,@JsonKey(name: 'karma_score') int karmaScore,@JsonKey(name: 'games_played_count') int gamesPlayedCount,@JsonKey(name: 'playpals_user_ids') List<String>? playpalsUserIds, String? gender, String? bio,@JsonKey(name: 'booked_sessions_ids') List<String>? bookedSessionsIds,@JsonKey(name: 'blocked_user_ids') List<String>? blockedUserIds, String? city, String? state, String? country,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'is_email_verified') bool isEmailVerified,@JsonKey(name: 'is_mobile_verified') bool isMobileVerified,@JsonKey(name: 'user_role') UserRole userRole
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? firstName = null,Object? lastName = freezed,Object? emailAddress = null,Object? mobileNumber = freezed,Object? avatarUrl = freezed,Object? locationArea = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? favoriteSports = freezed,Object? karmaScore = null,Object? gamesPlayedCount = null,Object? playpalsUserIds = freezed,Object? gender = freezed,Object? bio = freezed,Object? bookedSessionsIds = freezed,Object? blockedUserIds = freezed,Object? city = freezed,Object? state = freezed,Object? country = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? isEmailVerified = null,Object? isMobileVerified = null,Object? userRole = null,}) {
  return _then(_User(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,emailAddress: null == emailAddress ? _self.emailAddress : emailAddress // ignore: cast_nullable_to_non_nullable
as String,mobileNumber: freezed == mobileNumber ? _self.mobileNumber : mobileNumber // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,locationArea: freezed == locationArea ? _self.locationArea : locationArea // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,favoriteSports: freezed == favoriteSports ? _self._favoriteSports : favoriteSports // ignore: cast_nullable_to_non_nullable
as List<String>?,karmaScore: null == karmaScore ? _self.karmaScore : karmaScore // ignore: cast_nullable_to_non_nullable
as int,gamesPlayedCount: null == gamesPlayedCount ? _self.gamesPlayedCount : gamesPlayedCount // ignore: cast_nullable_to_non_nullable
as int,playpalsUserIds: freezed == playpalsUserIds ? _self._playpalsUserIds : playpalsUserIds // ignore: cast_nullable_to_non_nullable
as List<String>?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,bookedSessionsIds: freezed == bookedSessionsIds ? _self._bookedSessionsIds : bookedSessionsIds // ignore: cast_nullable_to_non_nullable
as List<String>?,blockedUserIds: freezed == blockedUserIds ? _self._blockedUserIds : blockedUserIds // ignore: cast_nullable_to_non_nullable
as List<String>?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,isMobileVerified: null == isMobileVerified ? _self.isMobileVerified : isMobileVerified // ignore: cast_nullable_to_non_nullable
as bool,userRole: null == userRole ? _self.userRole : userRole // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}


}

// dart format on
