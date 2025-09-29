// ignore_for_file: invalid_annotation_target

import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sport.freezed.dart';
part 'sport.g.dart';

Sport sportFromJson(String str) => Sport.fromJson(json.decode(str));
String sportToJson(Sport data) => json.encode(data.toJson());

@freezed
abstract class Sport with _$Sport {
  const factory Sport({
    @JsonKey(name: 'sport_id') required String sportId,
    @JsonKey(name: 'sport_name') required String sportName,
    @JsonKey(name: 'icon_url') String? iconUrl,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'sport_category') String? sportCategory,
    String? aliases,
    @JsonKey(name: 'game_type') String? gameType,
    @JsonKey(name: 'minimum_players') int? minimumPlayers,
    @JsonKey(name: 'maximum_players') int? maximumPlayers,
    @JsonKey(name: 'game_duration_minutes') int? gameDurationMinutes,
    @JsonKey(name: 'rules_and_regulations') String? rulesAndRegulations,
    @Default(true) @JsonKey(name: 'is_sport_active') bool isSportActive,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'equipment_required') List<String>? equipmentRequired,
  }) = _Sport;

  factory Sport.fromJson(Map<String, dynamic> json) => _$SportFromJson(json);
}

@freezed
abstract class SportsSkillLevel with _$SportsSkillLevel {
  const factory SportsSkillLevel({
    @JsonKey(name: 'skill_level_id') required String skillLevelId,
    @JsonKey(name: 'sport_id') required String sportId,
    @JsonKey(name: 'level_number') required int levelNumber,
    @JsonKey(name: 'display_name') required String displayName,
    @JsonKey(name: 'level_order') int? levelOrder,
    String? characteristics,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _SportsSkillLevel;

  factory SportsSkillLevel.fromJson(Map<String, dynamic> json) =>
      _$SportsSkillLevelFromJson(json);
}
