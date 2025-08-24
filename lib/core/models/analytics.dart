import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'analytics.g.dart';

/// User activity analytics
@Entity()
@JsonSerializable()
class UserAnalytics {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId;

  // Sports activity stats
  int totalGamesPlayed;
  int totalGamesWon;
  int totalGamesLost;
  int totalGamesCancelled;
  double averageRating;
  int totalRatingsReceived;

  // Training stats
  int totalTrainingSessions;
  int totalTrainingHours;
  double totalTrainingAmount;

  // Venue booking stats
  int totalVenueBookings;
  int totalVenueHours;
  double totalVenueAmount;

  // Social stats
  int totalFriends;
  int totalGameInvitesSent;
  int totalGameInvitesReceived;
  int totalGameInvitesAccepted;

  // Streak stats
  int currentActiveStreak; // days
  int longestActiveStreak; // days
  @Property(type: PropertyType.date)
  DateTime? lastActiveDate;

  // Monthly stats
  String? currentMonth; // YYYY-MM format
  int monthlyGames;
  int monthlyTrainingSessions;
  int monthlyVenueBookings;
  double monthlySpending;

  @Property(type: PropertyType.date)
  DateTime? lastUpdated;
  @Property(type: PropertyType.date)
  DateTime? createdAt;

  UserAnalytics({
    this.localId = 0,
    required this.id,
    required this.userId,
    this.totalGamesPlayed = 0,
    this.totalGamesWon = 0,
    this.totalGamesLost = 0,
    this.totalGamesCancelled = 0,
    this.averageRating = 0.0,
    this.totalRatingsReceived = 0,
    this.totalTrainingSessions = 0,
    this.totalTrainingHours = 0,
    this.totalTrainingAmount = 0.0,
    this.totalVenueBookings = 0,
    this.totalVenueHours = 0,
    this.totalVenueAmount = 0.0,
    this.totalFriends = 0,
    this.totalGameInvitesSent = 0,
    this.totalGameInvitesReceived = 0,
    this.totalGameInvitesAccepted = 0,
    this.currentActiveStreak = 0,
    this.longestActiveStreak = 0,
    this.lastActiveDate,
    this.currentMonth,
    this.monthlyGames = 0,
    this.monthlyTrainingSessions = 0,
    this.monthlyVenueBookings = 0,
    this.monthlySpending = 0.0,
    this.lastUpdated,
    this.createdAt,
  });

  factory UserAnalytics.fromJson(Map<String, dynamic> json) =>
      _$UserAnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$UserAnalyticsToJson(this);
}

/// Sport-specific user statistics
@Entity()
@JsonSerializable()
class UserSportStats {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId;
  String sportId;

  // Skill level tracking
  @Transient()
  UserSkillLevel? skillLevel;

  // Stable database field for enum storage
  int? get dbSkillLevel {
    return skillLevel?.stableId;
  }

  set dbSkillLevel(int? value) {
    if (value == null) {
      skillLevel = null;
    } else {
      skillLevel = UserSkillLevel.fromStableId(value);
    }
  }

  double skillRating; // 0.0 to 10.0
  int totalMatches;
  int wins;
  int losses;
  int draws;
  double winRate;

  // Performance metrics
  double averagePerformanceRating;
  int totalPerformanceRatings;
  int mvpCount; // Most Valuable Player awards

  // Participation stats
  int totalHoursPlayed;
  @Property(type: PropertyType.date)
  DateTime? firstGameDate;
  @Property(type: PropertyType.date)
  DateTime? lastGameDate;

  // Improvement tracking
  List<String> achievementIds;
  List<String> badgeIds;
  @Property(type: PropertyType.date)
  DateTime? lastSkillUpdate;

  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  UserSportStats({
    this.localId = 0,
    required this.id,
    required this.userId,
    required this.sportId,
    UserSkillLevel skillLevel = UserSkillLevel.beginner,
    this.skillRating = 0.0,
    this.totalMatches = 0,
    this.wins = 0,
    this.losses = 0,
    this.draws = 0,
    this.winRate = 0.0,
    this.averagePerformanceRating = 0.0,
    this.totalPerformanceRatings = 0,
    this.mvpCount = 0,
    this.totalHoursPlayed = 0,
    this.firstGameDate,
    this.lastGameDate,
    this.achievementIds = const [],
    this.badgeIds = const [],
    this.lastSkillUpdate,
    this.createdAt,
    this.updatedAt,
  }) {
    this.skillLevel = skillLevel;
  }

  factory UserSportStats.fromJson(Map<String, dynamic> json) =>
      _$UserSportStatsFromJson(json);
  Map<String, dynamic> toJson() => _$UserSportStatsToJson(this);
}

