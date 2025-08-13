import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:playo/features/book/model/venue_details.dart';
import 'package:playo/features/book/view/widgets/rectangle_outlined_container.dart';
import 'package:playo/features/book/view/widgets/circle_icon_button.dart';
import 'package:playo/features/book/view/widgets/info_row.dart';
import 'package:playo/features/book/view/widgets/sport_card.dart';

class BookVenuesPage extends StatefulWidget {
  const BookVenuesPage({super.key, required this.details});
  final VenueDetails details;

  @override
  State<BookVenuesPage> createState() => _BookVenuesPageState();
}

class _BookVenuesPageState extends State<BookVenuesPage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final d = widget.details;
    final theme = Theme.of(context);
    final expandedHeight = MediaQuery.of(context).size.width * 9 / 16; // 16:9

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(), // enable iOS-like bounce
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            stretch: true, // enables pull-to-stretch
            expandedHeight: expandedHeight,
            leading: BackButton(color: theme.colorScheme.onSurface),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground, // zoom on pull
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Image.asset(d.imageAsset, fit: BoxFit.cover),
                  ),
                  Positioned(
                    right: 16,
                    bottom: 8,
                    child: Row(
                      children: [
                        CircleIconButton(
                          icon: isFavorite
                              ? Iconsax.heart_add_bold
                              : Iconsax.heart_add_outline,
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

          // Body content after the image with padding
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  d.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                InfoRow(icon: Icons.access_time, text: d.timings),
                const SizedBox(height: 8),
                const SizedBox(height: 2),
                InfoRow(
                  icon: Icons.place_outlined,
                  text: d.location,
                  expandable: true,
                ),
                const SizedBox(height: 10),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Iconsax.google_1_bold),
                  label: const Text('Show in map'),
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Divider(color: theme.dividerColor),
                const SizedBox(height: 12),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: theme.colorScheme.secondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        d.rating.toStringAsFixed(2),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (d.ratingsCount != null) ...[
                        const SizedBox(width: 6),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Text(
                            '(${_formatCount(d.ratingsCount!)} ratings)',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                      SizedBox(
                        height: 16,
                        child: VerticalDivider(
                          width: 4,
                          thickness: 1,
                          color: theme.dividerColor,
                        ),
                      ),
                      const SizedBox(width: 24),
                      const Icon(Icons.sports_tennis, size: 20),
                      const SizedBox(width: 6),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Text(
                          '${_formatCount(d.totalGames)} Total Games',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
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
                    children: const [
                      SportCard(label: 'Badminton', icon: Icons.sports_tennis),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Amenities',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: RectangleOutlinedContainer(text: 'Lockers'),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: RectangleOutlinedContainer(text: 'Drinking water'),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: RectangleOutlinedContainer(text: 'Parking'),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: RectangleOutlinedContainer(text: 'Washroom'),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: RectangleOutlinedContainer(text: 'Rent rackets'),
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: RectangleOutlinedContainer(text: 'Rent shoes'),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: double.infinity,
                  child: RectangleOutlinedContainer(text: 'Pro shop'),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 80), // extra bottom space
              ]),
            ),
          ),
        ],
      ),
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
                  onPressed: () {},
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
