// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sport _$SportFromJson(Map<String, dynamic> json) => Sport(
  sportId: json['sport_id'] as String,
  sportName: json['sport_name'] as String,
  iconUrl: json['icon_url'] as String?,
  imageUrl: json['image_url'] as String?,
  sportCategory: json['sport_category'] as String?,
  aliases: json['aliases'] as String?,
  gameType: json['game_type'] as String?,
  minimumPlayers: (json['minimum_players'] as num?)?.toInt(),
  maximumPlayers: (json['maximum_players'] as num?)?.toInt(),
  gameDurationMinutes: (json['game_duration_minutes'] as num?)?.toInt(),
  rulesAndRegulations: json['rules_and_regulations'] as String?,
  isSportActive: json['is_sport_active'] as bool? ?? true,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  equipmentRequired: (json['equipment_required'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$SportToJson(Sport instance) => <String, dynamic>{
  'sport_id': instance.sportId,
  'sport_name': instance.sportName,
  'icon_url': instance.iconUrl,
  'image_url': instance.imageUrl,
  'sport_category': instance.sportCategory,
  'aliases': instance.aliases,
  'game_type': instance.gameType,
  'minimum_players': instance.minimumPlayers,
  'maximum_players': instance.maximumPlayers,
  'game_duration_minutes': instance.gameDurationMinutes,
  'rules_and_regulations': instance.rulesAndRegulations,
  'is_sport_active': instance.isSportActive,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
  'equipment_required': instance.equipmentRequired,
};

SportsSkillLevel _$SportsSkillLevelFromJson(Map<String, dynamic> json) =>
    SportsSkillLevel(
      skillLevelId: json['skill_level_id'] as String,
      sportId: json['sport_id'] as String,
      levelNumber: (json['level_number'] as num).toInt(),
      displayName: json['display_name'] as String,
      levelOrder: (json['level_order'] as num?)?.toInt(),
      characteristics: json['characteristics'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SportsSkillLevelToJson(SportsSkillLevel instance) =>
    <String, dynamic>{
      'skill_level_id': instance.skillLevelId,
      'sport_id': instance.sportId,
      'level_number': instance.levelNumber,
      'display_name': instance.displayName,
      'level_order': instance.levelOrder,
      'characteristics': instance.characteristics,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
