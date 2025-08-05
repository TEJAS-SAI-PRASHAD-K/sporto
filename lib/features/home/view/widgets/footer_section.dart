import 'package:flutter/material.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('assets/playo_logo.png', height: 38, errorBuilder: (c, e, s) => const Icon(Icons.sports_tennis, size: 38)), // Placeholder
        Text("Your Sports Community App", style: TextStyle(color: Colors.grey[700])),
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
        Image.asset('assets/footer_bike.png', height: 70, errorBuilder: (c, e, s) => const SizedBox.shrink()), // Placeholder
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
        child: Text(text, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 13)),
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(''))),
      ),
    );
  }
}
