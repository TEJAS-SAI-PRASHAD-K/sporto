// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Game {

@JsonKey(name: 'game_id') String get gameId;@JsonKey(name: 'organiser_user_id') String get organiserUserId;@JsonKey(name: 'sport_id') String get sportId;@JsonKey(name: 'area_of_game') String? get areaOfGame;@JsonKey(name: 'game_date') DateTime? get gameDate;@JsonKey(name: 'game_time') String? get gameTime;// HH:mm:ss
@JsonKey(name: 'game_access_type') String? get gameAccessType;@JsonKey(name: 'current_players_count') int? get currentPlayersCount;@JsonKey(name: 'venue_name') String? get venueName;@JsonKey(name: 'venue_id') String? get venueId;@JsonKey(name: 'venue_address') String? get venueAddress;@JsonKey(name: 'venue_latitude') double? get venueLatitude;@JsonKey(name: 'venue_longitude') double? get venueLongitude;@JsonKey(name: 'player_ids') List<String>? get playerIds;@JsonKey(name: 'waitlist_user_ids') List<String>? get waitlistUserIds;@JsonKey(name: 'game_rules') String? get gameRules;@JsonKey(name: 'equipment_required') String? get equipmentRequired;@JsonKey(name: 'equipment_provided') String? get equipmentProvided;@JsonKey(name: 'requires_approval') bool get requiresApproval;@JsonKey(name: 'contact_information') String? get contactInformation; String? get notes;@JsonKey(name: 'view_count') int get viewCount;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;@JsonKey(name: 'venue_partner_id') String? get venuePartnerId;
/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameCopyWith<Game> get copyWith => _$GameCopyWithImpl<Game>(this as Game, _$identity);

  /// Serializes this Game to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Game&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.organiserUserId, organiserUserId) || other.organiserUserId == organiserUserId)&&(identical(other.sportId, sportId) || other.sportId == sportId)&&(identical(other.areaOfGame, areaOfGame) || other.areaOfGame == areaOfGame)&&(identical(other.gameDate, gameDate) || other.gameDate == gameDate)&&(identical(other.gameTime, gameTime) || other.gameTime == gameTime)&&(identical(other.gameAccessType, gameAccessType) || other.gameAccessType == gameAccessType)&&(identical(other.currentPlayersCount, currentPlayersCount) || other.currentPlayersCount == currentPlayersCount)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.venueId, venueId) || other.venueId == venueId)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.venueLatitude, venueLatitude) || other.venueLatitude == venueLatitude)&&(identical(other.venueLongitude, venueLongitude) || other.venueLongitude == venueLongitude)&&const DeepCollectionEquality().equals(other.playerIds, playerIds)&&const DeepCollectionEquality().equals(other.waitlistUserIds, waitlistUserIds)&&(identical(other.gameRules, gameRules) || other.gameRules == gameRules)&&(identical(other.equipmentRequired, equipmentRequired) || other.equipmentRequired == equipmentRequired)&&(identical(other.equipmentProvided, equipmentProvided) || other.equipmentProvided == equipmentProvided)&&(identical(other.requiresApproval, requiresApproval) || other.requiresApproval == requiresApproval)&&(identical(other.contactInformation, contactInformation) || other.contactInformation == contactInformation)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.venuePartnerId, venuePartnerId) || other.venuePartnerId == venuePartnerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,gameId,organiserUserId,sportId,areaOfGame,gameDate,gameTime,gameAccessType,currentPlayersCount,venueName,venueId,venueAddress,venueLatitude,venueLongitude,const DeepCollectionEquality().hash(playerIds),const DeepCollectionEquality().hash(waitlistUserIds),gameRules,equipmentRequired,equipmentProvided,requiresApproval,contactInformation,notes,viewCount,createdAt,updatedAt,venuePartnerId]);

@override
String toString() {
  return 'Game(gameId: $gameId, organiserUserId: $organiserUserId, sportId: $sportId, areaOfGame: $areaOfGame, gameDate: $gameDate, gameTime: $gameTime, gameAccessType: $gameAccessType, currentPlayersCount: $currentPlayersCount, venueName: $venueName, venueId: $venueId, venueAddress: $venueAddress, venueLatitude: $venueLatitude, venueLongitude: $venueLongitude, playerIds: $playerIds, waitlistUserIds: $waitlistUserIds, gameRules: $gameRules, equipmentRequired: $equipmentRequired, equipmentProvided: $equipmentProvided, requiresApproval: $requiresApproval, contactInformation: $contactInformation, notes: $notes, viewCount: $viewCount, createdAt: $createdAt, updatedAt: $updatedAt, venuePartnerId: $venuePartnerId)';
}


}

