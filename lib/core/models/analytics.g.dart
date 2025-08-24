// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAnalytics _$UserAnalyticsFromJson(
  Map<String, dynamic> json,
) => UserAnalytics(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  userId: json['userId'] as String,
  totalGamesPlayed: (json['totalGamesPlayed'] as num?)?.toInt() ?? 0,
  totalGamesWon: (json['totalGamesWon'] as num?)?.toInt() ?? 0,
  totalGamesLost: (json['totalGamesLost'] as num?)?.toInt() ?? 0,
  totalGamesCancelled: (json['totalGamesCancelled'] as num?)?.toInt() ?? 0,
  averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
  totalRatingsReceived: (json['totalRatingsReceived'] as num?)?.toInt() ?? 0,
  totalTrainingSessions: (json['totalTrainingSessions'] as num?)?.toInt() ?? 0,
  totalTrainingHours: (json['totalTrainingHours'] as num?)?.toInt() ?? 0,
  totalTrainingAmount: (json['totalTrainingAmount'] as num?)?.toDouble() ?? 0.0,
  totalVenueBookings: (json['totalVenueBookings'] as num?)?.toInt() ?? 0,
  totalVenueHours: (json['totalVenueHours'] as num?)?.toInt() ?? 0,
  totalVenueAmount: (json['totalVenueAmount'] as num?)?.toDouble() ?? 0.0,
  totalFriends: (json['totalFriends'] as num?)?.toInt() ?? 0,
  totalGameInvitesSent: (json['totalGameInvitesSent'] as num?)?.toInt() ?? 0,
  totalGameInvitesReceived:
      (json['totalGameInvitesReceived'] as num?)?.toInt() ?? 0,
  totalGameInvitesAccepted:
      (json['totalGameInvitesAccepted'] as num?)?.toInt() ?? 0,
  currentActiveStreak: (json['currentActiveStreak'] as num?)?.toInt() ?? 0,
  longestActiveStreak: (json['longestActiveStreak'] as num?)?.toInt() ?? 0,
  lastActiveDate: json['lastActiveDate'] == null
      ? null
      : DateTime.parse(json['lastActiveDate'] as String),
  currentMonth: json['currentMonth'] as String?,
  monthlyGames: (json['monthlyGames'] as num?)?.toInt() ?? 0,
  monthlyTrainingSessions:
      (json['monthlyTrainingSessions'] as num?)?.toInt() ?? 0,
  monthlyVenueBookings: (json['monthlyVenueBookings'] as num?)?.toInt() ?? 0,
  monthlySpending: (json['monthlySpending'] as num?)?.toDouble() ?? 0.0,
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$UserAnalyticsToJson(UserAnalytics instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'userId': instance.userId,
      'totalGamesPlayed': instance.totalGamesPlayed,
      'totalGamesWon': instance.totalGamesWon,
      'totalGamesLost': instance.totalGamesLost,
      'totalGamesCancelled': instance.totalGamesCancelled,
      'averageRating': instance.averageRating,
      'totalRatingsReceived': instance.totalRatingsReceived,
      'totalTrainingSessions': instance.totalTrainingSessions,
      'totalTrainingHours': instance.totalTrainingHours,
      'totalTrainingAmount': instance.totalTrainingAmount,
      'totalVenueBookings': instance.totalVenueBookings,
      'totalVenueHours': instance.totalVenueHours,
      'totalVenueAmount': instance.totalVenueAmount,
      'totalFriends': instance.totalFriends,
      'totalGameInvitesSent': instance.totalGameInvitesSent,
      'totalGameInvitesReceived': instance.totalGameInvitesReceived,
      'totalGameInvitesAccepted': instance.totalGameInvitesAccepted,
      'currentActiveStreak': instance.currentActiveStreak,
      'longestActiveStreak': instance.longestActiveStreak,
      'lastActiveDate': instance.lastActiveDate?.toIso8601String(),
      'currentMonth': instance.currentMonth,
      'monthlyGames': instance.monthlyGames,
      'monthlyTrainingSessions': instance.monthlyTrainingSessions,
      'monthlyVenueBookings': instance.monthlyVenueBookings,
      'monthlySpending': instance.monthlySpending,
      'lastUpdated': instance.lastUpdated?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

UserSportStats _$UserSportStatsFromJson(Map<String, dynamic> json) =>
    UserSportStats(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      userId: json['userId'] as String,
      sportId: json['sportId'] as String,
      skillLevel:
          $enumDecodeNullable(_$UserSkillLevelEnumMap, json['skillLevel']) ??
          UserSkillLevel.beginner,
      skillRating: (json['skillRating'] as num?)?.toDouble() ?? 0.0,
      totalMatches: (json['totalMatches'] as num?)?.toInt() ?? 0,
      wins: (json['wins'] as num?)?.toInt() ?? 0,
      losses: (json['losses'] as num?)?.toInt() ?? 0,
      draws: (json['draws'] as num?)?.toInt() ?? 0,
      winRate: (json['winRate'] as num?)?.toDouble() ?? 0.0,
      averagePerformanceRating:
          (json['averagePerformanceRating'] as num?)?.toDouble() ?? 0.0,
      totalPerformanceRatings:
          (json['totalPerformanceRatings'] as num?)?.toInt() ?? 0,
      mvpCount: (json['mvpCount'] as num?)?.toInt() ?? 0,
      totalHoursPlayed: (json['totalHoursPlayed'] as num?)?.toInt() ?? 0,
      firstGameDate: json['firstGameDate'] == null
          ? null
          : DateTime.parse(json['firstGameDate'] as String),
      lastGameDate: json['lastGameDate'] == null
          ? null
          : DateTime.parse(json['lastGameDate'] as String),
      achievementIds:
          (json['achievementIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      badgeIds:
          (json['badgeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      lastSkillUpdate: json['lastSkillUpdate'] == null
          ? null
          : DateTime.parse(json['lastSkillUpdate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    )..dbSkillLevel = (json['dbSkillLevel'] as num?)?.toInt();

Map<String, dynamic> _$UserSportStatsToJson(UserSportStats instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'userId': instance.userId,
      'sportId': instance.sportId,
      'skillLevel': _$UserSkillLevelEnumMap[instance.skillLevel],
      'dbSkillLevel': instance.dbSkillLevel,
      'skillRating': instance.skillRating,
      'totalMatches': instance.totalMatches,
      'wins': instance.wins,
      'losses': instance.losses,
      'draws': instance.draws,
      'winRate': instance.winRate,
      'averagePerformanceRating': instance.averagePerformanceRating,
      'totalPerformanceRatings': instance.totalPerformanceRatings,
      'mvpCount': instance.mvpCount,
      'totalHoursPlayed': instance.totalHoursPlayed,
      'firstGameDate': instance.firstGameDate?.toIso8601String(),
      'lastGameDate': instance.lastGameDate?.toIso8601String(),
      'achievementIds': instance.achievementIds,
      'badgeIds': instance.badgeIds,
      'lastSkillUpdate': instance.lastSkillUpdate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$UserSkillLevelEnumMap = {
  UserSkillLevel.unknown: 'unknown',
  UserSkillLevel.beginner: 'beginner',
  UserSkillLevel.intermediate: 'intermediate',
  UserSkillLevel.advanced: 'advanced',
  UserSkillLevel.expert: 'expert',
  UserSkillLevel.professional: 'professional',
};

Achievement _$AchievementFromJson(Map<String, dynamic> json) =>
    Achievement(
        localId: (json['localId'] as num?)?.toInt() ?? 0,
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        icon: json['icon'] as String?,
        category:
            $enumDecodeNullable(
              _$AchievementCategoryEnumMap,
              json['category'],
            ) ??
            AchievementCategory.games,
        rarity:
            $enumDecodeNullable(_$AchievementRarityEnumMap, json['rarity']) ??
            AchievementRarity.common,
        sportId: json['sportId'] as String?,
        points: (json['points'] as num?)?.toInt() ?? 0,
        criteria: json['criteria'] as String?,
        isActive: json['isActive'] as bool? ?? true,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
      )
      ..dbCategory = (json['dbCategory'] as num?)?.toInt()
      ..dbRarity = (json['dbRarity'] as num?)?.toInt();

Map<String, dynamic> _$AchievementToJson(Achievement instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'icon': instance.icon,
      'category': _$AchievementCategoryEnumMap[instance.category],
      'rarity': _$AchievementRarityEnumMap[instance.rarity],
      'dbCategory': instance.dbCategory,
      'dbRarity': instance.dbRarity,
      'sportId': instance.sportId,
      'points': instance.points,
      'criteria': instance.criteria,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$AchievementCategoryEnumMap = {
  AchievementCategory.unknown: 'unknown',
  AchievementCategory.games: 'games',
  AchievementCategory.training: 'training',
  AchievementCategory.social: 'social',
  AchievementCategory.skill: 'skill',
  AchievementCategory.streak: 'streak',
  AchievementCategory.special: 'special',
};

const _$AchievementRarityEnumMap = {
  AchievementRarity.unknown: 'unknown',
  AchievementRarity.common: 'common',
  AchievementRarity.rare: 'rare',
  AchievementRarity.epic: 'epic',
  AchievementRarity.legendary: 'legendary',
};

UserAchievement _$UserAchievementFromJson(Map<String, dynamic> json) =>
    UserAchievement(
      localId: (json['localId'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      userId: json['userId'] as String,
      achievementId: json['achievementId'] as String,
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
      gameId: json['gameId'] as String?,
      sessionId: json['sessionId'] as String?,
      progress: (json['progress'] as num?)?.toInt() ?? 100,
      isNotified: json['isNotified'] as bool? ?? false,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$UserAchievementToJson(UserAchievement instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'userId': instance.userId,
      'achievementId': instance.achievementId,
      'unlockedAt': instance.unlockedAt.toIso8601String(),
      'gameId': instance.gameId,
      'sessionId': instance.sessionId,
      'progress': instance.progress,
      'isNotified': instance.isNotified,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
