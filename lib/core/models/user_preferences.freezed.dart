// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPreferences {

@JsonKey(name: 'preference_id') String get preferenceId;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'notifications_enabled') bool get notificationsEnabled;@JsonKey(name: 'game_invites_enabled') bool get gameInvitesEnabled;@JsonKey(name: 'app_theme') String get appTheme;@JsonKey(name: 'promotional_emails_enabled') bool get promotionalEmailsEnabled;@JsonKey(name: 'location_sharing_enabled') bool get locationSharingEnabled;@JsonKey(name: 'preferred_language') String get preferredLanguage;@JsonKey(name: 'distance_unit') String get distanceUnit;@JsonKey(name: 'time_format') String get timeFormat;@JsonKey(name: 'search_radius_km') double? get searchRadiusKm;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPreferencesCopyWith<UserPreferences> get copyWith => _$UserPreferencesCopyWithImpl<UserPreferences>(this as UserPreferences, _$identity);

  /// Serializes this UserPreferences to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPreferences&&(identical(other.preferenceId, preferenceId) || other.preferenceId == preferenceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.gameInvitesEnabled, gameInvitesEnabled) || other.gameInvitesEnabled == gameInvitesEnabled)&&(identical(other.appTheme, appTheme) || other.appTheme == appTheme)&&(identical(other.promotionalEmailsEnabled, promotionalEmailsEnabled) || other.promotionalEmailsEnabled == promotionalEmailsEnabled)&&(identical(other.locationSharingEnabled, locationSharingEnabled) || other.locationSharingEnabled == locationSharingEnabled)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.distanceUnit, distanceUnit) || other.distanceUnit == distanceUnit)&&(identical(other.timeFormat, timeFormat) || other.timeFormat == timeFormat)&&(identical(other.searchRadiusKm, searchRadiusKm) || other.searchRadiusKm == searchRadiusKm)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,preferenceId,userId,notificationsEnabled,gameInvitesEnabled,appTheme,promotionalEmailsEnabled,locationSharingEnabled,preferredLanguage,distanceUnit,timeFormat,searchRadiusKm,updatedAt);

