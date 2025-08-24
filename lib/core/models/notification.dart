import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

part 'notification.g.dart';

/// Notification model for app notifications
@Entity()
@JsonSerializable()
class NotificationModel {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId;
  String title;
  String body;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  NotificationType? type;

  @Transient()
  NotificationPriority? priority;

  // Stable database fields for enum storage
  int? get dbType {
    return type?.stableId;
  }

  set dbType(int? value) {
    if (value == null) {
      type = null;
    } else {
      type = NotificationType.fromStableId(value);
    }
  }

  int? get dbPriority {
    return priority?.stableId;
  }

  set dbPriority(int? value) {
    if (value == null) {
      priority = null;
    } else {
      priority = NotificationPriority.fromStableId(value);
    }
  }

  String? imageUrl;
  String? deepLink;
  String? relatedEntityId; // gameId, trainerId, venueId, etc.
  String? relatedEntityType; // game, trainer, venue, etc.
  String? actionUrl;
  String? actionText;
  List<String> tags;
  bool isRead;
  bool isPersistent; // Should not be auto-deleted
  @Property(type: PropertyType.date)
  DateTime? readAt;
  @Property(type: PropertyType.date)
  DateTime? expiresAt;
  @Property(type: PropertyType.date)
  DateTime? scheduledAt;
  @Property(type: PropertyType.date)
  DateTime? sentAt;
  @Property(type: PropertyType.date)
  DateTime? createdAt;

  NotificationModel({
    this.localId = 0,
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    NotificationType type = NotificationType.system,
    NotificationPriority priority = NotificationPriority.normal,
    this.imageUrl,
    this.deepLink,
    this.relatedEntityId,
    this.relatedEntityType,
    this.actionUrl,
    this.actionText,
    this.tags = const [],
    this.isRead = false,
    this.isPersistent = false,
    this.readAt,
    this.expiresAt,
    this.scheduledAt,
    this.sentAt,
    this.createdAt,
  }) {
    this.type = type;
    this.priority = priority;
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}

enum NotificationType {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('system')
  system,
  @JsonValue('game_invite')
  gameInvite,
  @JsonValue('game_update')
  gameUpdate,
  @JsonValue('game_reminder')
  gameReminder,
  @JsonValue('training_booking')
  trainingBooking,
  @JsonValue('training_reminder')
  trainingReminder,
  @JsonValue('venue_booking')
  venueBooking,
  @JsonValue('venue_reminder')
  venueReminder,
  @JsonValue('friend_request')
  friendRequest,
  @JsonValue('friend_activity')
  friendActivity,
  @JsonValue('achievement')
  achievement,
  @JsonValue('promotion')
  promotion,
  @JsonValue('news')
  news,
  @JsonValue('payment')
  payment,
  @JsonValue('review_request')
  reviewRequest,
  @JsonValue('security')
  security;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case NotificationType.unknown:
        return 0;
      case NotificationType.system:
        return 1;
      case NotificationType.gameInvite:
        return 2;
      case NotificationType.gameUpdate:
        return 3;
      case NotificationType.gameReminder:
        return 4;
      case NotificationType.trainingBooking:
        return 5;
      case NotificationType.trainingReminder:
        return 6;
      case NotificationType.venueBooking:
        return 7;
      case NotificationType.venueReminder:
        return 8;
      case NotificationType.friendRequest:
        return 9;
      case NotificationType.friendActivity:
        return 10;
      case NotificationType.achievement:
        return 11;
      case NotificationType.promotion:
        return 12;
      case NotificationType.news:
        return 13;
      case NotificationType.payment:
        return 14;
      case NotificationType.reviewRequest:
        return 15;
      case NotificationType.security:
        return 16;
    }
  }

  static NotificationType fromStableId(int id) {
    switch (id) {
      case 0:
        return NotificationType.unknown;
      case 1:
        return NotificationType.system;
      case 2:
        return NotificationType.gameInvite;
      case 3:
        return NotificationType.gameUpdate;
      case 4:
        return NotificationType.gameReminder;
      case 5:
        return NotificationType.trainingBooking;
      case 6:
        return NotificationType.trainingReminder;
      case 7:
        return NotificationType.venueBooking;
      case 8:
        return NotificationType.venueReminder;
      case 9:
        return NotificationType.friendRequest;
      case 10:
        return NotificationType.friendActivity;
      case 11:
        return NotificationType.achievement;
      case 12:
        return NotificationType.promotion;
      case 13:
        return NotificationType.news;
      case 14:
        return NotificationType.payment;
      case 15:
        return NotificationType.reviewRequest;
      case 16:
        return NotificationType.security;
      default:
        return NotificationType.unknown;
    }
  }
}

