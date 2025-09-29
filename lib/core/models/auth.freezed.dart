// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthSession {

 String get id; String get userId; String get accessToken; String? get refreshToken; DateTime get expiresAt; String? get deviceId; String? get deviceName; String? get ipAddress; String? get userAgent; bool get isActive; DateTime? get lastUsedAt; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSessionCopyWith<AuthSession> get copyWith => _$AuthSessionCopyWithImpl<AuthSession>(this as AuthSession, _$identity);

  /// Serializes this AuthSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accessToken,refreshToken,expiresAt,deviceId,deviceName,ipAddress,userAgent,isActive,lastUsedAt,createdAt,updatedAt);

@override
String toString() {
  return 'AuthSession(id: $id, userId: $userId, accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt, deviceId: $deviceId, deviceName: $deviceName, ipAddress: $ipAddress, userAgent: $userAgent, isActive: $isActive, lastUsedAt: $lastUsedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AuthSessionCopyWith<$Res>  {
  factory $AuthSessionCopyWith(AuthSession value, $Res Function(AuthSession) _then) = _$AuthSessionCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String accessToken, String? refreshToken, DateTime expiresAt, String? deviceId, String? deviceName, String? ipAddress, String? userAgent, bool isActive, DateTime? lastUsedAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$AuthSessionCopyWithImpl<$Res>
    implements $AuthSessionCopyWith<$Res> {
  _$AuthSessionCopyWithImpl(this._self, this._then);

  final AuthSession _self;
  final $Res Function(AuthSession) _then;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? accessToken = null,Object? refreshToken = freezed,Object? expiresAt = null,Object? deviceId = freezed,Object? deviceName = freezed,Object? ipAddress = freezed,Object? userAgent = freezed,Object? isActive = null,Object? lastUsedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,deviceName: freezed == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthSession].
extension AuthSessionPatterns on AuthSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthSession value)  $default,){
final _that = this;
switch (_that) {
case _AuthSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthSession value)?  $default,){
final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String accessToken,  String? refreshToken,  DateTime expiresAt,  String? deviceId,  String? deviceName,  String? ipAddress,  String? userAgent,  bool isActive,  DateTime? lastUsedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
return $default(_that.id,_that.userId,_that.accessToken,_that.refreshToken,_that.expiresAt,_that.deviceId,_that.deviceName,_that.ipAddress,_that.userAgent,_that.isActive,_that.lastUsedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String accessToken,  String? refreshToken,  DateTime expiresAt,  String? deviceId,  String? deviceName,  String? ipAddress,  String? userAgent,  bool isActive,  DateTime? lastUsedAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AuthSession():
return $default(_that.id,_that.userId,_that.accessToken,_that.refreshToken,_that.expiresAt,_that.deviceId,_that.deviceName,_that.ipAddress,_that.userAgent,_that.isActive,_that.lastUsedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String accessToken,  String? refreshToken,  DateTime expiresAt,  String? deviceId,  String? deviceName,  String? ipAddress,  String? userAgent,  bool isActive,  DateTime? lastUsedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AuthSession() when $default != null:
return $default(_that.id,_that.userId,_that.accessToken,_that.refreshToken,_that.expiresAt,_that.deviceId,_that.deviceName,_that.ipAddress,_that.userAgent,_that.isActive,_that.lastUsedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthSession implements AuthSession {
  const _AuthSession({required this.id, required this.userId, required this.accessToken, this.refreshToken, required this.expiresAt, this.deviceId, this.deviceName, this.ipAddress, this.userAgent, this.isActive = true, this.lastUsedAt, this.createdAt, this.updatedAt});
  factory _AuthSession.fromJson(Map<String, dynamic> json) => _$AuthSessionFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String accessToken;
@override final  String? refreshToken;
@override final  DateTime expiresAt;
@override final  String? deviceId;
@override final  String? deviceName;
@override final  String? ipAddress;
@override final  String? userAgent;
@override@JsonKey() final  bool isActive;
@override final  DateTime? lastUsedAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthSessionCopyWith<_AuthSession> get copyWith => __$AuthSessionCopyWithImpl<_AuthSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthSession&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.deviceName, deviceName) || other.deviceName == deviceName)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,accessToken,refreshToken,expiresAt,deviceId,deviceName,ipAddress,userAgent,isActive,lastUsedAt,createdAt,updatedAt);

@override
String toString() {
  return 'AuthSession(id: $id, userId: $userId, accessToken: $accessToken, refreshToken: $refreshToken, expiresAt: $expiresAt, deviceId: $deviceId, deviceName: $deviceName, ipAddress: $ipAddress, userAgent: $userAgent, isActive: $isActive, lastUsedAt: $lastUsedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AuthSessionCopyWith<$Res> implements $AuthSessionCopyWith<$Res> {
  factory _$AuthSessionCopyWith(_AuthSession value, $Res Function(_AuthSession) _then) = __$AuthSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String accessToken, String? refreshToken, DateTime expiresAt, String? deviceId, String? deviceName, String? ipAddress, String? userAgent, bool isActive, DateTime? lastUsedAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$AuthSessionCopyWithImpl<$Res>
    implements _$AuthSessionCopyWith<$Res> {
  __$AuthSessionCopyWithImpl(this._self, this._then);

  final _AuthSession _self;
  final $Res Function(_AuthSession) _then;

/// Create a copy of AuthSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? accessToken = null,Object? refreshToken = freezed,Object? expiresAt = null,Object? deviceId = freezed,Object? deviceName = freezed,Object? ipAddress = freezed,Object? userAgent = freezed,Object? isActive = null,Object? lastUsedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_AuthSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,deviceName: freezed == deviceName ? _self.deviceName : deviceName // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$OTPVerification {

 String get id; String? get phone; String? get email; String get otpCode; OTPType get type; bool get isUsed; DateTime get expiresAt; int get attemptCount; int get maxAttempts; DateTime? get verifiedAt; String? get deviceId; String? get ipAddress; DateTime? get createdAt;
/// Create a copy of OTPVerification
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OTPVerificationCopyWith<OTPVerification> get copyWith => _$OTPVerificationCopyWithImpl<OTPVerification>(this as OTPVerification, _$identity);

  /// Serializes this OTPVerification to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OTPVerification&&(identical(other.id, id) || other.id == id)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode)&&(identical(other.type, type) || other.type == type)&&(identical(other.isUsed, isUsed) || other.isUsed == isUsed)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount)&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phone,email,otpCode,type,isUsed,expiresAt,attemptCount,maxAttempts,verifiedAt,deviceId,ipAddress,createdAt);

@override
String toString() {
  return 'OTPVerification(id: $id, phone: $phone, email: $email, otpCode: $otpCode, type: $type, isUsed: $isUsed, expiresAt: $expiresAt, attemptCount: $attemptCount, maxAttempts: $maxAttempts, verifiedAt: $verifiedAt, deviceId: $deviceId, ipAddress: $ipAddress, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $OTPVerificationCopyWith<$Res>  {
  factory $OTPVerificationCopyWith(OTPVerification value, $Res Function(OTPVerification) _then) = _$OTPVerificationCopyWithImpl;
@useResult
$Res call({
 String id, String? phone, String? email, String otpCode, OTPType type, bool isUsed, DateTime expiresAt, int attemptCount, int maxAttempts, DateTime? verifiedAt, String? deviceId, String? ipAddress, DateTime? createdAt
});




}
/// @nodoc
class _$OTPVerificationCopyWithImpl<$Res>
    implements $OTPVerificationCopyWith<$Res> {
  _$OTPVerificationCopyWithImpl(this._self, this._then);

  final OTPVerification _self;
  final $Res Function(OTPVerification) _then;

/// Create a copy of OTPVerification
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? phone = freezed,Object? email = freezed,Object? otpCode = null,Object? type = null,Object? isUsed = null,Object? expiresAt = null,Object? attemptCount = null,Object? maxAttempts = null,Object? verifiedAt = freezed,Object? deviceId = freezed,Object? ipAddress = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OTPType,isUsed: null == isUsed ? _self.isUsed : isUsed // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [OTPVerification].
extension OTPVerificationPatterns on OTPVerification {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OTPVerification value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OTPVerification() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OTPVerification value)  $default,){
final _that = this;
switch (_that) {
case _OTPVerification():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OTPVerification value)?  $default,){
final _that = this;
switch (_that) {
case _OTPVerification() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? phone,  String? email,  String otpCode,  OTPType type,  bool isUsed,  DateTime expiresAt,  int attemptCount,  int maxAttempts,  DateTime? verifiedAt,  String? deviceId,  String? ipAddress,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OTPVerification() when $default != null:
return $default(_that.id,_that.phone,_that.email,_that.otpCode,_that.type,_that.isUsed,_that.expiresAt,_that.attemptCount,_that.maxAttempts,_that.verifiedAt,_that.deviceId,_that.ipAddress,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? phone,  String? email,  String otpCode,  OTPType type,  bool isUsed,  DateTime expiresAt,  int attemptCount,  int maxAttempts,  DateTime? verifiedAt,  String? deviceId,  String? ipAddress,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _OTPVerification():
return $default(_that.id,_that.phone,_that.email,_that.otpCode,_that.type,_that.isUsed,_that.expiresAt,_that.attemptCount,_that.maxAttempts,_that.verifiedAt,_that.deviceId,_that.ipAddress,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? phone,  String? email,  String otpCode,  OTPType type,  bool isUsed,  DateTime expiresAt,  int attemptCount,  int maxAttempts,  DateTime? verifiedAt,  String? deviceId,  String? ipAddress,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _OTPVerification() when $default != null:
return $default(_that.id,_that.phone,_that.email,_that.otpCode,_that.type,_that.isUsed,_that.expiresAt,_that.attemptCount,_that.maxAttempts,_that.verifiedAt,_that.deviceId,_that.ipAddress,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OTPVerification implements OTPVerification {
  const _OTPVerification({required this.id, this.phone, this.email, required this.otpCode, required this.type, this.isUsed = false, required this.expiresAt, this.attemptCount = 0, this.maxAttempts = 5, this.verifiedAt, this.deviceId, this.ipAddress, this.createdAt});
  factory _OTPVerification.fromJson(Map<String, dynamic> json) => _$OTPVerificationFromJson(json);

@override final  String id;
@override final  String? phone;
@override final  String? email;
@override final  String otpCode;
@override final  OTPType type;
@override@JsonKey() final  bool isUsed;
@override final  DateTime expiresAt;
@override@JsonKey() final  int attemptCount;
@override@JsonKey() final  int maxAttempts;
@override final  DateTime? verifiedAt;
@override final  String? deviceId;
@override final  String? ipAddress;
@override final  DateTime? createdAt;

/// Create a copy of OTPVerification
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OTPVerificationCopyWith<_OTPVerification> get copyWith => __$OTPVerificationCopyWithImpl<_OTPVerification>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OTPVerificationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OTPVerification&&(identical(other.id, id) || other.id == id)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode)&&(identical(other.type, type) || other.type == type)&&(identical(other.isUsed, isUsed) || other.isUsed == isUsed)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.attemptCount, attemptCount) || other.attemptCount == attemptCount)&&(identical(other.maxAttempts, maxAttempts) || other.maxAttempts == maxAttempts)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.deviceId, deviceId) || other.deviceId == deviceId)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phone,email,otpCode,type,isUsed,expiresAt,attemptCount,maxAttempts,verifiedAt,deviceId,ipAddress,createdAt);

@override
String toString() {
  return 'OTPVerification(id: $id, phone: $phone, email: $email, otpCode: $otpCode, type: $type, isUsed: $isUsed, expiresAt: $expiresAt, attemptCount: $attemptCount, maxAttempts: $maxAttempts, verifiedAt: $verifiedAt, deviceId: $deviceId, ipAddress: $ipAddress, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$OTPVerificationCopyWith<$Res> implements $OTPVerificationCopyWith<$Res> {
  factory _$OTPVerificationCopyWith(_OTPVerification value, $Res Function(_OTPVerification) _then) = __$OTPVerificationCopyWithImpl;
@override @useResult
$Res call({
 String id, String? phone, String? email, String otpCode, OTPType type, bool isUsed, DateTime expiresAt, int attemptCount, int maxAttempts, DateTime? verifiedAt, String? deviceId, String? ipAddress, DateTime? createdAt
});




}
/// @nodoc
class __$OTPVerificationCopyWithImpl<$Res>
    implements _$OTPVerificationCopyWith<$Res> {
  __$OTPVerificationCopyWithImpl(this._self, this._then);

  final _OTPVerification _self;
  final $Res Function(_OTPVerification) _then;

/// Create a copy of OTPVerification
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? phone = freezed,Object? email = freezed,Object? otpCode = null,Object? type = null,Object? isUsed = null,Object? expiresAt = null,Object? attemptCount = null,Object? maxAttempts = null,Object? verifiedAt = freezed,Object? deviceId = freezed,Object? ipAddress = freezed,Object? createdAt = freezed,}) {
  return _then(_OTPVerification(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as OTPType,isUsed: null == isUsed ? _self.isUsed : isUsed // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,attemptCount: null == attemptCount ? _self.attemptCount : attemptCount // ignore: cast_nullable_to_non_nullable
as int,maxAttempts: null == maxAttempts ? _self.maxAttempts : maxAttempts // ignore: cast_nullable_to_non_nullable
as int,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deviceId: freezed == deviceId ? _self.deviceId : deviceId // ignore: cast_nullable_to_non_nullable
as String?,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$SocialLoginData {

 String get id; String get provider;// google, facebook, apple, etc.
 String get socialId;// ID from the social provider
 String? get email; String? get name; String? get profileImageUrl; String? get accessToken; String? get refreshToken; DateTime? get tokenExpiresAt; Map<String, dynamic>? get rawData;// store full response
 bool get isActive; DateTime? get lastUsedAt; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of SocialLoginData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLoginDataCopyWith<SocialLoginData> get copyWith => _$SocialLoginDataCopyWithImpl<SocialLoginData>(this as SocialLoginData, _$identity);

  /// Serializes this SocialLoginData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLoginData&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.socialId, socialId) || other.socialId == socialId)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenExpiresAt, tokenExpiresAt) || other.tokenExpiresAt == tokenExpiresAt)&&const DeepCollectionEquality().equals(other.rawData, rawData)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,provider,socialId,email,name,profileImageUrl,accessToken,refreshToken,tokenExpiresAt,const DeepCollectionEquality().hash(rawData),isActive,lastUsedAt,createdAt,updatedAt);

@override
String toString() {
  return 'SocialLoginData(id: $id, provider: $provider, socialId: $socialId, email: $email, name: $name, profileImageUrl: $profileImageUrl, accessToken: $accessToken, refreshToken: $refreshToken, tokenExpiresAt: $tokenExpiresAt, rawData: $rawData, isActive: $isActive, lastUsedAt: $lastUsedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SocialLoginDataCopyWith<$Res>  {
  factory $SocialLoginDataCopyWith(SocialLoginData value, $Res Function(SocialLoginData) _then) = _$SocialLoginDataCopyWithImpl;
@useResult
$Res call({
 String id, String provider, String socialId, String? email, String? name, String? profileImageUrl, String? accessToken, String? refreshToken, DateTime? tokenExpiresAt, Map<String, dynamic>? rawData, bool isActive, DateTime? lastUsedAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$SocialLoginDataCopyWithImpl<$Res>
    implements $SocialLoginDataCopyWith<$Res> {
  _$SocialLoginDataCopyWithImpl(this._self, this._then);

  final SocialLoginData _self;
  final $Res Function(SocialLoginData) _then;

/// Create a copy of SocialLoginData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? provider = null,Object? socialId = null,Object? email = freezed,Object? name = freezed,Object? profileImageUrl = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? tokenExpiresAt = freezed,Object? rawData = freezed,Object? isActive = null,Object? lastUsedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,socialId: null == socialId ? _self.socialId : socialId // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,tokenExpiresAt: freezed == tokenExpiresAt ? _self.tokenExpiresAt : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rawData: freezed == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialLoginData].
extension SocialLoginDataPatterns on SocialLoginData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialLoginData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialLoginData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialLoginData value)  $default,){
final _that = this;
switch (_that) {
case _SocialLoginData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialLoginData value)?  $default,){
final _that = this;
switch (_that) {
case _SocialLoginData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String provider,  String socialId,  String? email,  String? name,  String? profileImageUrl,  String? accessToken,  String? refreshToken,  DateTime? tokenExpiresAt,  Map<String, dynamic>? rawData,  bool isActive,  DateTime? lastUsedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialLoginData() when $default != null:
return $default(_that.id,_that.provider,_that.socialId,_that.email,_that.name,_that.profileImageUrl,_that.accessToken,_that.refreshToken,_that.tokenExpiresAt,_that.rawData,_that.isActive,_that.lastUsedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String provider,  String socialId,  String? email,  String? name,  String? profileImageUrl,  String? accessToken,  String? refreshToken,  DateTime? tokenExpiresAt,  Map<String, dynamic>? rawData,  bool isActive,  DateTime? lastUsedAt,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SocialLoginData():
return $default(_that.id,_that.provider,_that.socialId,_that.email,_that.name,_that.profileImageUrl,_that.accessToken,_that.refreshToken,_that.tokenExpiresAt,_that.rawData,_that.isActive,_that.lastUsedAt,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String provider,  String socialId,  String? email,  String? name,  String? profileImageUrl,  String? accessToken,  String? refreshToken,  DateTime? tokenExpiresAt,  Map<String, dynamic>? rawData,  bool isActive,  DateTime? lastUsedAt,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SocialLoginData() when $default != null:
return $default(_that.id,_that.provider,_that.socialId,_that.email,_that.name,_that.profileImageUrl,_that.accessToken,_that.refreshToken,_that.tokenExpiresAt,_that.rawData,_that.isActive,_that.lastUsedAt,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SocialLoginData implements SocialLoginData {
  const _SocialLoginData({required this.id, required this.provider, required this.socialId, this.email, this.name, this.profileImageUrl, this.accessToken, this.refreshToken, this.tokenExpiresAt, final  Map<String, dynamic>? rawData, this.isActive = true, this.lastUsedAt, this.createdAt, this.updatedAt}): _rawData = rawData;
  factory _SocialLoginData.fromJson(Map<String, dynamic> json) => _$SocialLoginDataFromJson(json);

@override final  String id;
@override final  String provider;
// google, facebook, apple, etc.
@override final  String socialId;
// ID from the social provider
@override final  String? email;
@override final  String? name;
@override final  String? profileImageUrl;
@override final  String? accessToken;
@override final  String? refreshToken;
@override final  DateTime? tokenExpiresAt;
 final  Map<String, dynamic>? _rawData;
@override Map<String, dynamic>? get rawData {
  final value = _rawData;
  if (value == null) return null;
  if (_rawData is EqualUnmodifiableMapView) return _rawData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// store full response
@override@JsonKey() final  bool isActive;
@override final  DateTime? lastUsedAt;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of SocialLoginData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialLoginDataCopyWith<_SocialLoginData> get copyWith => __$SocialLoginDataCopyWithImpl<_SocialLoginData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialLoginDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialLoginData&&(identical(other.id, id) || other.id == id)&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.socialId, socialId) || other.socialId == socialId)&&(identical(other.email, email) || other.email == email)&&(identical(other.name, name) || other.name == name)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken)&&(identical(other.tokenExpiresAt, tokenExpiresAt) || other.tokenExpiresAt == tokenExpiresAt)&&const DeepCollectionEquality().equals(other._rawData, _rawData)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.lastUsedAt, lastUsedAt) || other.lastUsedAt == lastUsedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,provider,socialId,email,name,profileImageUrl,accessToken,refreshToken,tokenExpiresAt,const DeepCollectionEquality().hash(_rawData),isActive,lastUsedAt,createdAt,updatedAt);

@override
String toString() {
  return 'SocialLoginData(id: $id, provider: $provider, socialId: $socialId, email: $email, name: $name, profileImageUrl: $profileImageUrl, accessToken: $accessToken, refreshToken: $refreshToken, tokenExpiresAt: $tokenExpiresAt, rawData: $rawData, isActive: $isActive, lastUsedAt: $lastUsedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SocialLoginDataCopyWith<$Res> implements $SocialLoginDataCopyWith<$Res> {
  factory _$SocialLoginDataCopyWith(_SocialLoginData value, $Res Function(_SocialLoginData) _then) = __$SocialLoginDataCopyWithImpl;
@override @useResult
$Res call({
 String id, String provider, String socialId, String? email, String? name, String? profileImageUrl, String? accessToken, String? refreshToken, DateTime? tokenExpiresAt, Map<String, dynamic>? rawData, bool isActive, DateTime? lastUsedAt, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$SocialLoginDataCopyWithImpl<$Res>
    implements _$SocialLoginDataCopyWith<$Res> {
  __$SocialLoginDataCopyWithImpl(this._self, this._then);

  final _SocialLoginData _self;
  final $Res Function(_SocialLoginData) _then;

/// Create a copy of SocialLoginData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? provider = null,Object? socialId = null,Object? email = freezed,Object? name = freezed,Object? profileImageUrl = freezed,Object? accessToken = freezed,Object? refreshToken = freezed,Object? tokenExpiresAt = freezed,Object? rawData = freezed,Object? isActive = null,Object? lastUsedAt = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_SocialLoginData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,socialId: null == socialId ? _self.socialId : socialId // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,accessToken: freezed == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String?,refreshToken: freezed == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String?,tokenExpiresAt: freezed == tokenExpiresAt ? _self.tokenExpiresAt : tokenExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rawData: freezed == rawData ? _self._rawData : rawData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,lastUsedAt: freezed == lastUsedAt ? _self.lastUsedAt : lastUsedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$PasswordResetToken {

 String get id; String get userId; String get token; bool get isUsed; DateTime get expiresAt; String? get ipAddress; String? get userAgent; DateTime? get usedAt; DateTime? get createdAt;
/// Create a copy of PasswordResetToken
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordResetTokenCopyWith<PasswordResetToken> get copyWith => _$PasswordResetTokenCopyWithImpl<PasswordResetToken>(this as PasswordResetToken, _$identity);

  /// Serializes this PasswordResetToken to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordResetToken&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.token, token) || other.token == token)&&(identical(other.isUsed, isUsed) || other.isUsed == isUsed)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.usedAt, usedAt) || other.usedAt == usedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,token,isUsed,expiresAt,ipAddress,userAgent,usedAt,createdAt);

@override
String toString() {
  return 'PasswordResetToken(id: $id, userId: $userId, token: $token, isUsed: $isUsed, expiresAt: $expiresAt, ipAddress: $ipAddress, userAgent: $userAgent, usedAt: $usedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PasswordResetTokenCopyWith<$Res>  {
  factory $PasswordResetTokenCopyWith(PasswordResetToken value, $Res Function(PasswordResetToken) _then) = _$PasswordResetTokenCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String token, bool isUsed, DateTime expiresAt, String? ipAddress, String? userAgent, DateTime? usedAt, DateTime? createdAt
});




}
/// @nodoc
class _$PasswordResetTokenCopyWithImpl<$Res>
    implements $PasswordResetTokenCopyWith<$Res> {
  _$PasswordResetTokenCopyWithImpl(this._self, this._then);

  final PasswordResetToken _self;
  final $Res Function(PasswordResetToken) _then;

/// Create a copy of PasswordResetToken
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? token = null,Object? isUsed = null,Object? expiresAt = null,Object? ipAddress = freezed,Object? userAgent = freezed,Object? usedAt = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,isUsed: null == isUsed ? _self.isUsed : isUsed // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,usedAt: freezed == usedAt ? _self.usedAt : usedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [PasswordResetToken].
extension PasswordResetTokenPatterns on PasswordResetToken {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PasswordResetToken value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PasswordResetToken() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PasswordResetToken value)  $default,){
final _that = this;
switch (_that) {
case _PasswordResetToken():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PasswordResetToken value)?  $default,){
final _that = this;
switch (_that) {
case _PasswordResetToken() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String token,  bool isUsed,  DateTime expiresAt,  String? ipAddress,  String? userAgent,  DateTime? usedAt,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PasswordResetToken() when $default != null:
return $default(_that.id,_that.userId,_that.token,_that.isUsed,_that.expiresAt,_that.ipAddress,_that.userAgent,_that.usedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String token,  bool isUsed,  DateTime expiresAt,  String? ipAddress,  String? userAgent,  DateTime? usedAt,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _PasswordResetToken():
return $default(_that.id,_that.userId,_that.token,_that.isUsed,_that.expiresAt,_that.ipAddress,_that.userAgent,_that.usedAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String token,  bool isUsed,  DateTime expiresAt,  String? ipAddress,  String? userAgent,  DateTime? usedAt,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PasswordResetToken() when $default != null:
return $default(_that.id,_that.userId,_that.token,_that.isUsed,_that.expiresAt,_that.ipAddress,_that.userAgent,_that.usedAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PasswordResetToken implements PasswordResetToken {
  const _PasswordResetToken({required this.id, required this.userId, required this.token, this.isUsed = false, required this.expiresAt, this.ipAddress, this.userAgent, this.usedAt, this.createdAt});
  factory _PasswordResetToken.fromJson(Map<String, dynamic> json) => _$PasswordResetTokenFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String token;
@override@JsonKey() final  bool isUsed;
@override final  DateTime expiresAt;
@override final  String? ipAddress;
@override final  String? userAgent;
@override final  DateTime? usedAt;
@override final  DateTime? createdAt;

/// Create a copy of PasswordResetToken
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PasswordResetTokenCopyWith<_PasswordResetToken> get copyWith => __$PasswordResetTokenCopyWithImpl<_PasswordResetToken>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PasswordResetTokenToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PasswordResetToken&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.token, token) || other.token == token)&&(identical(other.isUsed, isUsed) || other.isUsed == isUsed)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.ipAddress, ipAddress) || other.ipAddress == ipAddress)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.usedAt, usedAt) || other.usedAt == usedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,token,isUsed,expiresAt,ipAddress,userAgent,usedAt,createdAt);

@override
String toString() {
  return 'PasswordResetToken(id: $id, userId: $userId, token: $token, isUsed: $isUsed, expiresAt: $expiresAt, ipAddress: $ipAddress, userAgent: $userAgent, usedAt: $usedAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PasswordResetTokenCopyWith<$Res> implements $PasswordResetTokenCopyWith<$Res> {
  factory _$PasswordResetTokenCopyWith(_PasswordResetToken value, $Res Function(_PasswordResetToken) _then) = __$PasswordResetTokenCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String token, bool isUsed, DateTime expiresAt, String? ipAddress, String? userAgent, DateTime? usedAt, DateTime? createdAt
});




}
/// @nodoc
class __$PasswordResetTokenCopyWithImpl<$Res>
    implements _$PasswordResetTokenCopyWith<$Res> {
  __$PasswordResetTokenCopyWithImpl(this._self, this._then);

  final _PasswordResetToken _self;
  final $Res Function(_PasswordResetToken) _then;

/// Create a copy of PasswordResetToken
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? token = null,Object? isUsed = null,Object? expiresAt = null,Object? ipAddress = freezed,Object? userAgent = freezed,Object? usedAt = freezed,Object? createdAt = freezed,}) {
  return _then(_PasswordResetToken(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,isUsed: null == isUsed ? _self.isUsed : isUsed // ignore: cast_nullable_to_non_nullable
as bool,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime,ipAddress: freezed == ipAddress ? _self.ipAddress : ipAddress // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,usedAt: freezed == usedAt ? _self.usedAt : usedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
