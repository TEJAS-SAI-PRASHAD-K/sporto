// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sport.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Sport {

@JsonKey(name: 'sport_id') String get sportId;@JsonKey(name: 'sport_name') String get sportName;@JsonKey(name: 'icon_url') String? get iconUrl;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'sport_category') String? get sportCategory; String? get aliases;@JsonKey(name: 'game_type') String? get gameType;@JsonKey(name: 'minimum_players') int? get minimumPlayers;@JsonKey(name: 'maximum_players') int? get maximumPlayers;@JsonKey(name: 'game_duration_minutes') int? get gameDurationMinutes;@JsonKey(name: 'rules_and_regulations') String? get rulesAndRegulations;@JsonKey(name: 'is_sport_active') bool get isSportActive;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;@JsonKey(name: 'equipment_required') List<String>? get equipmentRequired;
/// Create a copy of Sport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SportCopyWith<Sport> get copyWith => _$SportCopyWithImpl<Sport>(this as Sport, _$identity);

  /// Serializes this Sport to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sport&&(identical(other.sportId, sportId) || other.sportId == sportId)&&(identical(other.sportName, sportName) || other.sportName == sportName)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sportCategory, sportCategory) || other.sportCategory == sportCategory)&&(identical(other.aliases, aliases) || other.aliases == aliases)&&(identical(other.gameType, gameType) || other.gameType == gameType)&&(identical(other.minimumPlayers, minimumPlayers) || other.minimumPlayers == minimumPlayers)&&(identical(other.maximumPlayers, maximumPlayers) || other.maximumPlayers == maximumPlayers)&&(identical(other.gameDurationMinutes, gameDurationMinutes) || other.gameDurationMinutes == gameDurationMinutes)&&(identical(other.rulesAndRegulations, rulesAndRegulations) || other.rulesAndRegulations == rulesAndRegulations)&&(identical(other.isSportActive, isSportActive) || other.isSportActive == isSportActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.equipmentRequired, equipmentRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sportId,sportName,iconUrl,imageUrl,sportCategory,aliases,gameType,minimumPlayers,maximumPlayers,gameDurationMinutes,rulesAndRegulations,isSportActive,createdAt,updatedAt,const DeepCollectionEquality().hash(equipmentRequired));

@override
String toString() {
  return 'Sport(sportId: $sportId, sportName: $sportName, iconUrl: $iconUrl, imageUrl: $imageUrl, sportCategory: $sportCategory, aliases: $aliases, gameType: $gameType, minimumPlayers: $minimumPlayers, maximumPlayers: $maximumPlayers, gameDurationMinutes: $gameDurationMinutes, rulesAndRegulations: $rulesAndRegulations, isSportActive: $isSportActive, createdAt: $createdAt, updatedAt: $updatedAt, equipmentRequired: $equipmentRequired)';
}


}

