import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:playo/features/book/view/widgets/rectangle_outlined_container.dart';

class VenueDetails {
  final String name, imageAsset, timings, location;
  final double rating, distanceKm, startingPrice;
  final int totalGames;
  final int? ratingsCount;

  const VenueDetails({
    required this.name,
    required this.imageAsset,
    required this.timings,
    required this.location,
    required this.rating,
    required this.ratingsCount,
    required this.totalGames,
    required this.distanceKm,
    required this.startingPrice,
  });
}

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
                        _CircleIcon(
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
                        _CircleIcon(
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
                _infoRow(theme, Icons.access_time, d.timings),
                const SizedBox(height: 8),
                _infoRow(
                  theme,
                  Icons.place_outlined,
                  d.location,
                  isExpandable: true,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Iconsax.google_1_bold),
                    label: const Text('Show in map'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Divider(color: theme.dividerColor),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: theme.colorScheme.secondary,
                    ),
                    Text(
                      d.rating.toStringAsFixed(2),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (d.ratingsCount != null) ...[
                      const SizedBox(width: 4),
                      Text(
                        '(${_formatCount(d.ratingsCount!)} ratings)',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    const SizedBox(width: 24),
                    VerticalDivider(width: 24, color: theme.dividerColor),
                    const SizedBox(width: 24),
                    const Icon(Icons.sports_tennis, size: 20),
                    Text(
                      '${_formatCount(d.totalGames)} Total Games ',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
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
                      _SportCard(label: 'Badminton', icon: Icons.sports_tennis),
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

  Widget _infoRow(
    ThemeData theme,
    IconData icon,
    String text, {
    bool isExpandable = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 18, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        isExpandable
            ? Expanded(
                child: Text(
                  text,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : Text(text, style: theme.textTheme.bodyMedium),
      ],
    );
  }
}

class _CircleIcon extends StatelessWidget {
  const _CircleIcon({
    required this.icon,
    required this.onPressed,
    this.iconColor,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      shape: const CircleBorder(),
      elevation: 2,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            icon,
            size: 20,
            color: iconColor ?? theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class _SportCard extends StatelessWidget {
  const _SportCard({required this.label, required this.icon});
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.zero,
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: theme.dividerColor),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 28, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
