import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'game.g.dart';

/// Game model for play feature
@Entity()
@JsonSerializable()
class Game {
  @Id()
  int localId;

  @Unique()
  String id;
  String organizerId;
  String sportId;
  String title;
  String? description;
  String gameType; // singles, doubles, team, tournament
  String skillLevel;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  GameStatus? status;

  // Stable database field for enum storage
  int? get dbStatus {
    return status?.stableId;
  }

  set dbStatus(int? value) {
    if (value == null) {
      status = null;
    } else {
      status = GameStatus.fromStableId(value);
    }
  }

  @Property(type: PropertyType.date)
  DateTime startTime;
  @Property(type: PropertyType.date)
  DateTime endTime;
  String? venueId;
  String? venueName;
  String? venueAddress;
  double? latitude;
  double? longitude;
  int capacity;
  int currentPlayers;
  List<String> playerIds;
  List<String> waitlistIds;
  double? entryFee;
  String? currency;
  List<String> rules;
  List<String> equipmentProvided;
  List<String> equipmentRequired;
  bool isPublic;
  bool allowWaitlist;
  bool requiresApproval;
  String? contactInfo;
  List<String> tags;
  String? notes;
  int? rating;
  int viewCount;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  Game({
    this.localId = 0,
    required this.id,
    required this.organizerId,
    required this.sportId,
    required this.title,
    this.description,
    required this.gameType,
    required this.skillLevel,
    GameStatus status = GameStatus.draft,
    required this.startTime,
    required this.endTime,
    this.venueId,
    this.venueName,
    this.venueAddress,
    this.latitude,
    this.longitude,
    required this.capacity,
    this.currentPlayers = 0,
    this.playerIds = const [],
    this.waitlistIds = const [],
    this.entryFee,
    this.currency,
    this.rules = const [],
    this.equipmentProvided = const [],
    this.equipmentRequired = const [],
    this.isPublic = true,
    this.allowWaitlist = false,
    this.requiresApproval = false,
    this.contactInfo,
    this.tags = const [],
    this.notes,
    this.rating,
    this.viewCount = 0,
    this.createdAt,
    this.updatedAt,
  }) {
    this.status = status;
  }

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);
}

enum GameStatus {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('draft')
  draft,
  @JsonValue('published')
  published,
  @JsonValue('full')
  full,
  @JsonValue('in_progress')
  inProgress,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case GameStatus.unknown:
        return 0;
      case GameStatus.draft:
        return 1;
      case GameStatus.published:
        return 2;
      case GameStatus.full:
        return 3;
      case GameStatus.inProgress:
        return 4;
      case GameStatus.completed:
        return 5;
      case GameStatus.cancelled:
        return 6;
    }
  }

  static GameStatus fromStableId(int id) {
    switch (id) {
      case 0:
        return GameStatus.unknown;
      case 1:
        return GameStatus.draft;
      case 2:
        return GameStatus.published;
      case 3:
        return GameStatus.full;
      case 4:
        return GameStatus.inProgress;
      case 5:
        return GameStatus.completed;
      case 6:
        return GameStatus.cancelled;
      default:
        return GameStatus.unknown;
    }
  }
}

/// Game participation/booking
@Entity()
@JsonSerializable()
class GameParticipation {
  @Id()
  int localId;

  @Unique()
  String id;
  String gameId;
  String userId;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  ParticipationStatus? status;

  // Stable database field for enum storage
  int? get dbStatus {
    return status?.stableId;
  }

  set dbStatus(int? value) {
    if (value == null) {
      status = null;
    } else {
      status = ParticipationStatus.fromStableId(value);
    }
  }

  @Property(type: PropertyType.date)
  DateTime joinedAt;
  String? position; // for team sports
  String? partnerUserId; // for doubles
  String? notes;
  double? ratingGiven;
  String? feedback;
  bool isOrganizer;
  bool isPaid;
  @Property(type: PropertyType.date)
  DateTime? paidAt;
  @Property(type: PropertyType.date)
  DateTime? leftAt;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  GameParticipation({
    this.localId = 0,
    required this.id,
    required this.gameId,
    required this.userId,
    ParticipationStatus status = ParticipationStatus.requested,
    required this.joinedAt,
    this.position,
    this.partnerUserId,
    this.notes,
    this.ratingGiven,
    this.feedback,
    this.isOrganizer = false,
    this.isPaid = false,
    this.paidAt,
    this.leftAt,
    this.createdAt,
    this.updatedAt,
  }) {
    this.status = status;
  }