/// @nodoc
abstract mixin class $SportCopyWith<$Res>  {
  factory $SportCopyWith(Sport value, $Res Function(Sport) _then) = _$SportCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'sport_id') String sportId,@JsonKey(name: 'sport_name') String sportName,@JsonKey(name: 'icon_url') String? iconUrl,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'sport_category') String? sportCategory, String? aliases,@JsonKey(name: 'game_type') String? gameType,@JsonKey(name: 'minimum_players') int? minimumPlayers,@JsonKey(name: 'maximum_players') int? maximumPlayers,@JsonKey(name: 'game_duration_minutes') int? gameDurationMinutes,@JsonKey(name: 'rules_and_regulations') String? rulesAndRegulations,@JsonKey(name: 'is_sport_active') bool isSportActive,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'equipment_required') List<String>? equipmentRequired
});




}
/// @nodoc
class _$SportCopyWithImpl<$Res>
    implements $SportCopyWith<$Res> {
  _$SportCopyWithImpl(this._self, this._then);

  final Sport _self;
  final $Res Function(Sport) _then;

/// Create a copy of Sport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sportId = null,Object? sportName = null,Object? iconUrl = freezed,Object? imageUrl = freezed,Object? sportCategory = freezed,Object? aliases = freezed,Object? gameType = freezed,Object? minimumPlayers = freezed,Object? maximumPlayers = freezed,Object? gameDurationMinutes = freezed,Object? rulesAndRegulations = freezed,Object? isSportActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? equipmentRequired = freezed,}) {
  return _then(_self.copyWith(
sportId: null == sportId ? _self.sportId : sportId // ignore: cast_nullable_to_non_nullable
as String,sportName: null == sportName ? _self.sportName : sportName // ignore: cast_nullable_to_non_nullable
as String,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,sportCategory: freezed == sportCategory ? _self.sportCategory : sportCategory // ignore: cast_nullable_to_non_nullable
as String?,aliases: freezed == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as String?,gameType: freezed == gameType ? _self.gameType : gameType // ignore: cast_nullable_to_non_nullable
as String?,minimumPlayers: freezed == minimumPlayers ? _self.minimumPlayers : minimumPlayers // ignore: cast_nullable_to_non_nullable
as int?,maximumPlayers: freezed == maximumPlayers ? _self.maximumPlayers : maximumPlayers // ignore: cast_nullable_to_non_nullable
as int?,gameDurationMinutes: freezed == gameDurationMinutes ? _self.gameDurationMinutes : gameDurationMinutes // ignore: cast_nullable_to_non_nullable
as int?,rulesAndRegulations: freezed == rulesAndRegulations ? _self.rulesAndRegulations : rulesAndRegulations // ignore: cast_nullable_to_non_nullable
as String?,isSportActive: null == isSportActive ? _self.isSportActive : isSportActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,equipmentRequired: freezed == equipmentRequired ? _self.equipmentRequired : equipmentRequired // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Sport].
extension SportPatterns on Sport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sport value)  $default,){
final _that = this;
switch (_that) {
case _Sport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sport value)?  $default,){
final _that = this;
switch (_that) {
case _Sport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'sport_id')  String sportId, @JsonKey(name: 'sport_name')  String sportName, @JsonKey(name: 'icon_url')  String? iconUrl, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'sport_category')  String? sportCategory,  String? aliases, @JsonKey(name: 'game_type')  String? gameType, @JsonKey(name: 'minimum_players')  int? minimumPlayers, @JsonKey(name: 'maximum_players')  int? maximumPlayers, @JsonKey(name: 'game_duration_minutes')  int? gameDurationMinutes, @JsonKey(name: 'rules_and_regulations')  String? rulesAndRegulations, @JsonKey(name: 'is_sport_active')  bool isSportActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'equipment_required')  List<String>? equipmentRequired)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sport() when $default != null:
return $default(_that.sportId,_that.sportName,_that.iconUrl,_that.imageUrl,_that.sportCategory,_that.aliases,_that.gameType,_that.minimumPlayers,_that.maximumPlayers,_that.gameDurationMinutes,_that.rulesAndRegulations,_that.isSportActive,_that.createdAt,_that.updatedAt,_that.equipmentRequired);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'sport_id')  String sportId, @JsonKey(name: 'sport_name')  String sportName, @JsonKey(name: 'icon_url')  String? iconUrl, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'sport_category')  String? sportCategory,  String? aliases, @JsonKey(name: 'game_type')  String? gameType, @JsonKey(name: 'minimum_players')  int? minimumPlayers, @JsonKey(name: 'maximum_players')  int? maximumPlayers, @JsonKey(name: 'game_duration_minutes')  int? gameDurationMinutes, @JsonKey(name: 'rules_and_regulations')  String? rulesAndRegulations, @JsonKey(name: 'is_sport_active')  bool isSportActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'equipment_required')  List<String>? equipmentRequired)  $default,) {final _that = this;
switch (_that) {
case _Sport():
return $default(_that.sportId,_that.sportName,_that.iconUrl,_that.imageUrl,_that.sportCategory,_that.aliases,_that.gameType,_that.minimumPlayers,_that.maximumPlayers,_that.gameDurationMinutes,_that.rulesAndRegulations,_that.isSportActive,_that.createdAt,_that.updatedAt,_that.equipmentRequired);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'sport_id')  String sportId, @JsonKey(name: 'sport_name')  String sportName, @JsonKey(name: 'icon_url')  String? iconUrl, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'sport_category')  String? sportCategory,  String? aliases, @JsonKey(name: 'game_type')  String? gameType, @JsonKey(name: 'minimum_players')  int? minimumPlayers, @JsonKey(name: 'maximum_players')  int? maximumPlayers, @JsonKey(name: 'game_duration_minutes')  int? gameDurationMinutes, @JsonKey(name: 'rules_and_regulations')  String? rulesAndRegulations, @JsonKey(name: 'is_sport_active')  bool isSportActive, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'equipment_required')  List<String>? equipmentRequired)?  $default,) {final _that = this;
switch (_that) {
case _Sport() when $default != null:
return $default(_that.sportId,_that.sportName,_that.iconUrl,_that.imageUrl,_that.sportCategory,_that.aliases,_that.gameType,_that.minimumPlayers,_that.maximumPlayers,_that.gameDurationMinutes,_that.rulesAndRegulations,_that.isSportActive,_that.createdAt,_that.updatedAt,_that.equipmentRequired);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Sport implements Sport {
  const _Sport({@JsonKey(name: 'sport_id') required this.sportId, @JsonKey(name: 'sport_name') required this.sportName, @JsonKey(name: 'icon_url') this.iconUrl, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'sport_category') this.sportCategory, this.aliases, @JsonKey(name: 'game_type') this.gameType, @JsonKey(name: 'minimum_players') this.minimumPlayers, @JsonKey(name: 'maximum_players') this.maximumPlayers, @JsonKey(name: 'game_duration_minutes') this.gameDurationMinutes, @JsonKey(name: 'rules_and_regulations') this.rulesAndRegulations, @JsonKey(name: 'is_sport_active') this.isSportActive = true, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'equipment_required') final  List<String>? equipmentRequired}): _equipmentRequired = equipmentRequired;
  factory _Sport.fromJson(Map<String, dynamic> json) => _$SportFromJson(json);

@override@JsonKey(name: 'sport_id') final  String sportId;
@override@JsonKey(name: 'sport_name') final  String sportName;
@override@JsonKey(name: 'icon_url') final  String? iconUrl;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'sport_category') final  String? sportCategory;
@override final  String? aliases;
@override@JsonKey(name: 'game_type') final  String? gameType;
@override@JsonKey(name: 'minimum_players') final  int? minimumPlayers;
@override@JsonKey(name: 'maximum_players') final  int? maximumPlayers;
@override@JsonKey(name: 'game_duration_minutes') final  int? gameDurationMinutes;
@override@JsonKey(name: 'rules_and_regulations') final  String? rulesAndRegulations;
@override@JsonKey(name: 'is_sport_active') final  bool isSportActive;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
 final  List<String>? _equipmentRequired;
