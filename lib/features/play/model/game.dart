import 'package:flutter/material.dart';

@immutable
class Game {
  final String id;
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

  const Game({
    required this.id,
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
  });
}
