import 'package:flutter/material.dart';

@immutable
class Game {
  final String id;
  // Optional backing id for sport in DB
  final String? sportId; // Supabase sports.sport_id
  final String sport; // e.g., Badminton
  final String type; // e.g., Doubles / Regular
  final String organizerName;
  final DateTime startTime;
  final DateTime endTime;
  final String venue;
  final double distanceKm;
  final int goingCount;
  final int capacity;
  final String levelLabel; // e.g., "Intermediate - Professional"
  final bool mustHaveSkill; // MH badge in screenshots
  final bool booked;
  // Optional image for the sport (for avatars/cards in Upcoming)
  final String? sportImageUrl;
  // New optional fields for instructions/payment/privacy
  final bool isPublic;
  final bool payAndJoin;
  final double? costPerPlayer;
  final int? totalPlayers;
  final bool costShared;
  final bool bringYourOwnEquipment;
  final String? instructionsNote;

  const Game({
    required this.id,
    this.sportId,
    required this.sport,
    required this.type,
    required this.organizerName,
    required this.startTime,
    required this.endTime,
    required this.venue,
    required this.distanceKm,
    required this.goingCount,
    required this.capacity,
    required this.levelLabel,
    this.mustHaveSkill = false,
    this.booked = false,
    this.sportImageUrl,
    this.isPublic = true,
    this.payAndJoin = false,
    this.costPerPlayer,
    this.totalPlayers,
    this.costShared = false,
    this.bringYourOwnEquipment = false,
    this.instructionsNote,
  });

  Game copyWith({
    String? id,
    String? sportId,
    String? sport,
    String? type,
    String? organizerName,
    DateTime? startTime,
    DateTime? endTime,
    String? venue,
    double? distanceKm,
    int? goingCount,
    int? capacity,
    String? levelLabel,
    bool? mustHaveSkill,
    bool? booked,
    String? sportImageUrl,
    bool? isPublic,
    bool? payAndJoin,
    double? costPerPlayer,
    int? totalPlayers,
    bool? costShared,
    bool? bringYourOwnEquipment,
    String? instructionsNote,
  }) {
    return Game(
      id: id ?? this.id,
      sportId: sportId ?? this.sportId,
      sport: sport ?? this.sport,
      type: type ?? this.type,
      organizerName: organizerName ?? this.organizerName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      venue: venue ?? this.venue,
      distanceKm: distanceKm ?? this.distanceKm,
      goingCount: goingCount ?? this.goingCount,
      capacity: capacity ?? this.capacity,
      levelLabel: levelLabel ?? this.levelLabel,
      mustHaveSkill: mustHaveSkill ?? this.mustHaveSkill,
      booked: booked ?? this.booked,
      sportImageUrl: sportImageUrl ?? this.sportImageUrl,
      isPublic: isPublic ?? this.isPublic,
      payAndJoin: payAndJoin ?? this.payAndJoin,
      costPerPlayer: costPerPlayer ?? this.costPerPlayer,
      totalPlayers: totalPlayers ?? this.totalPlayers,
      costShared: costShared ?? this.costShared,
      bringYourOwnEquipment:
          bringYourOwnEquipment ?? this.bringYourOwnEquipment,
      instructionsNote: instructionsNote ?? this.instructionsNote,
    );
  }
}