@override@JsonKey(name: 'equipment_required') List<String>? get equipmentRequired {
  final value = _equipmentRequired;
  if (value == null) return null;
  if (_equipmentRequired is EqualUnmodifiableListView) return _equipmentRequired;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Sport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SportCopyWith<_Sport> get copyWith => __$SportCopyWithImpl<_Sport>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SportToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sport&&(identical(other.sportId, sportId) || other.sportId == sportId)&&(identical(other.sportName, sportName) || other.sportName == sportName)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.sportCategory, sportCategory) || other.sportCategory == sportCategory)&&(identical(other.aliases, aliases) || other.aliases == aliases)&&(identical(other.gameType, gameType) || other.gameType == gameType)&&(identical(other.minimumPlayers, minimumPlayers) || other.minimumPlayers == minimumPlayers)&&(identical(other.maximumPlayers, maximumPlayers) || other.maximumPlayers == maximumPlayers)&&(identical(other.gameDurationMinutes, gameDurationMinutes) || other.gameDurationMinutes == gameDurationMinutes)&&(identical(other.rulesAndRegulations, rulesAndRegulations) || other.rulesAndRegulations == rulesAndRegulations)&&(identical(other.isSportActive, isSportActive) || other.isSportActive == isSportActive)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._equipmentRequired, _equipmentRequired));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sportId,sportName,iconUrl,imageUrl,sportCategory,aliases,gameType,minimumPlayers,maximumPlayers,gameDurationMinutes,rulesAndRegulations,isSportActive,createdAt,updatedAt,const DeepCollectionEquality().hash(_equipmentRequired));

