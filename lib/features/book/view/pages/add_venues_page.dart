import 'package:flutter/material.dart';
import '../widgets/venue_card.dart';

class AddVenuesPage extends StatelessWidget {
  const AddVenuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Venues')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _mockVenues.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final venue = _mockVenues[index];
          return VenueCard(
            name: venue.name,
            rating: venue.rating,
            distanceKm: venue.distanceKm,
            startingPrice: venue.startingPrice,
            imageAsset: venue.imageAsset,
          );
        },
      ),
    );
  }
}

/// Embeddable venues list for use inside other screens (e.g., under a tab).
/// When [embedded] is true, the list will shrinkWrap and disable its own
/// scrolling so it can be placed inside a parent scroll view.
class VenuesList extends StatelessWidget {
  const VenuesList({super.key, this.embedded = false});

  final bool embedded;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _mockVenues.length,
      shrinkWrap: embedded,
      physics: embedded ? const NeverScrollableScrollPhysics() : null,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final venue = _mockVenues[index];
        return VenueCard(
          name: venue.name,
          rating: venue.rating,
          distanceKm: venue.distanceKm,
          startingPrice: venue.startingPrice,
          imageAsset: venue.imageAsset,
        );
      },
    );
  }
}

class _Venue {
  final String name;
  final double rating;
  final double distanceKm;
  final double startingPrice;
  final String imageAsset;

  const _Venue({
    required this.name,
    required this.rating,
    required this.distanceKm,
    required this.startingPrice,
    required this.imageAsset,
  });
}

const List<_Venue> _mockVenues = [
  _Venue(
    name: 'City Tennis Club',
    rating: 4.5,
    distanceKm: 1.2,
    startingPrice: 350,
    imageAsset: 'assets/images/tennis_court.png',
  ),
  _Venue(
    name: 'Greenfield Football Arena',
    rating: 4.2,
    distanceKm: 2.8,
    startingPrice: 500,
    imageAsset: 'assets/images/football_ground.png',
  ),
  _Venue(
    name: 'Lakeside Swimming Pool',
    rating: 4.7,
    distanceKm: 3.1,
    startingPrice: 300,
    imageAsset: 'assets/images/swimming_pool.jpg',
  ),
  _Venue(
    name: 'Sunset Golf Club',
    rating: 4.4,
    distanceKm: 5.6,
    startingPrice: 800,
    imageAsset: 'assets/images/golf-club.jpg',
  ),
  _Venue(
    name: 'Downtown Baseball Court',
    rating: 4.1,
    distanceKm: 1.9,
    startingPrice: 420,
    imageAsset: 'assets/images/baseball_court.jpg',
  ),
];

// Expose mock venues count for tabs badge usage
int get mockVenuesCount => _mockVenues.length;
