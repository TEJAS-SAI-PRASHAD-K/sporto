// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sport _$SportFromJson(Map<String, dynamic> json) => Sport(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  iconUrl: json['iconUrl'] as String?,
  imageUrl: json['imageUrl'] as String?,
  category:
      $enumDecodeNullable(_$SportCategoryEnumMap, json['category']) ??
      SportCategory.individual,
  aliases:
      (json['aliases'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  skillLevels:
      (json['skillLevels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  gameTypes:
      (json['gameTypes'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  positions:
      (json['positions'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  minPlayers: (json['minPlayers'] as num?)?.toInt(),
  maxPlayers: (json['maxPlayers'] as num?)?.toInt(),
  typicalDurationMinutes: (json['typicalDurationMinutes'] as num?)?.toInt(),
  equipmentRequired:
      (json['equipmentRequired'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  rules:
      (json['rules'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isActive: json['isActive'] as bool? ?? true,
  popularityScore: (json['popularityScore'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
)..dbCategory = (json['dbCategory'] as num?)?.toInt();

Map<String, dynamic> _$SportToJson(Sport instance) => <String, dynamic>{
  'localId': instance.localId,
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'iconUrl': instance.iconUrl,
  'imageUrl': instance.imageUrl,
  'category': _$SportCategoryEnumMap[instance.category],
  'dbCategory': instance.dbCategory,
  'aliases': instance.aliases,
  'skillLevels': instance.skillLevels,
  'gameTypes': instance.gameTypes,
  'positions': instance.positions,
  'minPlayers': instance.minPlayers,
  'maxPlayers': instance.maxPlayers,
  'typicalDurationMinutes': instance.typicalDurationMinutes,
  'equipmentRequired': instance.equipmentRequired,
  'rules': instance.rules,
  'isActive': instance.isActive,
  'popularityScore': instance.popularityScore,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$SportCategoryEnumMap = {
  SportCategory.unknown: 'unknown',
  SportCategory.racket: 'racket',
  SportCategory.ball: 'ball',
  SportCategory.water: 'water',
  SportCategory.individual: 'individual',
  SportCategory.team: 'team',
  SportCategory.combat: 'combat',
  SportCategory.adventure: 'adventure',
  SportCategory.fitness: 'fitness',
};

SportSkillLevel _$SportSkillLevelFromJson(Map<String, dynamic> json) =>
    SportSkillLevel(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      sportId: json['sportId'] as String,
      level: json['level'] as String,
      displayName: json['displayName'] as String,
      description: json['description'] as String?,
      order: (json['order'] as num?)?.toInt(),
      characteristics:
          (json['characteristics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$SportSkillLevelToJson(SportSkillLevel instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'sportId': instance.sportId,
      'level': instance.level,
      'displayName': instance.displayName,
      'description': instance.description,
      'order': instance.order,
      'characteristics': instance.characteristics,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
