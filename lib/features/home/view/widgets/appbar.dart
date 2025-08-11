import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LocationOption {
  final String label;
  final IconData icon;
  final bool isCurrent;
  final bool isRecent;

  LocationOption({
    required this.label,
    required this.icon,
    this.isCurrent = false,
    this.isRecent = false,
  });
}

class LocationSelector extends StatefulWidget {
  final String selectedLocation;
  final ValueChanged<String> onLocationChanged;

  const LocationSelector({
    super.key,
    required this.selectedLocation,
    required this.onLocationChanged,
  });

  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  late String _selected;

  final List<LocationOption> _locations = [
    LocationOption(
      label: 'Current Location',
      icon: Icons.my_location,
      isCurrent: true,
    ),
    LocationOption(label: 'Hyderabad', icon: Icons.history, isRecent: true),
    LocationOption(label: 'Bengaluru', icon: Icons.history, isRecent: true),
    LocationOption(label: 'Chennai', icon: Icons.location_city),
    LocationOption(label: 'Mumbai', icon: Icons.location_city),
    LocationOption(label: 'Delhi', icon: Icons.location_city),
  ];

  @override
  void initState() {
    super.initState();
    _selected = widget.selectedLocation;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<LocationOption>(
      initialValue: _locations.firstWhere(
        (loc) => loc.label == _selected,
        orElse: () => _locations[0],
      ),
      onSelected: (LocationOption option) {
        setState(() {
          _selected = option.label;
        });
        widget.onLocationChanged(option.label);
      },
      itemBuilder: (context) => _locations.map((option) {
        return PopupMenuItem<LocationOption>(
          textStyle: TextStyle(color: Theme.of(context).colorScheme.primary),

          value: option,
          child: Row(
            children: [
              Icon(
                option.icon,
                color: option.isCurrent
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                size: 20,
              ),
              const SizedBox(width: 10),
              Text(
                option.label,
                style: TextStyle(
                  fontWeight: option.isCurrent
                      ? FontWeight.bold
                      : FontWeight.normal,
                  color: option.isCurrent
                      ? Theme.of(context).colorScheme.primary
                      : Colors.black87,
                ),
              ),
              if (_selected == option.label)
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.check,
                    color: Theme.of(context).colorScheme.primary,
                    size: 18,
                  ),
                ),
            ],
          ),
        );
      }).toList(),
      child: Row(
        children: [
          Icon(
            Iconsax.location_copy,
            color: Theme.of(context).colorScheme.primary,
            size: 22,
          ),
          const SizedBox(width: 4),
          Text(
            _selected,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(width: 2),
          const Icon(
            Iconsax.arrow_down_1_copy,
            color: Colors.black54,
            size: 20,
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget buildCustomAppBar({
  String selectedLocation = 'Location',
  ValueChanged<String>? onLocationChanged,
}) {
  return AppBar(
    elevation: 0,
    title: Row(
      children: [
        Expanded(
          child: LocationSelector(
            selectedLocation: selectedLocation,
            onLocationChanged: onLocationChanged ?? (_) {},
          ),
        ),
      ],
    ),
    actions: [
      IconButton(onPressed: () {}, icon: const Icon(Iconsax.message_2_copy)),
      IconButton(
        onPressed: () {},
        icon: const Icon(Iconsax.notification_1_copy),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 14, left: 7),
        child: CircleAvatar(
          radius: 18,
          foregroundImage: AssetImage("assets/images/boy_10.png"),
        ),
      ),
    ],
  );
}
