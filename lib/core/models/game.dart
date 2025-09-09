import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';

part 'game.g.dart';

// Enums for booking functionality
enum BookingStatus { pending, confirmed, cancelled, completed }

enum PaymentSplit { fullAdvance, halfAdvance, venueOnly, custom }

@JsonSerializable()
class Game {
  @JsonKey(name: 'game_id')
  String gameId;

  @JsonKey(name: 'organiser_user_id')
  String organiserUserId;

  @JsonKey(name: 'sport_id')
  String sportId;

  @JsonKey(name: 'area_of_game')
  String? areaOfGame;

  @JsonKey(name: 'game_date')
  DateTime? gameDate; // Date only

  @JsonKey(name: 'game_time')
  String? gameTime; // store as HH:mm:ss

  @JsonKey(name: 'game_access_type')
  String? gameAccessType; // Public, Invite Only

  @JsonKey(name: 'current_players_count')
  int? currentPlayersCount;

  @JsonKey(name: 'venue_name')
  String? venueName;

  @JsonKey(name: 'venue_id')
  String? venueId;

  @JsonKey(name: 'venue_address')
  String? venueAddress;

  @JsonKey(name: 'venue_latitude')
  double? venueLatitude;

  @JsonKey(name: 'venue_longitude')
  double? venueLongitude;

  @JsonKey(name: 'player_ids')
  List<String>? playerIds;

  @JsonKey(name: 'waitlist_user_ids')
  List<String>? waitlistUserIds;

  @JsonKey(name: 'game_rules')
  String? gameRules;

  @JsonKey(name: 'equipment_required')
  String? equipmentRequired;

  @JsonKey(name: 'equipment_provided')
  String? equipmentProvided;

  @JsonKey(name: 'requires_approval')
  bool requiresApproval;

  @JsonKey(name: 'contact_information')
  String? contactInformation;

  String? notes;

  @JsonKey(name: 'view_count')
  int viewCount;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  @JsonKey(name: 'venue_partner_id')
  String? venuePartnerId;

  // Booking-related fields
  @JsonKey(name: 'court_id')
  String? courtId;

  @JsonKey(name: 'court_name')
  String? courtName;

  @JsonKey(name: 'hourly_rate')
  double? hourlyRate;

  @JsonKey(name: 'booking_id')
  String? bookingId;

  @JsonKey(name: 'booking_status')
  BookingStatus? bookingStatus;

  @JsonKey(name: 'convenience_fee')
  double? convenienceFee;

  @JsonKey(name: 'is_karma_redeem_enabled')
  bool? isKarmaRedeemEnabled;

  @JsonKey(name: 'coupon_code')
  String? couponCode;

  @JsonKey(name: 'coupon_discount')
  double? couponDiscount;

  @JsonKey(name: 'karma_points')
  double? karmaPoints;

  @JsonKey(name: 'karma_value')
  double? karmaValue;

  @JsonKey(name: 'payment_split')
  PaymentSplit? paymentSplit;

