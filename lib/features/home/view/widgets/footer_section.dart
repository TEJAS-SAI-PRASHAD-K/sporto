import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12),
        Icon(Iconsax.polygon_matic),
        SizedBox(height: 12),
        Text(
          "Your Sports Community App",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FooterLink(text: "Privacy Policy"),
            const Text(" · ", style: TextStyle(color: Colors.black)),
            FooterLink(text: "Terms of Service"),
            const Text(" · ", style: TextStyle(color: Colors.black)),
            FooterLink(text: "FAQs"),
          ],
        ),
        const SizedBox(height: 8),
        const Text("v 1.0.1", style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 14),
      ],
    );
  }
}

class FooterLink extends StatelessWidget {
  final String text;
  const FooterLink({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        child: Text(
          text,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        onTap: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(''))),
      ),
    );
  }
}
