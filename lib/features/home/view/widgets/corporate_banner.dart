import 'package:flutter/material.dart';

class CorporateBanner extends StatelessWidget {
  const CorporateBanner({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "See Your Employees\nTired of Back to Back Meetings?",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              "Sports Days Help with ",
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
            const Text(
              "Team Bonding!",
              style: TextStyle(
                color: Colors.lightBlue,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Explore Corporate Offerings!"),
              onPressed: () => ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text(''))),
            ),
          ],
        ),
      ),
    );
  }
}
