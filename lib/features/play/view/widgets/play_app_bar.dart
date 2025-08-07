import 'package:flutter/material.dart';

class PlayAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PlayAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF27313C),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        child: Row(
          children: [
            DropdownButton<String>(
              value: 'Amaravati',
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(
                  value: 'Amaravati',
                  child: Text(
                    'Amaravati',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              onChanged: (_) {},
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
              icon: const Icon(Icons.notes, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Colors.white),
            ),
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              backgroundImage: AssetImage('assets/images/user_avatar.png'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
