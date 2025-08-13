import 'package:flutter/foundation.dart';

/// Data model for venue details displayed on the booking details page.
@immutable
class VenueDetails {
  final String name;
  final String imageAsset;
  final String timings;
  final String location;
  final double rating;
  final double distanceKm;
  final double startingPrice;
  final int totalGames;
  final int? ratingsCount;

  const VenueDetails({
    required this.name,
    required this.imageAsset,
    required this.timings,
    required this.location,
    required this.rating,
    required this.distanceKm,
    required this.startingPrice,
    required this.totalGames,
    this.ratingsCount,
  });
}
