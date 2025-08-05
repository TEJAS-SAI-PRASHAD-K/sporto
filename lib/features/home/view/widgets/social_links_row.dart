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
            child: const Text('FOLLOW US ON', style: TextStyle()),
          ),
          IconButton(
            icon: const Icon(Bootstrap.instagram),
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text(''))),
          ),
          IconButton(
            icon: const Icon(Bootstrap.twitter),
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text(''))),
          ),
          IconButton(
            icon: const Icon(Bootstrap.linkedin),
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text(''))),
          ),
        ],
      ),
    );
  }
}
