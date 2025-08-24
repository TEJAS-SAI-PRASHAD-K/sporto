// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  name: json['name'] as String,
  displayName: json['displayName'] as String?,
  description: json['description'] as String?,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  address: json['address'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  zipCode: json['zipCode'] as String?,
  type: $enumDecodeNullable(_$LocationTypeEnumMap, json['type']),
  parentLocationId: json['parentLocationId'] as String?,
  childLocationIds:
      (json['childLocationIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  isActive: json['isActive'] as bool? ?? true,
  popularityScore: (json['popularityScore'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'localId': instance.localId,
  'id': instance.id,
  'name': instance.name,
  'displayName': instance.displayName,
  'description': instance.description,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'address': instance.address,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'zipCode': instance.zipCode,
  'type': _$LocationTypeEnumMap[instance.type],
  'parentLocationId': instance.parentLocationId,
  'childLocationIds': instance.childLocationIds,
  'isActive': instance.isActive,
  'popularityScore': instance.popularityScore,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$LocationTypeEnumMap = {
  LocationType.country: 'country',
  LocationType.state: 'state',
  LocationType.city: 'city',
  LocationType.area: 'area',
  LocationType.landmark: 'landmark',
  LocationType.venue: 'venue',
  LocationType.custom: 'custom',
};

SavedLocation _$SavedLocationFromJson(Map<String, dynamic> json) =>
    SavedLocation(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      type: $enumDecodeNullable(_$SavedLocationTypeEnumMap, json['type']),
      isActive: json['isActive'] as bool? ?? true,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SavedLocationToJson(SavedLocation instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'description': instance.description,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'type': _$SavedLocationTypeEnumMap[instance.type],
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$SavedLocationTypeEnumMap = {
  SavedLocationType.home: 'home',
  SavedLocationType.work: 'work',
  SavedLocationType.gym: 'gym',
  SavedLocationType.club: 'club',
  SavedLocationType.favorite: 'favorite',
  SavedLocationType.custom: 'custom',
};
