import 'package:flutter/material.dart';
import 'venue_card.dart';
import '../pages/book_venues_page.dart';
import 'package:playo/core/models/venue.dart' as model;

/// Reusable list that can be embedded inside other pages.
class VenuesList extends StatelessWidget {
  const VenuesList({super.key, required this.venues});

  final List<model.Datum> venues;

  @override
  Widget build(BuildContext context) {
    if (venues.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Center(
          child: Text(
            'No venues found',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: venues.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final datum = venues[index];
        final v = datum.venue;

        // Compute starting price (min hourly rate)
        final courts = datum.court;
        final startingPrice = courts.isNotEmpty
            ? courts
                  .map((c) => c.hourlyRate)
                  .reduce((a, b) => a < b ? a : b)
                  .toDouble()
            : 0.0;

        final name = v.name;
        final imageAsset = v.primaryImage.isNotEmpty
            ? v.primaryImage
            : (v.images.isNotEmpty ? v.images.first : '');
        final rating = v.rating;
        final distanceKm = 0.0;

        return VenueCard(
          name: name,
          rating: rating,
          distanceKm: distanceKm,
          startingPrice: startingPrice,
          imageAsset: imageAsset,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => BookVenuesPage(datum: datum)),
            );
          },
        );
      },
    );
  }
}
