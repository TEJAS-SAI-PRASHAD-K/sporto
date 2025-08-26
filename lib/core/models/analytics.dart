import 'package:json_annotation/json_annotation.dart';

part 'analytics.g.dart';

/// User activity analytics
@JsonSerializable()
class UserAnalytics {
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
  DateTime? lastActiveDate;

  // Monthly stats
  String? currentMonth; // YYYY-MM format
  int monthlyGames;
  int monthlyTrainingSessions;
  int monthlyVenueBookings;
  double monthlySpending;

  DateTime? lastUpdated;
  DateTime? createdAt;

  UserAnalytics({
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
@JsonSerializable()
class UserSportStats {
  String id;
  String userId;
  String sportId;

  UserSkillLevel skillLevel;
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
  DateTime? firstGameDate;
  DateTime? lastGameDate;

  // Improvement tracking
  List<String> achievementIds;
  List<String> badgeIds;
  DateTime? lastSkillUpdate;

  DateTime? createdAt;
  DateTime? updatedAt;

  UserSportStats({
    required this.id,
    required this.userId,
    required this.sportId,
    this.skillLevel = UserSkillLevel.beginner,
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
  });

  factory UserSportStats.fromJson(Map<String, dynamic> json) =>
      _$UserSportStatsFromJson(json);
  Map<String, dynamic> toJson() => _$UserSportStatsToJson(this);
}

enum UserSkillLevel {
  @JsonValue('unknown')
  unknown,
  @JsonValue('beginner')
  beginner,
  @JsonValue('intermediate')
  intermediate,
  @JsonValue('advanced')
  advanced,
  @JsonValue('expert')
  expert,
  @JsonValue('professional')
  professional,
}

/// Achievement system
@JsonSerializable()
class Achievement {
  String id;
  String name;
  String description;
  String? icon;

  AchievementCategory category;
  AchievementRarity rarity;

  String? sportId; // null for general achievements
  int points; // points awarded
  String? criteria; // JSON description of criteria
  bool isActive;
  DateTime? createdAt;

  Achievement({
    required this.id,
    required this.name,
    required this.description,
    this.icon,
    this.category = AchievementCategory.games,
    this.rarity = AchievementRarity.common,
    this.sportId,
    this.points = 0,
    this.criteria,
    this.isActive = true,
    this.createdAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);
  Map<String, dynamic> toJson() => _$AchievementToJson(this);
}

enum AchievementCategory {
  @JsonValue('unknown')
  unknown,
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
  special,
}

enum AchievementRarity {
  @JsonValue('unknown')
  unknown,
  @JsonValue('common')
  common,
  @JsonValue('rare')
  rare,
  @JsonValue('epic')
  epic,
  @JsonValue('legendary')
  legendary,
}

/// User achievement records
@JsonSerializable()
class UserAchievement {
  String id;
  String userId;
  String achievementId;
  DateTime unlockedAt;
  String? gameId; // if unlocked during a specific game
  String? sessionId; // if unlocked during training
  int progress; // 0-100 for progressive achievements
  bool isNotified; // if user has been notified
  DateTime? createdAt;

  UserAchievement({
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