  Game({
    required this.gameId,
    required this.organiserUserId,
    required this.sportId,
    this.areaOfGame,
    this.gameDate,
    this.gameTime,
    this.gameAccessType,
    this.currentPlayersCount,
    this.venueName,
    this.venueId,
    this.venueAddress,
    this.venueLatitude,
    this.venueLongitude,
    this.playerIds,
    this.waitlistUserIds,
    this.gameRules,
    this.equipmentRequired,
    this.equipmentProvided,
    this.requiresApproval = false,
    this.contactInformation,
    this.notes,
    this.viewCount = 0,
    this.createdAt,
    this.updatedAt,
    this.venuePartnerId,
    // Booking-related parameters
    this.courtId,
    this.courtName,
    this.hourlyRate,
    this.bookingId,
    this.bookingStatus,
    this.convenienceFee,
    this.isKarmaRedeemEnabled,
    this.couponCode,
    this.couponDiscount,
    this.karmaPoints,
    this.karmaValue,
    this.paymentSplit,
  });

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);
  Map<String, dynamic> toJson() => _$GameToJson(this);

  // Booking-related computed properties
  double get courtPrice => hourlyRate ?? 0.0;

  double get totalAmount {
    final baseAmount = courtPrice + (convenienceFee ?? 0.0);
    final afterCoupon = baseAmount - (couponDiscount ?? 0.0);
    final afterKarma = isKarmaRedeemEnabled == true
        ? afterCoupon - (karmaValue ?? 0.0)
        : afterCoupon;
    return afterKarma > 0 ? afterKarma : 0.0;
  }

  double get advancePayable {
    switch (paymentSplit) {
      case PaymentSplit.fullAdvance:
        return totalAmount;
      case PaymentSplit.halfAdvance:
        return totalAmount * 0.5;
      case PaymentSplit.venueOnly:
        return 0.0;
      case PaymentSplit.custom:
        return totalAmount * 0.3; // Default 30% for custom
      case null:
        return totalAmount * 0.5; // Default to half advance
    }
  }

  double get toBePayedAtVenue => totalAmount - advancePayable;

  String get formattedDate {
    if (gameDate == null) return 'Date TBD';

    final date = gameDate!;
    final day = date.day;
    final suffix = _getDaySuffix(day);
    final months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    return '$day$suffix ${months[date.month]}, ${date.year}';
  }

  String _getDaySuffix(int day) {
    if (day >= 11 && day <= 13) return 'th';
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  String get formattedTimeSlot {
    if (gameTime == null) return 'Time TBD';

    // Assuming gameTime is in HH:mm:ss format
    final timeParts = gameTime!.split(':');
    if (timeParts.length >= 2) {
      final hour = int.parse(timeParts[0]);
      final minute = int.parse(timeParts[1]);
      final startTime = TimeOfDay(hour: hour, minute: minute);

      // Assuming 1 hour duration for now - this could be made configurable
      final endHour = (hour + 1) % 24;
      final endTime = TimeOfDay(hour: endHour, minute: minute);

      return '${_formatTime(startTime)} to ${_formatTime(endTime)}';
    }
    return gameTime!;
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  // Factory constructor for booking creation
  factory Game.forBooking({
    required String gameId,
    required String organiserUserId,
    required String sportId,
    required DateTime gameDate,
    required String gameTime,
    required String venueName,
    required String venueId,
    required String venueAddress,
    required double venueLatitude,
    required double venueLongitude,
    required String courtId,
    required String courtName,
    required double hourlyRate,
    String? bookingId,
    BookingStatus bookingStatus = BookingStatus.pending,
    double convenienceFee = 0.0,
    bool isKarmaRedeemEnabled = false,
    String? couponCode,
    double couponDiscount = 0.0,
    double karmaPoints = 0.0,
    PaymentSplit paymentSplit = PaymentSplit.halfAdvance,
  }) {
    return Game(
      gameId: gameId,
      organiserUserId: organiserUserId,
      sportId: sportId,
      gameDate: gameDate,
      gameTime: gameTime,
      venueName: venueName,
      venueId: venueId,
      venueAddress: venueAddress,
      venueLatitude: venueLatitude,
      venueLongitude: venueLongitude,
      courtId: courtId,
      courtName: courtName,
      hourlyRate: hourlyRate,
      bookingId: bookingId,
      bookingStatus: bookingStatus,
      convenienceFee: convenienceFee,
      isKarmaRedeemEnabled: isKarmaRedeemEnabled,
      couponCode: couponCode,
      couponDiscount: couponDiscount,
      karmaPoints: karmaPoints,
      karmaValue: karmaPoints * 0.01, // 1 karma point = $0.01
      paymentSplit: paymentSplit,
    );
  }
}

@JsonSerializable()
class GameInvite {
  @JsonKey(name: 'invite_id')
  String inviteId;

  @JsonKey(name: 'game_id')
  String gameId;

  @JsonKey(name: 'inviter_user_id')
  String inviterUserId;

  @JsonKey(name: 'invitee_user_id')
  String inviteeUserId;

  @JsonKey(name: 'invite_status')
  String? inviteStatus; // Pending, Accepted, Rejected, Expired

  @JsonKey(name: 'sent_at')
  DateTime? sentAt;

  @JsonKey(name: 'responded_at')
  DateTime? respondedAt;

  @JsonKey(name: 'expires_at')
  DateTime? expiresAt;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  GameInvite({
    required this.inviteId,
    required this.gameId,
    required this.inviterUserId,
    required this.inviteeUserId,
    this.inviteStatus,
    this.sentAt,
    this.respondedAt,
    this.expiresAt,
    this.createdAt,
    this.updatedAt,
  });

  factory GameInvite.fromJson(Map<String, dynamic> json) =>
      _$GameInviteFromJson(json);
  Map<String, dynamic> toJson() => _$GameInviteToJson(this);
}

@JsonSerializable()
class GameParticipation {
  @JsonKey(name: 'participation_id')
  String participationId;

  @JsonKey(name: 'game_id')
  String gameId;

  @JsonKey(name: 'user_id')
  String userId;

  @JsonKey(name: 'participation_status')
  String? participationStatus; // Joined, Waitlisted, Cancelled

  @JsonKey(name: 'joined_at')
  DateTime? joinedAt;

  @JsonKey(name: 'is_organiser')
  bool isOrganiser;

  @JsonKey(name: 'has_paid')
  bool hasPaid;

  @JsonKey(name: 'paid_at')
  DateTime? paidAt;

  @JsonKey(name: 'left_at')
  DateTime? leftAt;

  @JsonKey(name: 'created_at')
  DateTime? createdAt;

  @JsonKey(name: 'updated_at')
  DateTime? updatedAt;

  GameParticipation({
    required this.participationId,
    required this.gameId,
    required this.userId,
    this.participationStatus,
    this.joinedAt,
    this.isOrganiser = false,
    this.hasPaid = false,
    this.paidAt,
    this.leftAt,
    this.createdAt,
    this.updatedAt,
  });

  factory GameParticipation.fromJson(Map<String, dynamic> json) =>
      _$GameParticipationFromJson(json);
  Map<String, dynamic> toJson() => _$GameParticipationToJson(this);
}
