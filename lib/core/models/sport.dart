import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'sport.g.dart';

/// Sport categories and information
@Entity()
@JsonSerializable()
class Sport {
  @Id()
  int localId;

  @Unique()
  String id;
  String name;
  String? description;
  String? iconUrl;
  String? imageUrl;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  SportCategory? category;

  // Stable database field for enum storage
  int? get dbCategory {
    return category?.stableId;
  }

  set dbCategory(int? value) {
    if (value == null) {
      category = null;
    } else {
      category = SportCategory.fromStableId(value);
    }
  }

  List<String> aliases; // alternative names
  List<String> skillLevels;
  List<String> gameTypes; // singles, doubles, team
  List<String> positions; // for team sports
  int? minPlayers;
  int? maxPlayers;
  int? typicalDurationMinutes;
  List<String> equipmentRequired;
  List<String> rules;
  bool isActive;
  int popularityScore;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  Sport({
    this.localId = 0,
    required this.id,
    required this.name,
    this.description,
    this.iconUrl,
    this.imageUrl,
    SportCategory category = SportCategory.individual,
    this.aliases = const [],
    this.skillLevels = const [],
    this.gameTypes = const [],
    this.positions = const [],
    this.minPlayers,
    this.maxPlayers,
    this.typicalDurationMinutes,
    this.equipmentRequired = const [],
    this.rules = const [],
    this.isActive = true,
    this.popularityScore = 0,
    this.createdAt,
    this.updatedAt,
  }) {
    this.category = category;
  }

  factory Sport.fromJson(Map<String, dynamic> json) => _$SportFromJson(json);
  Map<String, dynamic> toJson() => _$SportToJson(this);
}

enum SportCategory {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('racket')
  racket,
  @JsonValue('ball')
  ball,
  @JsonValue('water')
  water,
  @JsonValue('individual')
  individual,
  @JsonValue('team')
  team,
  @JsonValue('combat')
  combat,
  @JsonValue('adventure')
  adventure,
  @JsonValue('fitness')
  fitness;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case SportCategory.unknown:
        return 0;
      case SportCategory.racket:
        return 1;
      case SportCategory.ball:
        return 2;
      case SportCategory.water:
        return 3;
      case SportCategory.individual:
        return 4;
      case SportCategory.team:
        return 5;
      case SportCategory.combat:
        return 6;
      case SportCategory.adventure:
        return 7;
      case SportCategory.fitness:
        return 8;
    }
  }

  static SportCategory fromStableId(int id) {
    switch (id) {
      case 0:
        return SportCategory.unknown;
      case 1:
        return SportCategory.racket;
      case 2:
        return SportCategory.ball;
      case 3:
        return SportCategory.water;
      case 4:
        return SportCategory.individual;
      case 5:
        return SportCategory.team;
      case 6:
        return SportCategory.combat;
      case 7:
        return SportCategory.adventure;
      case 8:
        return SportCategory.fitness;
      default:
        return SportCategory.unknown;
    }
  }
}

/// Sport skill levels with descriptions
@Entity()
@JsonSerializable()
class SportSkillLevel {
  @Id()
  int localId;

  @Unique()
  String id;
  String sportId;
  String level; // beginner, amateur, intermediate, advanced, professional
  String displayName;
  String? description;
  int? order;
  List<String> characteristics;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  SportSkillLevel({
    this.localId = 0,
    required this.id,
    required this.sportId,
    required this.level,
    required this.displayName,
    this.description,
    this.order,
    this.characteristics = const [],
    this.createdAt,
    this.updatedAt,
  });

  factory SportSkillLevel.fromJson(Map<String, dynamic> json) =>
      _$SportSkillLevelFromJson(json);
  Map<String, dynamic> toJson() => _$SportSkillLevelToJson(this);
}
