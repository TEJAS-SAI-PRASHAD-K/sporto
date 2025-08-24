// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
        localId: (json['localId'] as num?)?.toInt() ?? 0,
        id: json['id'] as String,
        userId: json['userId'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        type:
            $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']) ??
            NotificationType.system,
        priority:
            $enumDecodeNullable(
              _$NotificationPriorityEnumMap,
              json['priority'],
            ) ??
            NotificationPriority.normal,
        imageUrl: json['imageUrl'] as String?,
        deepLink: json['deepLink'] as String?,
        relatedEntityId: json['relatedEntityId'] as String?,
        relatedEntityType: json['relatedEntityType'] as String?,
        actionUrl: json['actionUrl'] as String?,
        actionText: json['actionText'] as String?,
        tags:
            (json['tags'] as List<dynamic>?)
                ?.map((e) => e as String)
                .toList() ??
            const [],
        isRead: json['isRead'] as bool? ?? false,
        isPersistent: json['isPersistent'] as bool? ?? false,
        readAt: json['readAt'] == null
            ? null
            : DateTime.parse(json['readAt'] as String),
        expiresAt: json['expiresAt'] == null
            ? null
            : DateTime.parse(json['expiresAt'] as String),
        scheduledAt: json['scheduledAt'] == null
            ? null
            : DateTime.parse(json['scheduledAt'] as String),
        sentAt: json['sentAt'] == null
            ? null
            : DateTime.parse(json['sentAt'] as String),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
      )
      ..dbType = (json['dbType'] as num?)?.toInt()
      ..dbPriority = (json['dbPriority'] as num?)?.toInt();

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'body': instance.body,
      'type': _$NotificationTypeEnumMap[instance.type],
      'priority': _$NotificationPriorityEnumMap[instance.priority],
      'dbType': instance.dbType,
      'dbPriority': instance.dbPriority,
      'imageUrl': instance.imageUrl,
      'deepLink': instance.deepLink,
      'relatedEntityId': instance.relatedEntityId,
      'relatedEntityType': instance.relatedEntityType,
      'actionUrl': instance.actionUrl,
      'actionText': instance.actionText,
      'tags': instance.tags,
      'isRead': instance.isRead,
      'isPersistent': instance.isPersistent,
      'readAt': instance.readAt?.toIso8601String(),
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'scheduledAt': instance.scheduledAt?.toIso8601String(),
      'sentAt': instance.sentAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$NotificationTypeEnumMap = {
  NotificationType.unknown: 'unknown',
  NotificationType.system: 'system',
  NotificationType.gameInvite: 'game_invite',
  NotificationType.gameUpdate: 'game_update',
  NotificationType.gameReminder: 'game_reminder',
  NotificationType.trainingBooking: 'training_booking',
  NotificationType.trainingReminder: 'training_reminder',
  NotificationType.venueBooking: 'venue_booking',
  NotificationType.venueReminder: 'venue_reminder',
  NotificationType.friendRequest: 'friend_request',
  NotificationType.friendActivity: 'friend_activity',
  NotificationType.achievement: 'achievement',
  NotificationType.promotion: 'promotion',
  NotificationType.news: 'news',
  NotificationType.payment: 'payment',
  NotificationType.reviewRequest: 'review_request',
  NotificationType.security: 'security',
};

const _$NotificationPriorityEnumMap = {
  NotificationPriority.unknown: 'unknown',
  NotificationPriority.low: 'low',
  NotificationPriority.normal: 'normal',
  NotificationPriority.high: 'high',
  NotificationPriority.urgent: 'urgent',
};

