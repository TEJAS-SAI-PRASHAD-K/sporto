import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:playo/core/common/pages/alerts_page.dart';
import 'package:playo/core/common/pages/conversations/conversations_page.dart';
import 'package:playo/core/common/pages/profile_page.dart';
import 'package:playo/core/models/user.dart';
import 'package:playo/core/providers/current_user_provider.dart';
import 'package:playo/core/services/geo_location_service.dart';

class MainAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  ConsumerState<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends ConsumerState<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: GestureDetector(
        onTap: () {
          // Handle location selection
          _showLocationPicker(context, user!);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    user?.locationArea ?? "Current Location",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 13,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down,
                  color: Theme.of(context).colorScheme.outline,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => ConversationsPage()),
            );
          },
          icon: const Icon(Iconsax.message_2_copy),
          tooltip: 'Notes',
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (builder) => AlertsPage()),
            );
          },
          icon: const Icon(Iconsax.notification_copy),
          tooltip: 'Notifications',
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            if (user != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => ProfilePage(userId: user.userId),
                ),
              );
            }
          },
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: _buildAvatarImage(user),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  void _showLocationPicker(BuildContext context, User user) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select Location',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Current Location Option
              TextField(
                decoration: InputDecoration(
                  hintText: "Search by Location",
                  suffixIcon: Icon(
                    Iconsax.search_normal_1_copy,
                    color: Theme.of(context).colorScheme.outline,
                    size: 18,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surfaceContainer,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.my_location,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: const Text('Use Current Location'),
                subtitle: const Text('Detect location automatically'),
                trailing: Icon(
                  Icons.gps_fixed,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onTap: () async {
                  final pos = await GeoLocationService.determinePosition();
                  final loc =
                      await GeoLocationService.getPlacemarkFromCoordinates(
                        pos.latitude,
                        pos.longitude,
                      );
                  final place = loc.first;
                  final area = (place.subLocality?.trim().isNotEmpty ?? false)
                      ? place.subLocality
                      : (place.street?.trim().isNotEmpty ?? false)
                      ? place.street
                      : (place.name?.trim().isNotEmpty ?? false)
                      ? place.name
                      : null;
                  debugPrint("${area ?? 'Unknown'}, ${place.locality ?? ''}");

                  // Preserve favorite sports while updating location
                  await ref
                      .read(currentUserProvider.notifier)
                      .updateUser(
                        user.copyWith(
                          city: place.locality,
                          state: place.administrativeArea,
                          country: place.country,
                          latitude: pos.latitude,
                          longitude: pos.longitude,
                          locationArea:
                              "${area ?? 'N/A'}, ${place.locality ?? ''}",
                        ),
                      );

                  Navigator.pop(context);
                },
              ),

              const Divider(),

              // Recent Locations
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Bengaluru, Karnataka'),
                subtitle: const Text('Recent location'),
                onTap: () {
                  setState(() {
                    // currentLocation = "Bengaluru, Karnataka";
                  });
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Mumbai, Maharashtra'),
                subtitle: const Text('Recent location'),
                onTap: () {
                  setState(() {
                    // currentLocation = "Mumbai, Maharashtra";
                  });
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatarImage(User? user) {
    // If no user or no avatarUrl, show default
    if (user?.avatarUrl == null || user!.avatarUrl!.isEmpty) {
      return ClipOval(
        child: Image.asset(
          "assets/images/boy_10.png",
          width: 36,
          height: 36,
          fit: BoxFit.cover,
        ),
      );
    }

    final avatarUrl = user.avatarUrl!;

    // Check if it's a network URL (starts with http/https)
    if (avatarUrl.startsWith('http://') || avatarUrl.startsWith('https://')) {
      return ClipOval(
        child: Image.network(
          avatarUrl,
          width: 36,
          height: 36,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return ClipOval(
              child: Image.asset(
                "assets/images/boy_10.png",
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      );
    }

    // Otherwise, treat it as an asset path (from onboarding selection)
    return ClipOval(
      child: Image.asset(
        avatarUrl.startsWith('assets/')
            ? avatarUrl
            : "assets/images/$avatarUrl",
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return ClipOval(
            child: Image.asset(
              "assets/images/boy_10.png",
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
