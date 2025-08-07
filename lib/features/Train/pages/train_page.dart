import 'package:flutter/material.dart';

class TrainPage extends StatefulWidget {
  const TrainPage({super.key});

  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  String currentLocation =
      "Current Location"; // You can update this with actual location

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildCustomAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Search By Academy', style: TextStyle(fontSize: 16)),
                  Icon(Icons.search),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color.fromARGB(255, 209, 209, 209),
                  width: 2,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print("List with Us");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.list, size: 20),
                          SizedBox(width: 6),
                          Text("List with Us"),
                        ],
                      ),
                    ),
                  ),

                  // Divider
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        print("Queries");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 6),
                          Icon(Icons.question_answer, size: 20),
                          SizedBox(width: 6),
                          Text("Queries"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildCustomAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      shadowColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
      title: GestureDetector(
        onTap: () {
          // Handle location selection
          _showLocationPicker(context);
        },
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Train',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          currentLocation,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurface.withOpacity(0.7),
                                fontSize: 12,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.6),
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Handle notifications action
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Notifications')));
          },
          icon: Icon(
            Icons.notifications_none_outlined,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          tooltip: 'Notifications',
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14, left: 7),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              size: 20,
            ),
          ),
        ),
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
