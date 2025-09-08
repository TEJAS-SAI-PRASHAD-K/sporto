import 'package:json_annotation/json_annotation.dart';

part 'sport.g.dart';

@JsonSerializable()
class Sport {
  @JsonKey(name: 'sport_id')
  String sportId;

  @JsonKey(name: 'sport_name')
  String sportName;

  @JsonKey(name: 'icon_url')
  String? iconUrl;

  @JsonKey(name: 'image_url')
  String? imageUrl;

  @JsonKey(name: 'sport_category')
  String? sportCategory;

  String? aliases; // as text in DB

  @JsonKey(name: 'game_type')
  String? gameType; // Singles, Doubles, Team

  @JsonKey(name: 'minimum_players')
  int? minimumPlayers;

  @JsonKey(name: 'maximum_players')
  int? maximumPlayers;

  @JsonKey(name: 'game_duration_minutes')
  int? gameDurationMinutes;

  @JsonKey(name: 'rules_and_regulations')
  String? rulesAndRegulations;

  @JsonKey(name: 'is_sport_active')
  bool isSportActive;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  @JsonKey(name: 'equipment_required')
  List<String>? equipmentRequired;

  Sport({
    required this.sportId,
    required this.sportName,
    this.iconUrl,
    this.imageUrl,
    this.sportCategory,
    this.aliases,
    this.gameType,
    this.minimumPlayers,
    this.maximumPlayers,
    this.gameDurationMinutes,
    this.rulesAndRegulations,
    this.isSportActive = true,
    this.createdAt,
    this.updatedAt,
    this.equipmentRequired,
  });

  factory Sport.fromJson(Map<String, dynamic> json) => _$SportFromJson(json);
  Map<String, dynamic> toJson() => _$SportToJson(this);
}

@JsonSerializable()
class SportsSkillLevel {
  @JsonKey(name: 'skill_level_id')
  String skillLevelId;

  @JsonKey(name: 'sport_id')
  String sportId;

  @JsonKey(name: 'level_number')
  int levelNumber;

  @JsonKey(name: 'display_name')
  String displayName;

  @JsonKey(name: 'level_order')
  int? levelOrder;

  String? characteristics; // text in DB

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  SportsSkillLevel({
    required this.skillLevelId,
    required this.sportId,
    required this.levelNumber,
    required this.displayName,
    this.levelOrder,
    this.characteristics,
    this.createdAt,
    this.updatedAt,
  });

  factory SportsSkillLevel.fromJson(Map<String, dynamic> json) =>
      _$SportsSkillLevelFromJson(json);
  Map<String, dynamic> toJson() => _$SportsSkillLevelToJson(this);
}
