import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SocialLinksRow extends StatelessWidget {
  const SocialLinksRow({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: const Text('FOLLOW US ON', style: TextStyle(fontSize: 12)),
          ),
          IconButton(
            icon: const Icon(Iconsax.instagram, size: 18),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Iconsax.twitch, size: 18),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Iconsax.link, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