enum NotificationPriority {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('low')
  low,
  @JsonValue('normal')
  normal,
  @JsonValue('high')
  high,
  @JsonValue('urgent')
  urgent;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case NotificationPriority.unknown:
        return 0;
      case NotificationPriority.low:
        return 1;
      case NotificationPriority.normal:
        return 2;
      case NotificationPriority.high:
        return 3;
      case NotificationPriority.urgent:
        return 4;
    }
  }

  static NotificationPriority fromStableId(int id) {
    switch (id) {
      case 0:
        return NotificationPriority.unknown;
      case 1:
        return NotificationPriority.low;
      case 2:
        return NotificationPriority.normal;
      case 3:
        return NotificationPriority.high;
      case 4:
        return NotificationPriority.urgent;
      default:
        return NotificationPriority.unknown;
    }
  }
}

/// Push notification settings for users
@Entity()
@JsonSerializable()
class NotificationSettings {
  @Id()
  int localId;

  @Unique()
  String userId;

  // Global settings
  bool pushEnabled;
  bool emailEnabled;
  bool inAppEnabled;

  // Category-specific settings
  bool gameNotifications;
  bool trainingNotifications;
  bool venueNotifications;
  bool socialNotifications;
  bool promotionalNotifications;
  bool securityNotifications;

  // Timing preferences
  String? quietHoursStart; // HH:mm format
  String? quietHoursEnd; // HH:mm format
  List<String> enabledDays; // Monday, Tuesday, etc.

  // Device tokens for push notifications
  String? fcmToken;
  String? apnsToken;
  String? deviceId;
  String? platform; // ios, android, web

  @Property(type: PropertyType.date)
  DateTime? lastUpdated;
  @Property(type: PropertyType.date)
  DateTime? createdAt;

  NotificationSettings({
    this.localId = 0,
    required this.userId,
    this.pushEnabled = true,
    this.emailEnabled = true,
    this.inAppEnabled = true,
    this.gameNotifications = true,
    this.trainingNotifications = true,
    this.venueNotifications = true,
    this.socialNotifications = true,
    this.promotionalNotifications = false,
    this.securityNotifications = true,
    this.quietHoursStart,
    this.quietHoursEnd,
    this.enabledDays = const [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ],
    this.fcmToken,
    this.apnsToken,
    this.deviceId,
    this.platform,
    this.lastUpdated,
    this.createdAt,
  });

  factory NotificationSettings.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationSettingsToJson(this);
}

/// Message model for in-app messaging
@Entity()
@JsonSerializable()
class Message {
  @Id()
  int localId;

  @Unique()
  String id;
  String? conversationId;
  String senderId;
  String receiverId;
  String content;

  // Store enum as stable int for ObjectBox compatibility
  @Transient()
  MessageType? type;

  // Stable database field for enum storage
  int? get dbType {
    return type?.stableId;
  }

  set dbType(int? value) {
    if (value == null) {
      type = null;
    } else {
      type = MessageType.fromStableId(value);
    }
  }

  String? replyToId; // Message being replied to
  List<String> attachments; // URLs to images, files
  String? relatedEntityId; // gameId, trainerId, etc.
  String? relatedEntityType;
  bool isRead;
  bool isDelivered;
  bool isSystem; // System generated message
  @Property(type: PropertyType.date)
  DateTime? readAt;
  @Property(type: PropertyType.date)
  DateTime? deliveredAt;
  @Property(type: PropertyType.date)
  DateTime? editedAt;
  @Property(type: PropertyType.date)
  DateTime? deletedAt;
  @Property(type: PropertyType.date)
  DateTime? createdAt;

