import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBar({super.key});

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  String currentLocation =
      "Current Location"; // You can update this with actual location
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      title: GestureDetector(
        onTap: () {
          // Handle location selection
          _showLocationPicker(context);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    currentLocation,
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
          onPressed: () {},
          icon: const Icon(Iconsax.message_2_copy),
          tooltip: 'Notes',
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.notification_1_copy),
          tooltip: 'Notifications',
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {},
          child: const CircleAvatar(
            radius: 18,
            foregroundImage: AssetImage("assets/images/boy_10.png"),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  void _showLocationPicker(BuildContext context) {
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
                  ).colorScheme.onSurface.withOpacity(0.3),
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
                onTap: () {
                  setState(() {
                    currentLocation = "Current Location";
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Using current location')),
                  );
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
                    currentLocation = "Bengaluru, Karnataka";
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
                    currentLocation = "Mumbai, Maharashtra";
                  });
                  Navigator.pop(context);
                },
              ),

              const Divider(),

              // Search for location
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search for a location'),
                onTap: () {
                  Navigator.pop(context);
                  // Here you can implement location search functionality
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Location search will be implemented'),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