  factory GameParticipation.fromJson(Map<String, dynamic> json) =>
      _$GameParticipationFromJson(json);
  Map<String, dynamic> toJson() => _$GameParticipationToJson(this);
}

enum ParticipationStatus {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('requested')
  requested,
  @JsonValue('confirmed')
  confirmed,
  @JsonValue('waitlisted')
  waitlisted,
  @JsonValue('declined')
  declined,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('attended')
  attended,
  @JsonValue('no_show')
  noShow;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case ParticipationStatus.unknown:
        return 0;
      case ParticipationStatus.requested:
        return 1;
      case ParticipationStatus.confirmed:
        return 2;
      case ParticipationStatus.waitlisted:
        return 3;
      case ParticipationStatus.declined:
        return 4;
      case ParticipationStatus.cancelled:
        return 5;
      case ParticipationStatus.attended:
        return 6;
      case ParticipationStatus.noShow:
        return 7;
    }
  }

  static ParticipationStatus fromStableId(int id) {
    switch (id) {
      case 0:
        return ParticipationStatus.unknown;
      case 1:
        return ParticipationStatus.requested;
      case 2:
        return ParticipationStatus.confirmed;
      case 3:
        return ParticipationStatus.waitlisted;
      case 4:
        return ParticipationStatus.declined;
      case 5:
        return ParticipationStatus.cancelled;
      case 6:
        return ParticipationStatus.attended;
      case 7:
        return ParticipationStatus.noShow;
      default:
        return ParticipationStatus.unknown;
    }
  }
}

/// Game invite system
@Entity()
@JsonSerializable()
class GameInvite {
  @Id()
  int localId;

  @Unique()
  String id;
  String gameId;
  String inviterId;
  String inviteeId;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  InviteStatus? status;

  // Stable database field for enum storage
  int? get dbStatus {
    return status?.stableId;
  }

  set dbStatus(int? value) {
    if (value == null) {
      status = null;
    } else {
      status = InviteStatus.fromStableId(value);
    }
  }

  String? message;
  @Property(type: PropertyType.date)
  DateTime? sentAt;
  @Property(type: PropertyType.date)
  DateTime? respondedAt;
  @Property(type: PropertyType.date)
  DateTime? expiresAt;
  String? response;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  GameInvite({
    this.localId = 0,
    required this.id,
    required this.gameId,
    required this.inviterId,
    required this.inviteeId,
    InviteStatus status = InviteStatus.pending,
    this.message,
    this.sentAt,
    this.respondedAt,
    this.expiresAt,
    this.response,
    this.createdAt,
    this.updatedAt,
  }) {
    this.status = status;
  }

  factory GameInvite.fromJson(Map<String, dynamic> json) =>
      _$GameInviteFromJson(json);
  Map<String, dynamic> toJson() => _$GameInviteToJson(this);
}

enum InviteStatus {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('declined')
  declined,
  @JsonValue('expired')
  expired,
  @JsonValue('cancelled')
  cancelled;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case InviteStatus.unknown:
        return 0;
      case InviteStatus.pending:
        return 1;
      case InviteStatus.accepted:
        return 2;
      case InviteStatus.declined:
        return 3;
      case InviteStatus.expired:
        return 4;
      case InviteStatus.cancelled:
        return 5;
    }
  }

  static InviteStatus fromStableId(int id) {
    switch (id) {
      case 0:
        return InviteStatus.unknown;
      case 1:
        return InviteStatus.pending;
      case 2:
        return InviteStatus.accepted;
      case 3:
        return InviteStatus.declined;
      case 4:
        return InviteStatus.expired;
      case 5:
        return InviteStatus.cancelled;
      default:
        return InviteStatus.unknown;
    }
  }
}
