import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

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
            icon: const Icon(Bootstrap.instagram, size: 18),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Bootstrap.twitter, size: 18),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Bootstrap.linkedin, size: 18),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