  Message({
    this.localId = 0,
    required this.id,
    this.conversationId,
    required this.senderId,
    required this.receiverId,
    required this.content,
    MessageType type = MessageType.text,
    this.replyToId,
    this.attachments = const [],
    this.relatedEntityId,
    this.relatedEntityType,
    this.isRead = false,
    this.isDelivered = false,
    this.isSystem = false,
    this.readAt,
    this.deliveredAt,
    this.editedAt,
    this.deletedAt,
    this.createdAt,
  }) {
    this.type = type;
  }

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

enum MessageType {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('file')
  file,
  @JsonValue('location')
  location,
  @JsonValue('system')
  system,
  @JsonValue('game_invite')
  gameInvite,
  @JsonValue('training_booking')
  trainingBooking;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case MessageType.unknown:
        return 0;
      case MessageType.text:
        return 1;
      case MessageType.image:
        return 2;
      case MessageType.file:
        return 3;
      case MessageType.location:
        return 4;
      case MessageType.system:
        return 5;
      case MessageType.gameInvite:
        return 6;
      case MessageType.trainingBooking:
        return 7;
    }
  }

  static MessageType fromStableId(int id) {
    switch (id) {
      case 0:
        return MessageType.unknown;
      case 1:
        return MessageType.text;
      case 2:
        return MessageType.image;
      case 3:
        return MessageType.file;
      case 4:
        return MessageType.location;
      case 5:
        return MessageType.system;
      case 6:
        return MessageType.gameInvite;
      case 7:
        return MessageType.trainingBooking;
      default:
        return MessageType.unknown;
    }
  }
}

/// Conversation model for organizing messages
@Entity()
@JsonSerializable()
class Conversation {
  @Id()
  int localId;

