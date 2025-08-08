import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class BookAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String selectedLocation;
  final ValueChanged<String> onLocationChanged;

  const BookAppBar({
    super.key,
    required this.selectedLocation,
    required this.onLocationChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            DropdownButton<String>(
              value: selectedLocation,
              underline: const SizedBox(),

              items: const [
                DropdownMenuItem(value: 'Amaravati', child: Text('Amaravati')),
                DropdownMenuItem(value: 'Hyderabad', child: Text('Hyderabad')),
              ],
              onChanged: (value) => onLocationChanged(value ?? 'Amaravati'),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              icon: const Icon(Icons.keyboard_arrow_down),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.message_2_copy),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.notification_1_copy),
            ),
            Padding(padding: const EdgeInsets.only(left: 12)),
            CircleAvatar(
              radius: 18,
              foregroundImage: AssetImage("assets/images/boy_10.png"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
