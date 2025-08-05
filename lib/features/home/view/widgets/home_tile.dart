import 'package:flutter/material.dart';

class HomeTile extends StatelessWidget {
  final String img;
  final String title;
  final String description;
  final VoidCallback onTap;
  final bool isWide;

  const HomeTile({
    super.key,
    required this.img,
    required this.title,
    required this.description,
    required this.onTap,
    this.isWide = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: isWide ? 2 : 1,
      child: Card(
        margin: EdgeInsets.only(right: isWide ? 0 : 6, left: isWide ? 0 : 6, bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // Replace with your asset image
                  child: Image.asset(img, height: 54, width: double.infinity, fit: BoxFit.cover),
                ),
                const SizedBox(height: 10),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Text(description, textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