@override
String toString() {
  return 'UserPreferences(preferenceId: $preferenceId, userId: $userId, notificationsEnabled: $notificationsEnabled, gameInvitesEnabled: $gameInvitesEnabled, appTheme: $appTheme, promotionalEmailsEnabled: $promotionalEmailsEnabled, locationSharingEnabled: $locationSharingEnabled, preferredLanguage: $preferredLanguage, distanceUnit: $distanceUnit, timeFormat: $timeFormat, searchRadiusKm: $searchRadiusKm, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $UserPreferencesCopyWith<$Res>  {
  factory $UserPreferencesCopyWith(UserPreferences value, $Res Function(UserPreferences) _then) = _$UserPreferencesCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'preference_id') String preferenceId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'notifications_enabled') bool notificationsEnabled,@JsonKey(name: 'game_invites_enabled') bool gameInvitesEnabled,@JsonKey(name: 'app_theme') String appTheme,@JsonKey(name: 'promotional_emails_enabled') bool promotionalEmailsEnabled,@JsonKey(name: 'location_sharing_enabled') bool locationSharingEnabled,@JsonKey(name: 'preferred_language') String preferredLanguage,@JsonKey(name: 'distance_unit') String distanceUnit,@JsonKey(name: 'time_format') String timeFormat,@JsonKey(name: 'search_radius_km') double? searchRadiusKm,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$UserPreferencesCopyWithImpl<$Res>
    implements $UserPreferencesCopyWith<$Res> {
  _$UserPreferencesCopyWithImpl(this._self, this._then);

  final UserPreferences _self;
  final $Res Function(UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? preferenceId = null,Object? userId = null,Object? notificationsEnabled = null,Object? gameInvitesEnabled = null,Object? appTheme = null,Object? promotionalEmailsEnabled = null,Object? locationSharingEnabled = null,Object? preferredLanguage = null,Object? distanceUnit = null,Object? timeFormat = null,Object? searchRadiusKm = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
preferenceId: null == preferenceId ? _self.preferenceId : preferenceId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,gameInvitesEnabled: null == gameInvitesEnabled ? _self.gameInvitesEnabled : gameInvitesEnabled // ignore: cast_nullable_to_non_nullable
as bool,appTheme: null == appTheme ? _self.appTheme : appTheme // ignore: cast_nullable_to_non_nullable
as String,promotionalEmailsEnabled: null == promotionalEmailsEnabled ? _self.promotionalEmailsEnabled : promotionalEmailsEnabled // ignore: cast_nullable_to_non_nullable
as bool,locationSharingEnabled: null == locationSharingEnabled ? _self.locationSharingEnabled : locationSharingEnabled // ignore: cast_nullable_to_non_nullable
as bool,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,distanceUnit: null == distanceUnit ? _self.distanceUnit : distanceUnit // ignore: cast_nullable_to_non_nullable
as String,timeFormat: null == timeFormat ? _self.timeFormat : timeFormat // ignore: cast_nullable_to_non_nullable
as String,searchRadiusKm: freezed == searchRadiusKm ? _self.searchRadiusKm : searchRadiusKm // ignore: cast_nullable_to_non_nullable
as double?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPreferences].
extension UserPreferencesPatterns on UserPreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPreferences value)  $default,){
final _that = this;
switch (_that) {
case _UserPreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPreferences value)?  $default,){
final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'preference_id')  String preferenceId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'notifications_enabled')  bool notificationsEnabled, @JsonKey(name: 'game_invites_enabled')  bool gameInvitesEnabled, @JsonKey(name: 'app_theme')  String appTheme, @JsonKey(name: 'promotional_emails_enabled')  bool promotionalEmailsEnabled, @JsonKey(name: 'location_sharing_enabled')  bool locationSharingEnabled, @JsonKey(name: 'preferred_language')  String preferredLanguage, @JsonKey(name: 'distance_unit')  String distanceUnit, @JsonKey(name: 'time_format')  String timeFormat, @JsonKey(name: 'search_radius_km')  double? searchRadiusKm, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that.preferenceId,_that.userId,_that.notificationsEnabled,_that.gameInvitesEnabled,_that.appTheme,_that.promotionalEmailsEnabled,_that.locationSharingEnabled,_that.preferredLanguage,_that.distanceUnit,_that.timeFormat,_that.searchRadiusKm,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'preference_id')  String preferenceId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'notifications_enabled')  bool notificationsEnabled, @JsonKey(name: 'game_invites_enabled')  bool gameInvitesEnabled, @JsonKey(name: 'app_theme')  String appTheme, @JsonKey(name: 'promotional_emails_enabled')  bool promotionalEmailsEnabled, @JsonKey(name: 'location_sharing_enabled')  bool locationSharingEnabled, @JsonKey(name: 'preferred_language')  String preferredLanguage, @JsonKey(name: 'distance_unit')  String distanceUnit, @JsonKey(name: 'time_format')  String timeFormat, @JsonKey(name: 'search_radius_km')  double? searchRadiusKm, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserPreferences():
return $default(_that.preferenceId,_that.userId,_that.notificationsEnabled,_that.gameInvitesEnabled,_that.appTheme,_that.promotionalEmailsEnabled,_that.locationSharingEnabled,_that.preferredLanguage,_that.distanceUnit,_that.timeFormat,_that.searchRadiusKm,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'preference_id')  String preferenceId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'notifications_enabled')  bool notificationsEnabled, @JsonKey(name: 'game_invites_enabled')  bool gameInvitesEnabled, @JsonKey(name: 'app_theme')  String appTheme, @JsonKey(name: 'promotional_emails_enabled')  bool promotionalEmailsEnabled, @JsonKey(name: 'location_sharing_enabled')  bool locationSharingEnabled, @JsonKey(name: 'preferred_language')  String preferredLanguage, @JsonKey(name: 'distance_unit')  String distanceUnit, @JsonKey(name: 'time_format')  String timeFormat, @JsonKey(name: 'search_radius_km')  double? searchRadiusKm, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserPreferences() when $default != null:
return $default(_that.preferenceId,_that.userId,_that.notificationsEnabled,_that.gameInvitesEnabled,_that.appTheme,_that.promotionalEmailsEnabled,_that.locationSharingEnabled,_that.preferredLanguage,_that.distanceUnit,_that.timeFormat,_that.searchRadiusKm,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPreferences implements UserPreferences {
  const _UserPreferences({@JsonKey(name: 'preference_id') required this.preferenceId, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'notifications_enabled') this.notificationsEnabled = true, @JsonKey(name: 'game_invites_enabled') this.gameInvitesEnabled = true, @JsonKey(name: 'app_theme') this.appTheme = 'dark', @JsonKey(name: 'promotional_emails_enabled') this.promotionalEmailsEnabled = true, @JsonKey(name: 'location_sharing_enabled') this.locationSharingEnabled = true, @JsonKey(name: 'preferred_language') this.preferredLanguage = 'en', @JsonKey(name: 'distance_unit') this.distanceUnit = 'km', @JsonKey(name: 'time_format') this.timeFormat = '24h', @JsonKey(name: 'search_radius_km') this.searchRadiusKm, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _UserPreferences.fromJson(Map<String, dynamic> json) => _$UserPreferencesFromJson(json);

@override@JsonKey(name: 'preference_id') final  String preferenceId;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'notifications_enabled') final  bool notificationsEnabled;
@override@JsonKey(name: 'game_invites_enabled') final  bool gameInvitesEnabled;
@override@JsonKey(name: 'app_theme') final  String appTheme;
@override@JsonKey(name: 'promotional_emails_enabled') final  bool promotionalEmailsEnabled;
@override@JsonKey(name: 'location_sharing_enabled') final  bool locationSharingEnabled;
@override@JsonKey(name: 'preferred_language') final  String preferredLanguage;
@override@JsonKey(name: 'distance_unit') final  String distanceUnit;
@override@JsonKey(name: 'time_format') final  String timeFormat;
@override@JsonKey(name: 'search_radius_km') final  double? searchRadiusKm;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPreferencesCopyWith<_UserPreferences> get copyWith => __$UserPreferencesCopyWithImpl<_UserPreferences>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPreferencesToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPreferences&&(identical(other.preferenceId, preferenceId) || other.preferenceId == preferenceId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.gameInvitesEnabled, gameInvitesEnabled) || other.gameInvitesEnabled == gameInvitesEnabled)&&(identical(other.appTheme, appTheme) || other.appTheme == appTheme)&&(identical(other.promotionalEmailsEnabled, promotionalEmailsEnabled) || other.promotionalEmailsEnabled == promotionalEmailsEnabled)&&(identical(other.locationSharingEnabled, locationSharingEnabled) || other.locationSharingEnabled == locationSharingEnabled)&&(identical(other.preferredLanguage, preferredLanguage) || other.preferredLanguage == preferredLanguage)&&(identical(other.distanceUnit, distanceUnit) || other.distanceUnit == distanceUnit)&&(identical(other.timeFormat, timeFormat) || other.timeFormat == timeFormat)&&(identical(other.searchRadiusKm, searchRadiusKm) || other.searchRadiusKm == searchRadiusKm)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,preferenceId,userId,notificationsEnabled,gameInvitesEnabled,appTheme,promotionalEmailsEnabled,locationSharingEnabled,preferredLanguage,distanceUnit,timeFormat,searchRadiusKm,updatedAt);