/// @nodoc
abstract mixin class $GameCopyWith<$Res>  {
  factory $GameCopyWith(Game value, $Res Function(Game) _then) = _$GameCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'game_id') String gameId,@JsonKey(name: 'organiser_user_id') String organiserUserId,@JsonKey(name: 'sport_id') String sportId,@JsonKey(name: 'area_of_game') String? areaOfGame,@JsonKey(name: 'game_date') DateTime? gameDate,@JsonKey(name: 'game_time') String? gameTime,@JsonKey(name: 'game_access_type') String? gameAccessType,@JsonKey(name: 'current_players_count') int? currentPlayersCount,@JsonKey(name: 'venue_name') String? venueName,@JsonKey(name: 'venue_id') String? venueId,@JsonKey(name: 'venue_address') String? venueAddress,@JsonKey(name: 'venue_latitude') double? venueLatitude,@JsonKey(name: 'venue_longitude') double? venueLongitude,@JsonKey(name: 'player_ids') List<String>? playerIds,@JsonKey(name: 'waitlist_user_ids') List<String>? waitlistUserIds,@JsonKey(name: 'game_rules') String? gameRules,@JsonKey(name: 'equipment_required') String? equipmentRequired,@JsonKey(name: 'equipment_provided') String? equipmentProvided,@JsonKey(name: 'requires_approval') bool requiresApproval,@JsonKey(name: 'contact_information') String? contactInformation, String? notes,@JsonKey(name: 'view_count') int viewCount,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'venue_partner_id') String? venuePartnerId
});




}
/// @nodoc
class _$GameCopyWithImpl<$Res>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._self, this._then);

  final Game _self;
  final $Res Function(Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gameId = null,Object? organiserUserId = null,Object? sportId = null,Object? areaOfGame = freezed,Object? gameDate = freezed,Object? gameTime = freezed,Object? gameAccessType = freezed,Object? currentPlayersCount = freezed,Object? venueName = freezed,Object? venueId = freezed,Object? venueAddress = freezed,Object? venueLatitude = freezed,Object? venueLongitude = freezed,Object? playerIds = freezed,Object? waitlistUserIds = freezed,Object? gameRules = freezed,Object? equipmentRequired = freezed,Object? equipmentProvided = freezed,Object? requiresApproval = null,Object? contactInformation = freezed,Object? notes = freezed,Object? viewCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? venuePartnerId = freezed,}) {
  return _then(_self.copyWith(
gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,organiserUserId: null == organiserUserId ? _self.organiserUserId : organiserUserId // ignore: cast_nullable_to_non_nullable
as String,sportId: null == sportId ? _self.sportId : sportId // ignore: cast_nullable_to_non_nullable
as String,areaOfGame: freezed == areaOfGame ? _self.areaOfGame : areaOfGame // ignore: cast_nullable_to_non_nullable
as String?,gameDate: freezed == gameDate ? _self.gameDate : gameDate // ignore: cast_nullable_to_non_nullable
as DateTime?,gameTime: freezed == gameTime ? _self.gameTime : gameTime // ignore: cast_nullable_to_non_nullable
as String?,gameAccessType: freezed == gameAccessType ? _self.gameAccessType : gameAccessType // ignore: cast_nullable_to_non_nullable
as String?,currentPlayersCount: freezed == currentPlayersCount ? _self.currentPlayersCount : currentPlayersCount // ignore: cast_nullable_to_non_nullable
as int?,venueName: freezed == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String?,venueId: freezed == venueId ? _self.venueId : venueId // ignore: cast_nullable_to_non_nullable
as String?,venueAddress: freezed == venueAddress ? _self.venueAddress : venueAddress // ignore: cast_nullable_to_non_nullable
as String?,venueLatitude: freezed == venueLatitude ? _self.venueLatitude : venueLatitude // ignore: cast_nullable_to_non_nullable
as double?,venueLongitude: freezed == venueLongitude ? _self.venueLongitude : venueLongitude // ignore: cast_nullable_to_non_nullable
as double?,playerIds: freezed == playerIds ? _self.playerIds : playerIds // ignore: cast_nullable_to_non_nullable
as List<String>?,waitlistUserIds: freezed == waitlistUserIds ? _self.waitlistUserIds : waitlistUserIds // ignore: cast_nullable_to_non_nullable
as List<String>?,gameRules: freezed == gameRules ? _self.gameRules : gameRules // ignore: cast_nullable_to_non_nullable
as String?,equipmentRequired: freezed == equipmentRequired ? _self.equipmentRequired : equipmentRequired // ignore: cast_nullable_to_non_nullable
as String?,equipmentProvided: freezed == equipmentProvided ? _self.equipmentProvided : equipmentProvided // ignore: cast_nullable_to_non_nullable
as String?,requiresApproval: null == requiresApproval ? _self.requiresApproval : requiresApproval // ignore: cast_nullable_to_non_nullable
as bool,contactInformation: freezed == contactInformation ? _self.contactInformation : contactInformation // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,venuePartnerId: freezed == venuePartnerId ? _self.venuePartnerId : venuePartnerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Game].
extension GamePatterns on Game {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Game value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Game() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Game value)  $default,){
final _that = this;
switch (_that) {
case _Game():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Game value)?  $default,){
final _that = this;
switch (_that) {
case _Game() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'game_id')  String gameId, @JsonKey(name: 'organiser_user_id')  String organiserUserId, @JsonKey(name: 'sport_id')  String sportId, @JsonKey(name: 'area_of_game')  String? areaOfGame, @JsonKey(name: 'game_date')  DateTime? gameDate, @JsonKey(name: 'game_time')  String? gameTime, @JsonKey(name: 'game_access_type')  String? gameAccessType, @JsonKey(name: 'current_players_count')  int? currentPlayersCount, @JsonKey(name: 'venue_name')  String? venueName, @JsonKey(name: 'venue_id')  String? venueId, @JsonKey(name: 'venue_address')  String? venueAddress, @JsonKey(name: 'venue_latitude')  double? venueLatitude, @JsonKey(name: 'venue_longitude')  double? venueLongitude, @JsonKey(name: 'player_ids')  List<String>? playerIds, @JsonKey(name: 'waitlist_user_ids')  List<String>? waitlistUserIds, @JsonKey(name: 'game_rules')  String? gameRules, @JsonKey(name: 'equipment_required')  String? equipmentRequired, @JsonKey(name: 'equipment_provided')  String? equipmentProvided, @JsonKey(name: 'requires_approval')  bool requiresApproval, @JsonKey(name: 'contact_information')  String? contactInformation,  String? notes, @JsonKey(name: 'view_count')  int viewCount, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'venue_partner_id')  String? venuePartnerId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.gameId,_that.organiserUserId,_that.sportId,_that.areaOfGame,_that.gameDate,_that.gameTime,_that.gameAccessType,_that.currentPlayersCount,_that.venueName,_that.venueId,_that.venueAddress,_that.venueLatitude,_that.venueLongitude,_that.playerIds,_that.waitlistUserIds,_that.gameRules,_that.equipmentRequired,_that.equipmentProvided,_that.requiresApproval,_that.contactInformation,_that.notes,_that.viewCount,_that.createdAt,_that.updatedAt,_that.venuePartnerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'game_id')  String gameId, @JsonKey(name: 'organiser_user_id')  String organiserUserId, @JsonKey(name: 'sport_id')  String sportId, @JsonKey(name: 'area_of_game')  String? areaOfGame, @JsonKey(name: 'game_date')  DateTime? gameDate, @JsonKey(name: 'game_time')  String? gameTime, @JsonKey(name: 'game_access_type')  String? gameAccessType, @JsonKey(name: 'current_players_count')  int? currentPlayersCount, @JsonKey(name: 'venue_name')  String? venueName, @JsonKey(name: 'venue_id')  String? venueId, @JsonKey(name: 'venue_address')  String? venueAddress, @JsonKey(name: 'venue_latitude')  double? venueLatitude, @JsonKey(name: 'venue_longitude')  double? venueLongitude, @JsonKey(name: 'player_ids')  List<String>? playerIds, @JsonKey(name: 'waitlist_user_ids')  List<String>? waitlistUserIds, @JsonKey(name: 'game_rules')  String? gameRules, @JsonKey(name: 'equipment_required')  String? equipmentRequired, @JsonKey(name: 'equipment_provided')  String? equipmentProvided, @JsonKey(name: 'requires_approval')  bool requiresApproval, @JsonKey(name: 'contact_information')  String? contactInformation,  String? notes, @JsonKey(name: 'view_count')  int viewCount, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'venue_partner_id')  String? venuePartnerId)  $default,) {final _that = this;
switch (_that) {
case _Game():
return $default(_that.gameId,_that.organiserUserId,_that.sportId,_that.areaOfGame,_that.gameDate,_that.gameTime,_that.gameAccessType,_that.currentPlayersCount,_that.venueName,_that.venueId,_that.venueAddress,_that.venueLatitude,_that.venueLongitude,_that.playerIds,_that.waitlistUserIds,_that.gameRules,_that.equipmentRequired,_that.equipmentProvided,_that.requiresApproval,_that.contactInformation,_that.notes,_that.viewCount,_that.createdAt,_that.updatedAt,_that.venuePartnerId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'game_id')  String gameId, @JsonKey(name: 'organiser_user_id')  String organiserUserId, @JsonKey(name: 'sport_id')  String sportId, @JsonKey(name: 'area_of_game')  String? areaOfGame, @JsonKey(name: 'game_date')  DateTime? gameDate, @JsonKey(name: 'game_time')  String? gameTime, @JsonKey(name: 'game_access_type')  String? gameAccessType, @JsonKey(name: 'current_players_count')  int? currentPlayersCount, @JsonKey(name: 'venue_name')  String? venueName, @JsonKey(name: 'venue_id')  String? venueId, @JsonKey(name: 'venue_address')  String? venueAddress, @JsonKey(name: 'venue_latitude')  double? venueLatitude, @JsonKey(name: 'venue_longitude')  double? venueLongitude, @JsonKey(name: 'player_ids')  List<String>? playerIds, @JsonKey(name: 'waitlist_user_ids')  List<String>? waitlistUserIds, @JsonKey(name: 'game_rules')  String? gameRules, @JsonKey(name: 'equipment_required')  String? equipmentRequired, @JsonKey(name: 'equipment_provided')  String? equipmentProvided, @JsonKey(name: 'requires_approval')  bool requiresApproval, @JsonKey(name: 'contact_information')  String? contactInformation,  String? notes, @JsonKey(name: 'view_count')  int viewCount, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt, @JsonKey(name: 'venue_partner_id')  String? venuePartnerId)?  $default,) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.gameId,_that.organiserUserId,_that.sportId,_that.areaOfGame,_that.gameDate,_that.gameTime,_that.gameAccessType,_that.currentPlayersCount,_that.venueName,_that.venueId,_that.venueAddress,_that.venueLatitude,_that.venueLongitude,_that.playerIds,_that.waitlistUserIds,_that.gameRules,_that.equipmentRequired,_that.equipmentProvided,_that.requiresApproval,_that.contactInformation,_that.notes,_that.viewCount,_that.createdAt,_that.updatedAt,_that.venuePartnerId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Game implements Game {
  const _Game({@JsonKey(name: 'game_id') required this.gameId, @JsonKey(name: 'organiser_user_id') required this.organiserUserId, @JsonKey(name: 'sport_id') required this.sportId, @JsonKey(name: 'area_of_game') this.areaOfGame, @JsonKey(name: 'game_date') this.gameDate, @JsonKey(name: 'game_time') this.gameTime, @JsonKey(name: 'game_access_type') this.gameAccessType, @JsonKey(name: 'current_players_count') this.currentPlayersCount, @JsonKey(name: 'venue_name') this.venueName, @JsonKey(name: 'venue_id') this.venueId, @JsonKey(name: 'venue_address') this.venueAddress, @JsonKey(name: 'venue_latitude') this.venueLatitude, @JsonKey(name: 'venue_longitude') this.venueLongitude, @JsonKey(name: 'player_ids') final  List<String>? playerIds, @JsonKey(name: 'waitlist_user_ids') final  List<String>? waitlistUserIds, @JsonKey(name: 'game_rules') this.gameRules, @JsonKey(name: 'equipment_required') this.equipmentRequired, @JsonKey(name: 'equipment_provided') this.equipmentProvided, @JsonKey(name: 'requires_approval') this.requiresApproval = false, @JsonKey(name: 'contact_information') this.contactInformation, this.notes, @JsonKey(name: 'view_count') this.viewCount = 0, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt, @JsonKey(name: 'venue_partner_id') this.venuePartnerId}): _playerIds = playerIds,_waitlistUserIds = waitlistUserIds;
  factory _Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

@override@JsonKey(name: 'game_id') final  String gameId;
@override@JsonKey(name: 'organiser_user_id') final  String organiserUserId;
@override@JsonKey(name: 'sport_id') final  String sportId;
@override@JsonKey(name: 'area_of_game') final  String? areaOfGame;
@override@JsonKey(name: 'game_date') final  DateTime? gameDate;
@override@JsonKey(name: 'game_time') final  String? gameTime;
// HH:mm:ss
@override@JsonKey(name: 'game_access_type') final  String? gameAccessType;
@override@JsonKey(name: 'current_players_count') final  int? currentPlayersCount;
@override@JsonKey(name: 'venue_name') final  String? venueName;
@override@JsonKey(name: 'venue_id') final  String? venueId;
@override@JsonKey(name: 'venue_address') final  String? venueAddress;
@override@JsonKey(name: 'venue_latitude') final  double? venueLatitude;
@override@JsonKey(name: 'venue_longitude') final  double? venueLongitude;
 final  List<String>? _playerIds;
@override@JsonKey(name: 'player_ids') List<String>? get playerIds {
  final value = _playerIds;
  if (value == null) return null;
  if (_playerIds is EqualUnmodifiableListView) return _playerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _waitlistUserIds;
@override@JsonKey(name: 'waitlist_user_ids') List<String>? get waitlistUserIds {
  final value = _waitlistUserIds;
  if (value == null) return null;
  if (_waitlistUserIds is EqualUnmodifiableListView) return _waitlistUserIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override@JsonKey(name: 'game_rules') final  String? gameRules;
@override@JsonKey(name: 'equipment_required') final  String? equipmentRequired;
@override@JsonKey(name: 'equipment_provided') final  String? equipmentProvided;
@override@JsonKey(name: 'requires_approval') final  bool requiresApproval;
@override@JsonKey(name: 'contact_information') final  String? contactInformation;
@override final  String? notes;
@override@JsonKey(name: 'view_count') final  int viewCount;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;
@override@JsonKey(name: 'venue_partner_id') final  String? venuePartnerId;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameCopyWith<_Game> get copyWith => __$GameCopyWithImpl<_Game>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Game&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.organiserUserId, organiserUserId) || other.organiserUserId == organiserUserId)&&(identical(other.sportId, sportId) || other.sportId == sportId)&&(identical(other.areaOfGame, areaOfGame) || other.areaOfGame == areaOfGame)&&(identical(other.gameDate, gameDate) || other.gameDate == gameDate)&&(identical(other.gameTime, gameTime) || other.gameTime == gameTime)&&(identical(other.gameAccessType, gameAccessType) || other.gameAccessType == gameAccessType)&&(identical(other.currentPlayersCount, currentPlayersCount) || other.currentPlayersCount == currentPlayersCount)&&(identical(other.venueName, venueName) || other.venueName == venueName)&&(identical(other.venueId, venueId) || other.venueId == venueId)&&(identical(other.venueAddress, venueAddress) || other.venueAddress == venueAddress)&&(identical(other.venueLatitude, venueLatitude) || other.venueLatitude == venueLatitude)&&(identical(other.venueLongitude, venueLongitude) || other.venueLongitude == venueLongitude)&&const DeepCollectionEquality().equals(other._playerIds, _playerIds)&&const DeepCollectionEquality().equals(other._waitlistUserIds, _waitlistUserIds)&&(identical(other.gameRules, gameRules) || other.gameRules == gameRules)&&(identical(other.equipmentRequired, equipmentRequired) || other.equipmentRequired == equipmentRequired)&&(identical(other.equipmentProvided, equipmentProvided) || other.equipmentProvided == equipmentProvided)&&(identical(other.requiresApproval, requiresApproval) || other.requiresApproval == requiresApproval)&&(identical(other.contactInformation, contactInformation) || other.contactInformation == contactInformation)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.viewCount, viewCount) || other.viewCount == viewCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.venuePartnerId, venuePartnerId) || other.venuePartnerId == venuePartnerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,gameId,organiserUserId,sportId,areaOfGame,gameDate,gameTime,gameAccessType,currentPlayersCount,venueName,venueId,venueAddress,venueLatitude,venueLongitude,const DeepCollectionEquality().hash(_playerIds),const DeepCollectionEquality().hash(_waitlistUserIds),gameRules,equipmentRequired,equipmentProvided,requiresApproval,contactInformation,notes,viewCount,createdAt,updatedAt,venuePartnerId]);