@override
String toString() {
  return 'Sport(sportId: $sportId, sportName: $sportName, iconUrl: $iconUrl, imageUrl: $imageUrl, sportCategory: $sportCategory, aliases: $aliases, gameType: $gameType, minimumPlayers: $minimumPlayers, maximumPlayers: $maximumPlayers, gameDurationMinutes: $gameDurationMinutes, rulesAndRegulations: $rulesAndRegulations, isSportActive: $isSportActive, createdAt: $createdAt, updatedAt: $updatedAt, equipmentRequired: $equipmentRequired)';
}


}

/// @nodoc
abstract mixin class _$SportCopyWith<$Res> implements $SportCopyWith<$Res> {
  factory _$SportCopyWith(_Sport value, $Res Function(_Sport) _then) = __$SportCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'sport_id') String sportId,@JsonKey(name: 'sport_name') String sportName,@JsonKey(name: 'icon_url') String? iconUrl,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'sport_category') String? sportCategory, String? aliases,@JsonKey(name: 'game_type') String? gameType,@JsonKey(name: 'minimum_players') int? minimumPlayers,@JsonKey(name: 'maximum_players') int? maximumPlayers,@JsonKey(name: 'game_duration_minutes') int? gameDurationMinutes,@JsonKey(name: 'rules_and_regulations') String? rulesAndRegulations,@JsonKey(name: 'is_sport_active') bool isSportActive,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'equipment_required') List<String>? equipmentRequired
});




}
/// @nodoc
class __$SportCopyWithImpl<$Res>
    implements _$SportCopyWith<$Res> {
  __$SportCopyWithImpl(this._self, this._then);

  final _Sport _self;
  final $Res Function(_Sport) _then;

/// Create a copy of Sport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sportId = null,Object? sportName = null,Object? iconUrl = freezed,Object? imageUrl = freezed,Object? sportCategory = freezed,Object? aliases = freezed,Object? gameType = freezed,Object? minimumPlayers = freezed,Object? maximumPlayers = freezed,Object? gameDurationMinutes = freezed,Object? rulesAndRegulations = freezed,Object? isSportActive = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? equipmentRequired = freezed,}) {
  return _then(_Sport(
sportId: null == sportId ? _self.sportId : sportId // ignore: cast_nullable_to_non_nullable
as String,sportName: null == sportName ? _self.sportName : sportName // ignore: cast_nullable_to_non_nullable
as String,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,sportCategory: freezed == sportCategory ? _self.sportCategory : sportCategory // ignore: cast_nullable_to_non_nullable
as String?,aliases: freezed == aliases ? _self.aliases : aliases // ignore: cast_nullable_to_non_nullable
as String?,gameType: freezed == gameType ? _self.gameType : gameType // ignore: cast_nullable_to_non_nullable
as String?,minimumPlayers: freezed == minimumPlayers ? _self.minimumPlayers : minimumPlayers // ignore: cast_nullable_to_non_nullable
as int?,maximumPlayers: freezed == maximumPlayers ? _self.maximumPlayers : maximumPlayers // ignore: cast_nullable_to_non_nullable
as int?,gameDurationMinutes: freezed == gameDurationMinutes ? _self.gameDurationMinutes : gameDurationMinutes // ignore: cast_nullable_to_non_nullable
as int?,rulesAndRegulations: freezed == rulesAndRegulations ? _self.rulesAndRegulations : rulesAndRegulations // ignore: cast_nullable_to_non_nullable
as String?,isSportActive: null == isSportActive ? _self.isSportActive : isSportActive // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,equipmentRequired: freezed == equipmentRequired ? _self._equipmentRequired : equipmentRequired // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$SportsSkillLevel {

@JsonKey(name: 'skill_level_id') String get skillLevelId;@JsonKey(name: 'sport_id') String get sportId;@JsonKey(name: 'level_number') int get levelNumber;@JsonKey(name: 'display_name') String get displayName;@JsonKey(name: 'level_order') int? get levelOrder; String? get characteristics;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of SportsSkillLevel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SportsSkillLevelCopyWith<SportsSkillLevel> get copyWith => _$SportsSkillLevelCopyWithImpl<SportsSkillLevel>(this as SportsSkillLevel, _$identity);

  /// Serializes this SportsSkillLevel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SportsSkillLevel&&(identical(other.skillLevelId, skillLevelId) || other.skillLevelId == skillLevelId)&&(identical(other.sportId, sportId) || other.sportId == sportId)&&(identical(other.levelNumber, levelNumber) || other.levelNumber == levelNumber)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.levelOrder, levelOrder) || other.levelOrder == levelOrder)&&(identical(other.characteristics, characteristics) || other.characteristics == characteristics)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,skillLevelId,sportId,levelNumber,displayName,levelOrder,characteristics,createdAt,updatedAt);

@override
String toString() {
  return 'SportsSkillLevel(skillLevelId: $skillLevelId, sportId: $sportId, levelNumber: $levelNumber, displayName: $displayName, levelOrder: $levelOrder, characteristics: $characteristics, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SportsSkillLevelCopyWith<$Res>  {
  factory $SportsSkillLevelCopyWith(SportsSkillLevel value, $Res Function(SportsSkillLevel) _then) = _$SportsSkillLevelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'skill_level_id') String skillLevelId,@JsonKey(name: 'sport_id') String sportId,@JsonKey(name: 'level_number') int levelNumber,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'level_order') int? levelOrder, String? characteristics,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$SportsSkillLevelCopyWithImpl<$Res>
    implements $SportsSkillLevelCopyWith<$Res> {
  _$SportsSkillLevelCopyWithImpl(this._self, this._then);

  final SportsSkillLevel _self;
  final $Res Function(SportsSkillLevel) _then;

/// Create a copy of SportsSkillLevel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? skillLevelId = null,Object? sportId = null,Object? levelNumber = null,Object? displayName = null,Object? levelOrder = freezed,Object? characteristics = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
skillLevelId: null == skillLevelId ? _self.skillLevelId : skillLevelId // ignore: cast_nullable_to_non_nullable
as String,sportId: null == sportId ? _self.sportId : sportId // ignore: cast_nullable_to_non_nullable
as String,levelNumber: null == levelNumber ? _self.levelNumber : levelNumber // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,levelOrder: freezed == levelOrder ? _self.levelOrder : levelOrder // ignore: cast_nullable_to_non_nullable
as int?,characteristics: freezed == characteristics ? _self.characteristics : characteristics // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SportsSkillLevel].
extension SportsSkillLevelPatterns on SportsSkillLevel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SportsSkillLevel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SportsSkillLevel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SportsSkillLevel value)  $default,){
final _that = this;
switch (_that) {
case _SportsSkillLevel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SportsSkillLevel value)?  $default,){
final _that = this;
switch (_that) {
case _SportsSkillLevel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'skill_level_id')  String skillLevelId, @JsonKey(name: 'sport_id')  String sportId, @JsonKey(name: 'level_number')  int levelNumber, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'level_order')  int? levelOrder,  String? characteristics, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SportsSkillLevel() when $default != null:
return $default(_that.skillLevelId,_that.sportId,_that.levelNumber,_that.displayName,_that.levelOrder,_that.characteristics,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'skill_level_id')  String skillLevelId, @JsonKey(name: 'sport_id')  String sportId, @JsonKey(name: 'level_number')  int levelNumber, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'level_order')  int? levelOrder,  String? characteristics, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SportsSkillLevel():
return $default(_that.skillLevelId,_that.sportId,_that.levelNumber,_that.displayName,_that.levelOrder,_that.characteristics,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'skill_level_id')  String skillLevelId, @JsonKey(name: 'sport_id')  String sportId, @JsonKey(name: 'level_number')  int levelNumber, @JsonKey(name: 'display_name')  String displayName, @JsonKey(name: 'level_order')  int? levelOrder,  String? characteristics, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SportsSkillLevel() when $default != null:
return $default(_that.skillLevelId,_that.sportId,_that.levelNumber,_that.displayName,_that.levelOrder,_that.characteristics,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SportsSkillLevel implements SportsSkillLevel {
  const _SportsSkillLevel({@JsonKey(name: 'skill_level_id') required this.skillLevelId, @JsonKey(name: 'sport_id') required this.sportId, @JsonKey(name: 'level_number') required this.levelNumber, @JsonKey(name: 'display_name') required this.displayName, @JsonKey(name: 'level_order') this.levelOrder, this.characteristics, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _SportsSkillLevel.fromJson(Map<String, dynamic> json) => _$SportsSkillLevelFromJson(json);

@override@JsonKey(name: 'skill_level_id') final  String skillLevelId;
@override@JsonKey(name: 'sport_id') final  String sportId;
@override@JsonKey(name: 'level_number') final  int levelNumber;
@override@JsonKey(name: 'display_name') final  String displayName;
@override@JsonKey(name: 'level_order') final  int? levelOrder;
@override final  String? characteristics;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of SportsSkillLevel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SportsSkillLevelCopyWith<_SportsSkillLevel> get copyWith => __$SportsSkillLevelCopyWithImpl<_SportsSkillLevel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SportsSkillLevelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SportsSkillLevel&&(identical(other.skillLevelId, skillLevelId) || other.skillLevelId == skillLevelId)&&(identical(other.sportId, sportId) || other.sportId == sportId)&&(identical(other.levelNumber, levelNumber) || other.levelNumber == levelNumber)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.levelOrder, levelOrder) || other.levelOrder == levelOrder)&&(identical(other.characteristics, characteristics) || other.characteristics == characteristics)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,skillLevelId,sportId,levelNumber,displayName,levelOrder,characteristics,createdAt,updatedAt);

@override
String toString() {
  return 'SportsSkillLevel(skillLevelId: $skillLevelId, sportId: $sportId, levelNumber: $levelNumber, displayName: $displayName, levelOrder: $levelOrder, characteristics: $characteristics, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SportsSkillLevelCopyWith<$Res> implements $SportsSkillLevelCopyWith<$Res> {
  factory _$SportsSkillLevelCopyWith(_SportsSkillLevel value, $Res Function(_SportsSkillLevel) _then) = __$SportsSkillLevelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'skill_level_id') String skillLevelId,@JsonKey(name: 'sport_id') String sportId,@JsonKey(name: 'level_number') int levelNumber,@JsonKey(name: 'display_name') String displayName,@JsonKey(name: 'level_order') int? levelOrder, String? characteristics,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$SportsSkillLevelCopyWithImpl<$Res>
    implements _$SportsSkillLevelCopyWith<$Res> {
  __$SportsSkillLevelCopyWithImpl(this._self, this._then);

  final _SportsSkillLevel _self;
  final $Res Function(_SportsSkillLevel) _then;

/// Create a copy of SportsSkillLevel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? skillLevelId = null,Object? sportId = null,Object? levelNumber = null,Object? displayName = null,Object? levelOrder = freezed,Object? characteristics = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_SportsSkillLevel(
skillLevelId: null == skillLevelId ? _self.skillLevelId : skillLevelId // ignore: cast_nullable_to_non_nullable
as String,sportId: null == sportId ? _self.sportId : sportId // ignore: cast_nullable_to_non_nullable
as String,levelNumber: null == levelNumber ? _self.levelNumber : levelNumber // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,levelOrder: freezed == levelOrder ? _self.levelOrder : levelOrder // ignore: cast_nullable_to_non_nullable
as int?,characteristics: freezed == characteristics ? _self.characteristics : characteristics // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
