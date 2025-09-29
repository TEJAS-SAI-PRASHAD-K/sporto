import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:playo/core/models/venue.dart' as model;
import 'package:playo/features/book/view/pages/book_slot_page.dart';
import 'package:playo/features/book/view/widgets/rectangle_outlined_container.dart';
import 'package:playo/features/book/view/widgets/circle_icon_button.dart';
import 'package:playo/features/book/view/widgets/info_row.dart';
import 'package:playo/features/book/view/widgets/sport_card.dart';

class BookVenuesPage extends StatefulWidget {
  const BookVenuesPage({super.key, required this.datum});

  final model.Datum datum;

  @override
  State<BookVenuesPage> createState() => _BookVenuesPageState();
}

class _BookVenuesPageState extends State<BookVenuesPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expandedHeight = MediaQuery.of(context).size.width * 9 / 16; // 16:9

    final venue = widget.datum.venue;
    final courts = widget.datum.court;

    // Compute display values
    final imageAsset = venue.primaryImage.isNotEmpty
        ? venue.primaryImage
        : (venue.images.isNotEmpty ? venue.images.first : '');
    final name = venue.name;
    final openingHours = venue.openingHours;
    final address = venue.address;
    final rating = venue.rating;
    final totalReviews = venue.totalReviews;
    final totalGames = courts.length;
    final amenities = venue.amenities;
    final sports = venue.sportIds;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            stretch: true,
            expandedHeight: expandedHeight,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surfaceContainer,
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Image.network(imageAsset, fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 8,
                    child: Row(
                      children: [
                        CircleIconButton(
                          icon: isFavorite
                              ? Iconsax.heart_add
                              : Iconsax.heart_add_copy,
                          iconColor: isFavorite
                              ? theme.colorScheme.error
                              : theme.colorScheme.onSurfaceVariant,
                          onPressed: () =>
                              setState(() => isFavorite = !isFavorite),
                        ),
                        const SizedBox(width: 12),
                        CircleIconButton(
                          icon: Icons.share_outlined,
                          iconColor: theme.colorScheme.onSurfaceVariant,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Body content
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                InfoRow(icon: Icons.access_time, text: openingHours),
                const SizedBox(height: 8),
                InfoRow(
                  icon: Icons.place_outlined,
                  text: address,
                  expandable: true,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.google_1),
                    label: const Text('Show in map'),
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Divider(color: theme.dividerColor),
                const SizedBox(height: 12),

                // Ratings + total games row
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: theme.colorScheme.secondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        rating.toStringAsFixed(2),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Padding(
                        padding: const EdgeInsets.only(right: 52),
                        child: Text(
                          '(${_formatCount(totalReviews)} ratings)',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Icon(Icons.sports_tennis, size: 20),
                      const SizedBox(width: 6),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Text(
                          '${_formatCount(totalGames)} Total Games',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text('RATE VENUE'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                        ),
                        child: const Text('0 UPCOMING'),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Sports (hardcoded)
                Text(
                  'Available Sports',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '(Tap on sport icon to see “Price Chart”)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 90,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                      sports.length,
                      (index) => SportCard(sport: sports[index]),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Amenities (hardcoded)
                Text(
                  'Amenities',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true, // important
                    physics: const NeverScrollableScrollPhysics(),

                    padding: const EdgeInsets.all(8),
                    itemCount: (amenities.length / 3).ceil(), // number of rows
                    itemBuilder: (context, rowIndex) {
                      int startIndex = rowIndex * 3;

                      return Row(
                        children: List.generate(3, (colIndex) {
                          int amenitiesIndex = startIndex + colIndex;

                          // check if facility exists (for last incomplete row)
                          if (amenitiesIndex >= amenities.length) {
                            return const Expanded(
                              child: SizedBox(),
                            ); // filler space
                          }

                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: RectangleOutlinedContainer(
                                text: amenities[amenitiesIndex],
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Games section
                Text(
                  'Games',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                    child: const Text('+ CREATE GAME'),
                  ),
                ),

                const SizedBox(height: 20),

                // About Venue
                Text(
                  'About Venue',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '- Non marking shoes are compulsory',
                  style: TextStyle(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),

      // Bottom bar
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  child: const Text(
                    'BULK / CORPORATE',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookSlotPage(
                          venueId: widget.datum.venue.id,
                          sportName: 'Sports', // Default sport
                        ),
                      ),
                    );
                  },
                  style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  child: const Text(
                    'BOOK NOW!',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static String _formatCount(int value) {
    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(value % 1000000 == 0 ? 0 : 2)}M';
    } else if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(value % 1000 == 0 ? 0 : 2)}K';
    }
    return value.toString();
  }
}