  @Unique()
  String id;
  List<String> participantIds;
  String? name; // Group name if applicable
  String? description;
  String? imageUrl;
  bool isGroup;
  String? lastMessageId;
  String? lastMessageContent;
  @Property(type: PropertyType.date)
  DateTime? lastMessageAt;
  String? lastMessageSenderId;
  int unreadCount;
  bool isMuted;
  bool isArchived;
  String? relatedEntityId; // gameId, trainerId for context
  String? relatedEntityType;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  Conversation({
    this.localId = 0,
    required this.id,
    required this.participantIds,
    this.name,
    this.description,
    this.imageUrl,
    this.isGroup = false,
    this.lastMessageId,
    this.lastMessageContent,
    this.lastMessageAt,
    this.lastMessageSenderId,
    this.unreadCount = 0,
    this.isMuted = false,
    this.isArchived = false,
    this.relatedEntityId,
    this.relatedEntityType,
    this.createdAt,
    this.updatedAt,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}

/// Payment model
@Entity()
@JsonSerializable()
class Payment {
  @Id()
  int localId;

  @Unique()
  String id;
  String userId;
  String sourceId; // bookingId, sessionId, gameId
  String sourceType; // booking, session, game
  double amount;
  String? currency;

  // Store enums as stable int for ObjectBox compatibility
  @Transient()
  PaymentStatus? status;

  @Transient()
  PaymentMethod? method;

  // Stable database fields for enum storage
  int? get dbStatus {
    return status?.stableId;
  }

  set dbStatus(int? value) {
    if (value == null) {
      status = null;
    } else {
      status = PaymentStatus.fromStableId(value);
    }
  }

  int? get dbMethod {
    return method?.stableId;
  }

  set dbMethod(int? value) {
    if (value == null) {
      method = null;
    } else {
      method = PaymentMethod.fromStableId(value);
    }
  }

  String? gatewayTransactionId;
  String? gatewayOrderId;
  String? gatewayPaymentId;
  String? description;
  double? fees;
  double? taxes;
  double? netAmount;
  String? failureReason;
  @Property(type: PropertyType.date)
  DateTime? initiatedAt;
  @Property(type: PropertyType.date)
  DateTime? succeededAt;
  @Property(type: PropertyType.date)
  DateTime? failedAt;
  @Property(type: PropertyType.date)
  DateTime? refundedAt;
  double? refundAmount;
  String? refundReason;
  @Property(type: PropertyType.date)
  DateTime? createdAt;
  @Property(type: PropertyType.date)
  DateTime? updatedAt;

  Payment({
    this.localId = 0,
    required this.id,
    required this.userId,
    required this.sourceId,
    required this.sourceType,
    required this.amount,
    this.currency,
    PaymentStatus status = PaymentStatus.pending,
    PaymentMethod method = PaymentMethod.card,
    this.gatewayTransactionId,
    this.gatewayOrderId,
    this.gatewayPaymentId,
    this.description,
    this.fees,
    this.taxes,
    this.netAmount,
    this.failureReason,
    this.initiatedAt,
    this.succeededAt,
    this.failedAt,
    this.refundedAt,
    this.refundAmount,
    this.refundReason,
    this.createdAt,
    this.updatedAt,
  }) {
    this.status = status;
    this.method = method;
  }

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentToJson(this);
}

enum PaymentStatus {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('succeeded')
  succeeded,
  @JsonValue('failed')
  failed,
  @JsonValue('cancelled')
  cancelled,
  @JsonValue('refunded')
  refunded,
  @JsonValue('partially_refunded')
  partiallyRefunded;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case PaymentStatus.unknown:
        return 0;
      case PaymentStatus.pending:
        return 1;
      case PaymentStatus.processing:
        return 2;
      case PaymentStatus.succeeded:
        return 3;
      case PaymentStatus.failed:
        return 4;
      case PaymentStatus.cancelled:
        return 5;
      case PaymentStatus.refunded:
        return 6;
      case PaymentStatus.partiallyRefunded:
        return 7;
    }
  }

  static PaymentStatus fromStableId(int id) {
    switch (id) {
      case 0:
        return PaymentStatus.unknown;
      case 1:
        return PaymentStatus.pending;
      case 2:
        return PaymentStatus.processing;
      case 3:
        return PaymentStatus.succeeded;
      case 4:
        return PaymentStatus.failed;
      case 5:
        return PaymentStatus.cancelled;
      case 6:
        return PaymentStatus.refunded;
      case 7:
        return PaymentStatus.partiallyRefunded;
      default:
        return PaymentStatus.unknown;
    }
  }
}

enum PaymentMethod {
  @JsonValue('unknown')
  unknown, // Default for handling unknown values
  @JsonValue('card')
  card,
  @JsonValue('upi')
  upi,
  @JsonValue('netbanking')
  netbanking,
  @JsonValue('wallet')
  wallet,
  @JsonValue('cash')
  cash,
  @JsonValue('bank_transfer')
  bankTransfer;

  // Stable enum ID mapping for ObjectBox persistence
  int get stableId {
    switch (this) {
      case PaymentMethod.unknown:
        return 0;
      case PaymentMethod.card:
        return 1;
      case PaymentMethod.upi:
        return 2;
      case PaymentMethod.netbanking:
        return 3;
      case PaymentMethod.wallet:
        return 4;
      case PaymentMethod.cash:
        return 5;
      case PaymentMethod.bankTransfer:
        return 6;
    }
  }

  static PaymentMethod fromStableId(int id) {
    switch (id) {
      case 0:
        return PaymentMethod.unknown;
      case 1:
        return PaymentMethod.card;
      case 2:
        return PaymentMethod.upi;
      case 3:
        return PaymentMethod.netbanking;
      case 4:
        return PaymentMethod.wallet;
      case 5:
        return PaymentMethod.cash;
      case 6:
        return PaymentMethod.bankTransfer;
      default:
        return PaymentMethod.unknown;
    }
  }
}