@override
String toString() {
  return 'Game(gameId: $gameId, organiserUserId: $organiserUserId, sportId: $sportId, areaOfGame: $areaOfGame, gameDate: $gameDate, gameTime: $gameTime, gameAccessType: $gameAccessType, currentPlayersCount: $currentPlayersCount, venueName: $venueName, venueId: $venueId, venueAddress: $venueAddress, venueLatitude: $venueLatitude, venueLongitude: $venueLongitude, playerIds: $playerIds, waitlistUserIds: $waitlistUserIds, gameRules: $gameRules, equipmentRequired: $equipmentRequired, equipmentProvided: $equipmentProvided, requiresApproval: $requiresApproval, contactInformation: $contactInformation, notes: $notes, viewCount: $viewCount, createdAt: $createdAt, updatedAt: $updatedAt, venuePartnerId: $venuePartnerId)';
}


}

/// @nodoc
abstract mixin class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) _then) = __$GameCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'game_id') String gameId,@JsonKey(name: 'organiser_user_id') String organiserUserId,@JsonKey(name: 'sport_id') String sportId,@JsonKey(name: 'area_of_game') String? areaOfGame,@JsonKey(name: 'game_date') DateTime? gameDate,@JsonKey(name: 'game_time') String? gameTime,@JsonKey(name: 'game_access_type') String? gameAccessType,@JsonKey(name: 'current_players_count') int? currentPlayersCount,@JsonKey(name: 'venue_name') String? venueName,@JsonKey(name: 'venue_id') String? venueId,@JsonKey(name: 'venue_address') String? venueAddress,@JsonKey(name: 'venue_latitude') double? venueLatitude,@JsonKey(name: 'venue_longitude') double? venueLongitude,@JsonKey(name: 'player_ids') List<String>? playerIds,@JsonKey(name: 'waitlist_user_ids') List<String>? waitlistUserIds,@JsonKey(name: 'game_rules') String? gameRules,@JsonKey(name: 'equipment_required') String? equipmentRequired,@JsonKey(name: 'equipment_provided') String? equipmentProvided,@JsonKey(name: 'requires_approval') bool requiresApproval,@JsonKey(name: 'contact_information') String? contactInformation, String? notes,@JsonKey(name: 'view_count') int viewCount,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt,@JsonKey(name: 'venue_partner_id') String? venuePartnerId
});




}
/// @nodoc
class __$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(this._self, this._then);

  final _Game _self;
  final $Res Function(_Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gameId = null,Object? organiserUserId = null,Object? sportId = null,Object? areaOfGame = freezed,Object? gameDate = freezed,Object? gameTime = freezed,Object? gameAccessType = freezed,Object? currentPlayersCount = freezed,Object? venueName = freezed,Object? venueId = freezed,Object? venueAddress = freezed,Object? venueLatitude = freezed,Object? venueLongitude = freezed,Object? playerIds = freezed,Object? waitlistUserIds = freezed,Object? gameRules = freezed,Object? equipmentRequired = freezed,Object? equipmentProvided = freezed,Object? requiresApproval = null,Object? contactInformation = freezed,Object? notes = freezed,Object? viewCount = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? venuePartnerId = freezed,}) {
  return _then(_Game(
gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,organiserUserId: null == organiserUserId ? _self.organiserUserId : organiserUserId // ignore: cast_nullable_to_non_nullable
as String,sportId: null == sportId ? _self.sportId : sportId // ignore: cast_nullable_to_non_nullable
as String,areaOfGame: freezed == areaOfGame ? _self.areaOfGame : areaOfGame // ignore: cast_nullable_to_non_nullable
as String?,gameDate: freezed == gameDate ? _self.gameDate : gameDate // ignore: cast_nullable_to_non_nullable
as DateTime?,gameTime: freezed == gameTime ? _self.gameTime : gameTime // ignore: cast_nullable_to_non_nullable
as String?,gameAccessType: freezed == gameAccessType ? _self.gameAccessType : gameAccessType // ignore: cast_nullable_to_non_nullable
as String?,currentPlayersCount: freezed == currentPlayersCount ? _self.currentPlayersCount : currentPlayersCount // ignore: cast_nullable_to_non_nullable
as int?,venueName: freezed == venueName ? _self.venueName : venueName // ignore: cast_nullable_to_non_nullable
as String?,venueId: freezed == venueId ? _self.venueId : venueId // ignore: cast_nullable_to_non_nullable
as String?,venueAddress: freezed == venueAddress ? _self.venueAddress : venueAddress // ignore: cast_nullable_to_non_nullable
as String?,venueLatitude: freezed == venueLatitude ? _self.venueLatitude : venueLatitude // ignore: cast_nullable_to_non_nullable
as double?,venueLongitude: freezed == venueLongitude ? _self.venueLongitude : venueLongitude // ignore: cast_nullable_to_non_nullable
as double?,playerIds: freezed == playerIds ? _self._playerIds : playerIds // ignore: cast_nullable_to_non_nullable
as List<String>?,waitlistUserIds: freezed == waitlistUserIds ? _self._waitlistUserIds : waitlistUserIds // ignore: cast_nullable_to_non_nullable
as List<String>?,gameRules: freezed == gameRules ? _self.gameRules : gameRules // ignore: cast_nullable_to_non_nullable
as String?,equipmentRequired: freezed == equipmentRequired ? _self.equipmentRequired : equipmentRequired // ignore: cast_nullable_to_non_nullable
as String?,equipmentProvided: freezed == equipmentProvided ? _self.equipmentProvided : equipmentProvided // ignore: cast_nullable_to_non_nullable
as String?,requiresApproval: null == requiresApproval ? _self.requiresApproval : requiresApproval // ignore: cast_nullable_to_non_nullable
as bool,contactInformation: freezed == contactInformation ? _self.contactInformation : contactInformation // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,viewCount: null == viewCount ? _self.viewCount : viewCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,venuePartnerId: freezed == venuePartnerId ? _self.venuePartnerId : venuePartnerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GameInvite {

@JsonKey(name: 'invite_id') String get inviteId;@JsonKey(name: 'game_id') String get gameId;@JsonKey(name: 'inviter_user_id') String get inviterUserId;@JsonKey(name: 'invitee_user_id') String get inviteeUserId;@JsonKey(name: 'invite_status') String? get inviteStatus;// Pending, Accepted, Rejected, Expired
@JsonKey(name: 'sent_at') DateTime? get sentAt;@JsonKey(name: 'responded_at') DateTime? get respondedAt;@JsonKey(name: 'expires_at') DateTime? get expiresAt;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of GameInvite
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameInviteCopyWith<GameInvite> get copyWith => _$GameInviteCopyWithImpl<GameInvite>(this as GameInvite, _$identity);

  /// Serializes this GameInvite to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameInvite&&(identical(other.inviteId, inviteId) || other.inviteId == inviteId)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.inviterUserId, inviterUserId) || other.inviterUserId == inviterUserId)&&(identical(other.inviteeUserId, inviteeUserId) || other.inviteeUserId == inviteeUserId)&&(identical(other.inviteStatus, inviteStatus) || other.inviteStatus == inviteStatus)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inviteId,gameId,inviterUserId,inviteeUserId,inviteStatus,sentAt,respondedAt,expiresAt,createdAt,updatedAt);

@override
String toString() {
  return 'GameInvite(inviteId: $inviteId, gameId: $gameId, inviterUserId: $inviterUserId, inviteeUserId: $inviteeUserId, inviteStatus: $inviteStatus, sentAt: $sentAt, respondedAt: $respondedAt, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GameInviteCopyWith<$Res>  {
  factory $GameInviteCopyWith(GameInvite value, $Res Function(GameInvite) _then) = _$GameInviteCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'invite_id') String inviteId,@JsonKey(name: 'game_id') String gameId,@JsonKey(name: 'inviter_user_id') String inviterUserId,@JsonKey(name: 'invitee_user_id') String inviteeUserId,@JsonKey(name: 'invite_status') String? inviteStatus,@JsonKey(name: 'sent_at') DateTime? sentAt,@JsonKey(name: 'responded_at') DateTime? respondedAt,@JsonKey(name: 'expires_at') DateTime? expiresAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$GameInviteCopyWithImpl<$Res>
    implements $GameInviteCopyWith<$Res> {
  _$GameInviteCopyWithImpl(this._self, this._then);

  final GameInvite _self;
  final $Res Function(GameInvite) _then;

/// Create a copy of GameInvite
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inviteId = null,Object? gameId = null,Object? inviterUserId = null,Object? inviteeUserId = null,Object? inviteStatus = freezed,Object? sentAt = freezed,Object? respondedAt = freezed,Object? expiresAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
inviteId: null == inviteId ? _self.inviteId : inviteId // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,inviterUserId: null == inviterUserId ? _self.inviterUserId : inviterUserId // ignore: cast_nullable_to_non_nullable
as String,inviteeUserId: null == inviteeUserId ? _self.inviteeUserId : inviteeUserId // ignore: cast_nullable_to_non_nullable
as String,inviteStatus: freezed == inviteStatus ? _self.inviteStatus : inviteStatus // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameInvite].
extension GameInvitePatterns on GameInvite {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameInvite value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameInvite() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameInvite value)  $default,){
final _that = this;
switch (_that) {
case _GameInvite():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameInvite value)?  $default,){
final _that = this;
switch (_that) {
case _GameInvite() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'invite_id')  String inviteId, @JsonKey(name: 'game_id')  String gameId, @JsonKey(name: 'inviter_user_id')  String inviterUserId, @JsonKey(name: 'invitee_user_id')  String inviteeUserId, @JsonKey(name: 'invite_status')  String? inviteStatus, @JsonKey(name: 'sent_at')  DateTime? sentAt, @JsonKey(name: 'responded_at')  DateTime? respondedAt, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameInvite() when $default != null:
return $default(_that.inviteId,_that.gameId,_that.inviterUserId,_that.inviteeUserId,_that.inviteStatus,_that.sentAt,_that.respondedAt,_that.expiresAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'invite_id')  String inviteId, @JsonKey(name: 'game_id')  String gameId, @JsonKey(name: 'inviter_user_id')  String inviterUserId, @JsonKey(name: 'invitee_user_id')  String inviteeUserId, @JsonKey(name: 'invite_status')  String? inviteStatus, @JsonKey(name: 'sent_at')  DateTime? sentAt, @JsonKey(name: 'responded_at')  DateTime? respondedAt, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _GameInvite():
return $default(_that.inviteId,_that.gameId,_that.inviterUserId,_that.inviteeUserId,_that.inviteStatus,_that.sentAt,_that.respondedAt,_that.expiresAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'invite_id')  String inviteId, @JsonKey(name: 'game_id')  String gameId, @JsonKey(name: 'inviter_user_id')  String inviterUserId, @JsonKey(name: 'invitee_user_id')  String inviteeUserId, @JsonKey(name: 'invite_status')  String? inviteStatus, @JsonKey(name: 'sent_at')  DateTime? sentAt, @JsonKey(name: 'responded_at')  DateTime? respondedAt, @JsonKey(name: 'expires_at')  DateTime? expiresAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _GameInvite() when $default != null:
return $default(_that.inviteId,_that.gameId,_that.inviterUserId,_that.inviteeUserId,_that.inviteStatus,_that.sentAt,_that.respondedAt,_that.expiresAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameInvite implements GameInvite {
  const _GameInvite({@JsonKey(name: 'invite_id') required this.inviteId, @JsonKey(name: 'game_id') required this.gameId, @JsonKey(name: 'inviter_user_id') required this.inviterUserId, @JsonKey(name: 'invitee_user_id') required this.inviteeUserId, @JsonKey(name: 'invite_status') this.inviteStatus, @JsonKey(name: 'sent_at') this.sentAt, @JsonKey(name: 'responded_at') this.respondedAt, @JsonKey(name: 'expires_at') this.expiresAt, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _GameInvite.fromJson(Map<String, dynamic> json) => _$GameInviteFromJson(json);

@override@JsonKey(name: 'invite_id') final  String inviteId;
@override@JsonKey(name: 'game_id') final  String gameId;
@override@JsonKey(name: 'inviter_user_id') final  String inviterUserId;
@override@JsonKey(name: 'invitee_user_id') final  String inviteeUserId;
@override@JsonKey(name: 'invite_status') final  String? inviteStatus;
// Pending, Accepted, Rejected, Expired
@override@JsonKey(name: 'sent_at') final  DateTime? sentAt;
@override@JsonKey(name: 'responded_at') final  DateTime? respondedAt;
@override@JsonKey(name: 'expires_at') final  DateTime? expiresAt;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of GameInvite
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameInviteCopyWith<_GameInvite> get copyWith => __$GameInviteCopyWithImpl<_GameInvite>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameInviteToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameInvite&&(identical(other.inviteId, inviteId) || other.inviteId == inviteId)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.inviterUserId, inviterUserId) || other.inviterUserId == inviterUserId)&&(identical(other.inviteeUserId, inviteeUserId) || other.inviteeUserId == inviteeUserId)&&(identical(other.inviteStatus, inviteStatus) || other.inviteStatus == inviteStatus)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inviteId,gameId,inviterUserId,inviteeUserId,inviteStatus,sentAt,respondedAt,expiresAt,createdAt,updatedAt);

@override
String toString() {
  return 'GameInvite(inviteId: $inviteId, gameId: $gameId, inviterUserId: $inviterUserId, inviteeUserId: $inviteeUserId, inviteStatus: $inviteStatus, sentAt: $sentAt, respondedAt: $respondedAt, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GameInviteCopyWith<$Res> implements $GameInviteCopyWith<$Res> {
  factory _$GameInviteCopyWith(_GameInvite value, $Res Function(_GameInvite) _then) = __$GameInviteCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'invite_id') String inviteId,@JsonKey(name: 'game_id') String gameId,@JsonKey(name: 'inviter_user_id') String inviterUserId,@JsonKey(name: 'invitee_user_id') String inviteeUserId,@JsonKey(name: 'invite_status') String? inviteStatus,@JsonKey(name: 'sent_at') DateTime? sentAt,@JsonKey(name: 'responded_at') DateTime? respondedAt,@JsonKey(name: 'expires_at') DateTime? expiresAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$GameInviteCopyWithImpl<$Res>
    implements _$GameInviteCopyWith<$Res> {
  __$GameInviteCopyWithImpl(this._self, this._then);

  final _GameInvite _self;
  final $Res Function(_GameInvite) _then;

/// Create a copy of GameInvite
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inviteId = null,Object? gameId = null,Object? inviterUserId = null,Object? inviteeUserId = null,Object? inviteStatus = freezed,Object? sentAt = freezed,Object? respondedAt = freezed,Object? expiresAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_GameInvite(
inviteId: null == inviteId ? _self.inviteId : inviteId // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,inviterUserId: null == inviterUserId ? _self.inviterUserId : inviterUserId // ignore: cast_nullable_to_non_nullable
as String,inviteeUserId: null == inviteeUserId ? _self.inviteeUserId : inviteeUserId // ignore: cast_nullable_to_non_nullable
as String,inviteStatus: freezed == inviteStatus ? _self.inviteStatus : inviteStatus // ignore: cast_nullable_to_non_nullable
as String?,sentAt: freezed == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$GameParticipation {

@JsonKey(name: 'participation_id') String get participationId;@JsonKey(name: 'game_id') String get gameId;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'participation_status') String? get participationStatus;// Joined, Waitlisted, Cancelled
@JsonKey(name: 'joined_at') DateTime? get joinedAt;@JsonKey(name: 'is_organiser') bool get isOrganiser;@JsonKey(name: 'has_paid') bool get hasPaid;@JsonKey(name: 'paid_at') DateTime? get paidAt;@JsonKey(name: 'left_at') DateTime? get leftAt;@JsonKey(name: 'created_at') DateTime? get createdAt;@JsonKey(name: 'updated_at') DateTime? get updatedAt;
/// Create a copy of GameParticipation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameParticipationCopyWith<GameParticipation> get copyWith => _$GameParticipationCopyWithImpl<GameParticipation>(this as GameParticipation, _$identity);

  /// Serializes this GameParticipation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameParticipation&&(identical(other.participationId, participationId) || other.participationId == participationId)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.participationStatus, participationStatus) || other.participationStatus == participationStatus)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.isOrganiser, isOrganiser) || other.isOrganiser == isOrganiser)&&(identical(other.hasPaid, hasPaid) || other.hasPaid == hasPaid)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.leftAt, leftAt) || other.leftAt == leftAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,participationId,gameId,userId,participationStatus,joinedAt,isOrganiser,hasPaid,paidAt,leftAt,createdAt,updatedAt);

@override
String toString() {
  return 'GameParticipation(participationId: $participationId, gameId: $gameId, userId: $userId, participationStatus: $participationStatus, joinedAt: $joinedAt, isOrganiser: $isOrganiser, hasPaid: $hasPaid, paidAt: $paidAt, leftAt: $leftAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $GameParticipationCopyWith<$Res>  {
  factory $GameParticipationCopyWith(GameParticipation value, $Res Function(GameParticipation) _then) = _$GameParticipationCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'participation_id') String participationId,@JsonKey(name: 'game_id') String gameId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'participation_status') String? participationStatus,@JsonKey(name: 'joined_at') DateTime? joinedAt,@JsonKey(name: 'is_organiser') bool isOrganiser,@JsonKey(name: 'has_paid') bool hasPaid,@JsonKey(name: 'paid_at') DateTime? paidAt,@JsonKey(name: 'left_at') DateTime? leftAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class _$GameParticipationCopyWithImpl<$Res>
    implements $GameParticipationCopyWith<$Res> {
  _$GameParticipationCopyWithImpl(this._self, this._then);

  final GameParticipation _self;
  final $Res Function(GameParticipation) _then;

/// Create a copy of GameParticipation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? participationId = null,Object? gameId = null,Object? userId = null,Object? participationStatus = freezed,Object? joinedAt = freezed,Object? isOrganiser = null,Object? hasPaid = null,Object? paidAt = freezed,Object? leftAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
participationId: null == participationId ? _self.participationId : participationId // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,participationStatus: freezed == participationStatus ? _self.participationStatus : participationStatus // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isOrganiser: null == isOrganiser ? _self.isOrganiser : isOrganiser // ignore: cast_nullable_to_non_nullable
as bool,hasPaid: null == hasPaid ? _self.hasPaid : hasPaid // ignore: cast_nullable_to_non_nullable
as bool,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,leftAt: freezed == leftAt ? _self.leftAt : leftAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameParticipation].
extension GameParticipationPatterns on GameParticipation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameParticipation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameParticipation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameParticipation value)  $default,){
final _that = this;
switch (_that) {
case _GameParticipation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameParticipation value)?  $default,){
final _that = this;
switch (_that) {
case _GameParticipation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'participation_id')  String participationId, @JsonKey(name: 'game_id')  String gameId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'participation_status')  String? participationStatus, @JsonKey(name: 'joined_at')  DateTime? joinedAt, @JsonKey(name: 'is_organiser')  bool isOrganiser, @JsonKey(name: 'has_paid')  bool hasPaid, @JsonKey(name: 'paid_at')  DateTime? paidAt, @JsonKey(name: 'left_at')  DateTime? leftAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameParticipation() when $default != null:
return $default(_that.participationId,_that.gameId,_that.userId,_that.participationStatus,_that.joinedAt,_that.isOrganiser,_that.hasPaid,_that.paidAt,_that.leftAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'participation_id')  String participationId, @JsonKey(name: 'game_id')  String gameId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'participation_status')  String? participationStatus, @JsonKey(name: 'joined_at')  DateTime? joinedAt, @JsonKey(name: 'is_organiser')  bool isOrganiser, @JsonKey(name: 'has_paid')  bool hasPaid, @JsonKey(name: 'paid_at')  DateTime? paidAt, @JsonKey(name: 'left_at')  DateTime? leftAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _GameParticipation():
return $default(_that.participationId,_that.gameId,_that.userId,_that.participationStatus,_that.joinedAt,_that.isOrganiser,_that.hasPaid,_that.paidAt,_that.leftAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'participation_id')  String participationId, @JsonKey(name: 'game_id')  String gameId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'participation_status')  String? participationStatus, @JsonKey(name: 'joined_at')  DateTime? joinedAt, @JsonKey(name: 'is_organiser')  bool isOrganiser, @JsonKey(name: 'has_paid')  bool hasPaid, @JsonKey(name: 'paid_at')  DateTime? paidAt, @JsonKey(name: 'left_at')  DateTime? leftAt, @JsonKey(name: 'created_at')  DateTime? createdAt, @JsonKey(name: 'updated_at')  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _GameParticipation() when $default != null:
return $default(_that.participationId,_that.gameId,_that.userId,_that.participationStatus,_that.joinedAt,_that.isOrganiser,_that.hasPaid,_that.paidAt,_that.leftAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameParticipation implements GameParticipation {
  const _GameParticipation({@JsonKey(name: 'participation_id') required this.participationId, @JsonKey(name: 'game_id') required this.gameId, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'participation_status') this.participationStatus, @JsonKey(name: 'joined_at') this.joinedAt, @JsonKey(name: 'is_organiser') this.isOrganiser = false, @JsonKey(name: 'has_paid') this.hasPaid = false, @JsonKey(name: 'paid_at') this.paidAt, @JsonKey(name: 'left_at') this.leftAt, @JsonKey(name: 'created_at') this.createdAt, @JsonKey(name: 'updated_at') this.updatedAt});
  factory _GameParticipation.fromJson(Map<String, dynamic> json) => _$GameParticipationFromJson(json);

@override@JsonKey(name: 'participation_id') final  String participationId;
@override@JsonKey(name: 'game_id') final  String gameId;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'participation_status') final  String? participationStatus;
// Joined, Waitlisted, Cancelled
@override@JsonKey(name: 'joined_at') final  DateTime? joinedAt;
@override@JsonKey(name: 'is_organiser') final  bool isOrganiser;
@override@JsonKey(name: 'has_paid') final  bool hasPaid;
@override@JsonKey(name: 'paid_at') final  DateTime? paidAt;
@override@JsonKey(name: 'left_at') final  DateTime? leftAt;
@override@JsonKey(name: 'created_at') final  DateTime? createdAt;
@override@JsonKey(name: 'updated_at') final  DateTime? updatedAt;

/// Create a copy of GameParticipation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameParticipationCopyWith<_GameParticipation> get copyWith => __$GameParticipationCopyWithImpl<_GameParticipation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameParticipationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameParticipation&&(identical(other.participationId, participationId) || other.participationId == participationId)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.participationStatus, participationStatus) || other.participationStatus == participationStatus)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.isOrganiser, isOrganiser) || other.isOrganiser == isOrganiser)&&(identical(other.hasPaid, hasPaid) || other.hasPaid == hasPaid)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt)&&(identical(other.leftAt, leftAt) || other.leftAt == leftAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,participationId,gameId,userId,participationStatus,joinedAt,isOrganiser,hasPaid,paidAt,leftAt,createdAt,updatedAt);

@override
String toString() {
  return 'GameParticipation(participationId: $participationId, gameId: $gameId, userId: $userId, participationStatus: $participationStatus, joinedAt: $joinedAt, isOrganiser: $isOrganiser, hasPaid: $hasPaid, paidAt: $paidAt, leftAt: $leftAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$GameParticipationCopyWith<$Res> implements $GameParticipationCopyWith<$Res> {
  factory _$GameParticipationCopyWith(_GameParticipation value, $Res Function(_GameParticipation) _then) = __$GameParticipationCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'participation_id') String participationId,@JsonKey(name: 'game_id') String gameId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'participation_status') String? participationStatus,@JsonKey(name: 'joined_at') DateTime? joinedAt,@JsonKey(name: 'is_organiser') bool isOrganiser,@JsonKey(name: 'has_paid') bool hasPaid,@JsonKey(name: 'paid_at') DateTime? paidAt,@JsonKey(name: 'left_at') DateTime? leftAt,@JsonKey(name: 'created_at') DateTime? createdAt,@JsonKey(name: 'updated_at') DateTime? updatedAt
});




}
/// @nodoc
class __$GameParticipationCopyWithImpl<$Res>
    implements _$GameParticipationCopyWith<$Res> {
  __$GameParticipationCopyWithImpl(this._self, this._then);

  final _GameParticipation _self;
  final $Res Function(_GameParticipation) _then;

/// Create a copy of GameParticipation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? participationId = null,Object? gameId = null,Object? userId = null,Object? participationStatus = freezed,Object? joinedAt = freezed,Object? isOrganiser = null,Object? hasPaid = null,Object? paidAt = freezed,Object? leftAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_GameParticipation(
participationId: null == participationId ? _self.participationId : participationId // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,participationStatus: freezed == participationStatus ? _self.participationStatus : participationStatus // ignore: cast_nullable_to_non_nullable
as String?,joinedAt: freezed == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isOrganiser: null == isOrganiser ? _self.isOrganiser : isOrganiser // ignore: cast_nullable_to_non_nullable
as bool,hasPaid: null == hasPaid ? _self.hasPaid : hasPaid // ignore: cast_nullable_to_non_nullable
as bool,paidAt: freezed == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as DateTime?,leftAt: freezed == leftAt ? _self.leftAt : leftAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