enum UserSkillLevel {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('beginner')
  beginner,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('advanced')
  advanced,
  @JsonValue('expert')
  expert,
  @JsonValue('professional')
  professional;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case UserSkillLevel.unknown:
        return 0;
      case UserSkillLevel.beginner:
        return 1;
      case UserSkillLevel.intermediate:
        return 2;
      case UserSkillLevel.advanced:
        return 3;
      case UserSkillLevel.expert:
        return 4;
      case UserSkillLevel.professional:
        return 5;
    }
  }

  static UserSkillLevel fromStableId(int id) {
    switch (id) {
      case 0:
        return UserSkillLevel.unknown;
      case 1:
        return UserSkillLevel.beginner;
      case 2:
        return UserSkillLevel.intermediate;
      case 3:
        return UserSkillLevel.advanced;
      case 4:
        return UserSkillLevel.expert;
      case 5:
        return UserSkillLevel.professional;
      default:
        return UserSkillLevel.unknown;
    }
  }
}

/// Achievement system
@Entity()
@JsonSerializable()
class Achievement {
  @Id()
  int localId;

  @Unique()
  String id;
  String name;
  String description;
  String? icon;

  // Store enums as stable int for ObjectBox compatibility
  @Transient()
  AchievementCategory? category;

  @Transient()
  AchievementRarity? rarity;

  // Stable database fields for enum storage
  int? get dbCategory {
    return category?.stableId;
  }

  set dbCategory(int? value) {
    if (value == null) {
      category = null;
    } else {
      category = AchievementCategory.fromStableId(value);
    }
  }

  int? get dbRarity {
    return rarity?.stableId;
  }

  set dbRarity(int? value) {
    if (value == null) {
      rarity = null;
    } else {
      rarity = AchievementRarity.fromStableId(value);
    }
  }

  String? sportId; // null for general achievements
  int points; // points awarded
  String? criteria; // JSON description of criteria
  bool isActive;
  @Property(type: PropertyType.date)
  DateTime? createdAt;

  Achievement({
    this.localId = 0,
    required this.id,
    required this.name,
    required this.description,
    this.icon,
    AchievementCategory category = AchievementCategory.games,
    AchievementRarity rarity = AchievementRarity.common,
    this.sportId,
    this.points = 0,
    this.criteria,
    this.isActive = true,
    this.createdAt,
  }) {
    this.category = category;
    this.rarity = rarity;
  }

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
  Map<String, dynamic> toJson() => _$AchievementToJson(this);
}

enum AchievementCategory {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('games')
  games,
  @JsonValue('training')
  training,
  @JsonValue('social')
  social,
  @JsonValue('skill')
  skill,
  @JsonValue('streak')
  streak,
  @JsonValue('special')
  special;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case AchievementCategory.unknown:
        return 0;
      case AchievementCategory.games:
        return 1;
      case AchievementCategory.training:
        return 2;
      case AchievementCategory.social:
        return 3;
      case AchievementCategory.skill:
        return 4;
      case AchievementCategory.streak:
        return 5;
      case AchievementCategory.special:
        return 6;
    }
  }

  static AchievementCategory fromStableId(int id) {
    switch (id) {
      case 0:
        return AchievementCategory.unknown;
      case 1:
        return AchievementCategory.games;
      case 2:
        return AchievementCategory.training;
      case 3:
        return AchievementCategory.social;
      case 4:
        return AchievementCategory.skill;
      case 5:
        return AchievementCategory.streak;
      case 6:
        return AchievementCategory.special;
      default:
        return AchievementCategory.unknown;
    }
  }
}

enum AchievementRarity {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('common')
  common,
  @JsonValue('rare')
  rare,
  @JsonValue('epic')
  epic,
  @JsonValue('legendary')
  legendary;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case AchievementRarity.unknown:
        return 0;
      case AchievementRarity.common:
        return 1;
      case AchievementRarity.rare:
        return 2;
      case AchievementRarity.epic:
        return 3;
      case AchievementRarity.legendary:
        return 4;
    }
  }

  static AchievementRarity fromStableId(int id) {
    switch (id) {
      case 0:
        return AchievementRarity.unknown;
      case 1:
        return AchievementRarity.common;
      case 2:
        return AchievementRarity.rare;
      case 3:
        return AchievementRarity.epic;
      case 4:
        return AchievementRarity.legendary;
      default:
        return AchievementRarity.unknown;
    }
  }
}

/// User achievement records
@Entity()
@JsonSerializable()
class UserAchievement {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId;
  String achievementId;
  @Property(type: PropertyType.date)
  DateTime unlockedAt;
  String? gameId; // if unlocked during a specific game
  String? sessionId; // if unlocked during training
  int progress; // 0-100 for progressive achievements
  bool isNotified; // if user has been notified
  @Property(type: PropertyType.date)
  DateTime? createdAt;

  UserAchievement({
    this.localId = 0,
    required this.id,
    required this.userId,
    required this.achievementId,
    required this.unlockedAt,
    this.gameId,
    this.sessionId,
    this.progress = 100,
    this.isNotified = false,
    this.createdAt,
  });

  factory UserAchievement.fromJson(Map<String, dynamic> json) =>
      _$UserAchievementFromJson(json);
  Map<String, dynamic> toJson() => _$UserAchievementToJson(this);
}