@override
String toString() {
  return 'UserPreferences(preferenceId: $preferenceId, userId: $userId, notificationsEnabled: $notificationsEnabled, gameInvitesEnabled: $gameInvitesEnabled, appTheme: $appTheme, promotionalEmailsEnabled: $promotionalEmailsEnabled, locationSharingEnabled: $locationSharingEnabled, preferredLanguage: $preferredLanguage, distanceUnit: $distanceUnit, timeFormat: $timeFormat, searchRadiusKm: $searchRadiusKm, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserPreferencesCopyWith<$Res> implements $UserPreferencesCopyWith<$Res> {
  factory _$UserPreferencesCopyWith(_UserPreferences value, $Res Function(_UserPreferences) _then) = __$UserPreferencesCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'preference_id') String preferenceId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'notifications_enabled') bool notificationsEnabled,@JsonKey(name: 'game_invites_enabled') bool gameInvitesEnabled,@JsonKey(name: 'app_theme') String appTheme,@JsonKey(name: 'promotional_emails_enabled') bool promotionalEmailsEnabled,@JsonKey(name: 'location_sharing_enabled') bool locationSharingEnabled,@JsonKey(name: 'preferred_language') String preferredLanguage,@JsonKey(name: 'distance_unit') String distanceUnit,@JsonKey(name: 'time_format') String timeFormat,@JsonKey(name: 'search_radius_km') double? searchRadiusKm,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$UserPreferencesCopyWithImpl<$Res>
    implements _$UserPreferencesCopyWith<$Res> {
  __$UserPreferencesCopyWithImpl(this._self, this._then);

  final _UserPreferences _self;
  final $Res Function(_UserPreferences) _then;

/// Create a copy of UserPreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? preferenceId = null,Object? userId = null,Object? notificationsEnabled = null,Object? gameInvitesEnabled = null,Object? appTheme = null,Object? promotionalEmailsEnabled = null,Object? locationSharingEnabled = null,Object? preferredLanguage = null,Object? distanceUnit = null,Object? timeFormat = null,Object? searchRadiusKm = freezed,Object? updatedAt = freezed,}) {
  return _then(_UserPreferences(
preferenceId: null == preferenceId ? _self.preferenceId : preferenceId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,gameInvitesEnabled: null == gameInvitesEnabled ? _self.gameInvitesEnabled : gameInvitesEnabled // ignore: cast_nullable_to_non_nullable
as bool,appTheme: null == appTheme ? _self.appTheme : appTheme // ignore: cast_nullable_to_non_nullable
as String,promotionalEmailsEnabled: null == promotionalEmailsEnabled ? _self.promotionalEmailsEnabled : promotionalEmailsEnabled // ignore: cast_nullable_to_non_nullable
as bool,locationSharingEnabled: null == locationSharingEnabled ? _self.locationSharingEnabled : locationSharingEnabled // ignore: cast_nullable_to_non_nullable
as bool,preferredLanguage: null == preferredLanguage ? _self.preferredLanguage : preferredLanguage // ignore: cast_nullable_to_non_nullable
as String,distanceUnit: null == distanceUnit ? _self.distanceUnit : distanceUnit // ignore: cast_nullable_to_non_nullable
as String,timeFormat: null == timeFormat ? _self.timeFormat : timeFormat // ignore: cast_nullable_to_non_nullable
as String,searchRadiusKm: freezed == searchRadiusKm ? _self.searchRadiusKm : searchRadiusKm // ignore: cast_nullable_to_non_nullable
as double?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