NotificationSettings _$NotificationSettingsFromJson(
  Map<String, dynamic> json,
) => NotificationSettings(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  userId: json['userId'] as String,
  pushEnabled: json['pushEnabled'] as bool? ?? true,
  emailEnabled: json['emailEnabled'] as bool? ?? true,
  inAppEnabled: json['inAppEnabled'] as bool? ?? true,
  gameNotifications: json['gameNotifications'] as bool? ?? true,
  trainingNotifications: json['trainingNotifications'] as bool? ?? true,
  venueNotifications: json['venueNotifications'] as bool? ?? true,
  socialNotifications: json['socialNotifications'] as bool? ?? true,
  promotionalNotifications: json['promotionalNotifications'] as bool? ?? false,
  securityNotifications: json['securityNotifications'] as bool? ?? true,
  quietHoursStart: json['quietHoursStart'] as String?,
  quietHoursEnd: json['quietHoursEnd'] as String?,
  enabledDays:
      (json['enabledDays'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday',
      ],
  fcmToken: json['fcmToken'] as String?,
  apnsToken: json['apnsToken'] as String?,
  deviceId: json['deviceId'] as String?,
  platform: json['platform'] as String?,
  lastUpdated: json['lastUpdated'] == null
      ? null
      : DateTime.parse(json['lastUpdated'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$NotificationSettingsToJson(
  NotificationSettings instance,
) => <String, dynamic>{
  'localId': instance.localId,
  'userId': instance.userId,
  'pushEnabled': instance.pushEnabled,
  'emailEnabled': instance.emailEnabled,
  'inAppEnabled': instance.inAppEnabled,
  'gameNotifications': instance.gameNotifications,
  'trainingNotifications': instance.trainingNotifications,
  'venueNotifications': instance.venueNotifications,
  'socialNotifications': instance.socialNotifications,
  'promotionalNotifications': instance.promotionalNotifications,
  'securityNotifications': instance.securityNotifications,
  'quietHoursStart': instance.quietHoursStart,
  'quietHoursEnd': instance.quietHoursEnd,
  'enabledDays': instance.enabledDays,
  'fcmToken': instance.fcmToken,
  'apnsToken': instance.apnsToken,
  'deviceId': instance.deviceId,
  'platform': instance.platform,
  'lastUpdated': instance.lastUpdated?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
};

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  conversationId: json['conversationId'] as String?,
  senderId: json['senderId'] as String,
  receiverId: json['receiverId'] as String,
  content: json['content'] as String,
  type:
      $enumDecodeNullable(_$MessageTypeEnumMap, json['type']) ??
      MessageType.text,
  replyToId: json['replyToId'] as String?,
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  relatedEntityId: json['relatedEntityId'] as String?,
  relatedEntityType: json['relatedEntityType'] as String?,
  isRead: json['isRead'] as bool? ?? false,
  isDelivered: json['isDelivered'] as bool? ?? false,
  isSystem: json['isSystem'] as bool? ?? false,
  readAt: json['readAt'] == null
      ? null
      : DateTime.parse(json['readAt'] as String),
  deliveredAt: json['deliveredAt'] == null
      ? null
      : DateTime.parse(json['deliveredAt'] as String),
  editedAt: json['editedAt'] == null
      ? null
      : DateTime.parse(json['editedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
)..dbType = (json['dbType'] as num?)?.toInt();

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'localId': instance.localId,
  'id': instance.id,
  'conversationId': instance.conversationId,
  'senderId': instance.senderId,
  'receiverId': instance.receiverId,
  'content': instance.content,
  'type': _$MessageTypeEnumMap[instance.type],
  'dbType': instance.dbType,
  'replyToId': instance.replyToId,
  'attachments': instance.attachments,
  'relatedEntityId': instance.relatedEntityId,
  'relatedEntityType': instance.relatedEntityType,
  'isRead': instance.isRead,
  'isDelivered': instance.isDelivered,
  'isSystem': instance.isSystem,
  'readAt': instance.readAt?.toIso8601String(),
  'deliveredAt': instance.deliveredAt?.toIso8601String(),
  'editedAt': instance.editedAt?.toIso8601String(),
  'deletedAt': instance.deletedAt?.toIso8601String(),
  'createdAt': instance.createdAt?.toIso8601String(),
};

const _$MessageTypeEnumMap = {
  MessageType.unknown: 'unknown',
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.file: 'file',
  MessageType.location: 'location',
  MessageType.system: 'system',
  MessageType.gameInvite: 'game_invite',
  MessageType.trainingBooking: 'training_booking',
};

Conversation _$ConversationFromJson(Map<String, dynamic> json) => Conversation(
  localId: (json['localId'] as num?)?.toInt() ?? 0,
  id: json['id'] as String,
  participantIds: (json['participantIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  name: json['name'] as String?,
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String?,
  isGroup: json['isGroup'] as bool? ?? false,
  lastMessageId: json['lastMessageId'] as String?,
  lastMessageContent: json['lastMessageContent'] as String?,
  lastMessageAt: json['lastMessageAt'] == null
      ? null
      : DateTime.parse(json['lastMessageAt'] as String),
  lastMessageSenderId: json['lastMessageSenderId'] as String?,
  unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
  isMuted: json['isMuted'] as bool? ?? false,
  isArchived: json['isArchived'] as bool? ?? false,
  relatedEntityId: json['relatedEntityId'] as String?,
  relatedEntityType: json['relatedEntityType'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$ConversationToJson(Conversation instance) =>
    <String, dynamic>{
      'localId': instance.localId,
      'id': instance.id,
      'participantIds': instance.participantIds,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'isGroup': instance.isGroup,
      'lastMessageId': instance.lastMessageId,
      'lastMessageContent': instance.lastMessageContent,
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
      'lastMessageSenderId': instance.lastMessageSenderId,
      'unreadCount': instance.unreadCount,
      'isMuted': instance.isMuted,
      'isArchived': instance.isArchived,
      'relatedEntityId': instance.relatedEntityId,
      'relatedEntityType': instance.relatedEntityType,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) =>
    Payment(
        localId: (json['localId'] as num?)?.toInt() ?? 0,
        id: json['id'] as String,
        userId: json['userId'] as String,
        sourceId: json['sourceId'] as String,
        sourceType: json['sourceType'] as String,
        amount: (json['amount'] as num).toDouble(),
        currency: json['currency'] as String?,
        status:
            $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']) ??
            PaymentStatus.pending,
        method:
            $enumDecodeNullable(_$PaymentMethodEnumMap, json['method']) ??
            PaymentMethod.card,
        gatewayTransactionId: json['gatewayTransactionId'] as String?,
        gatewayOrderId: json['gatewayOrderId'] as String?,
        gatewayPaymentId: json['gatewayPaymentId'] as String?,
        description: json['description'] as String?,
        fees: (json['fees'] as num?)?.toDouble(),
        taxes: (json['taxes'] as num?)?.toDouble(),
        netAmount: (json['netAmount'] as num?)?.toDouble(),
        failureReason: json['failureReason'] as String?,
        initiatedAt: json['initiatedAt'] == null
            ? null
            : DateTime.parse(json['initiatedAt'] as String),
        succeededAt: json['succeededAt'] == null
            ? null
            : DateTime.parse(json['succeededAt'] as String),
        failedAt: json['failedAt'] == null
            ? null
            : DateTime.parse(json['failedAt'] as String),
        refundedAt: json['refundedAt'] == null
            ? null
            : DateTime.parse(json['refundedAt'] as String),
        refundAmount: (json['refundAmount'] as num?)?.toDouble(),
        refundReason: json['refundReason'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      )
      ..dbStatus = (json['dbStatus'] as num?)?.toInt()
      ..dbMethod = (json['dbMethod'] as num?)?.toInt();

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
  'localId': instance.localId,
  'id': instance.id,
  'userId': instance.userId,
  'sourceId': instance.sourceId,
  'sourceType': instance.sourceType,
  'amount': instance.amount,
  'currency': instance.currency,
  'status': _$PaymentStatusEnumMap[instance.status],
  'method': _$PaymentMethodEnumMap[instance.method],
  'dbStatus': instance.dbStatus,
  'dbMethod': instance.dbMethod,
  'gatewayTransactionId': instance.gatewayTransactionId,
  'gatewayOrderId': instance.gatewayOrderId,
  'gatewayPaymentId': instance.gatewayPaymentId,
  'description': instance.description,
  'fees': instance.fees,
  'taxes': instance.taxes,
  'netAmount': instance.netAmount,
  'failureReason': instance.failureReason,
  'initiatedAt': instance.initiatedAt?.toIso8601String(),
  'succeededAt': instance.succeededAt?.toIso8601String(),
  'failedAt': instance.failedAt?.toIso8601String(),
  'refundedAt': instance.refundedAt?.toIso8601String(),
  'refundAmount': instance.refundAmount,
  'refundReason': instance.refundReason,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.unknown: 'unknown',
  PaymentStatus.pending: 'pending',
  PaymentStatus.processing: 'processing',
  PaymentStatus.succeeded: 'succeeded',
  PaymentStatus.failed: 'failed',
  PaymentStatus.cancelled: 'cancelled',
  PaymentStatus.refunded: 'refunded',
  PaymentStatus.partiallyRefunded: 'partially_refunded',
};

const _$PaymentMethodEnumMap = {
  PaymentMethod.unknown: 'unknown',
  PaymentMethod.card: 'card',
  PaymentMethod.upi: 'upi',
  PaymentMethod.netbanking: 'netbanking',
  PaymentMethod.wallet: 'wallet',
  PaymentMethod.cash: 'cash',
  PaymentMethod.bankTransfer: 'bank_transfer',
};
