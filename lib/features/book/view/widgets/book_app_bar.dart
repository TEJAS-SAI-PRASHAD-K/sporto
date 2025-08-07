import 'package:flutter/material.dart';

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
    return Container(
      color: const Color(0xFF27313C),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        child: Row(
          children: [
            DropdownButton<String>(
              value: selectedLocation,
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: 'Amaravati',
                  child: Text(
                    'Amaravati',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Hyderabad',
                  child: Text(
                    'Hyderabad',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              onChanged: (value) => onLocationChanged(value ?? 'Amaravati'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
              dropdownColor: const Color(0xFF27313C),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat, color: Colors.white),
            ),
            Padding(padding: const EdgeInsets.only(right: 2)),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Colors.white),
            ),
            Padding(padding: const EdgeInsets.only(left: 12)),
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.white,
              child: Icon(Icons.person, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
