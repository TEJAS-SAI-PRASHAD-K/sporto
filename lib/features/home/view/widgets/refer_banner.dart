import 'package:flutter/material.dart';

class ReferBanner extends StatelessWidget {
  const ReferBanner({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: const Icon(Icons.card_giftcard, color: Colors.black, size: 32),
        title: const Text("Refer a Sports Enthusiast", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("Earn 50 karma points by inviting your friends"),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text(''))),
      ),
    );
  }
}
