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
    Widget child = InkWell(
      borderRadius: BorderRadius.circular(9),
      onTap: onTap,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
        color: Theme.of(context).colorScheme.surfaceContainer,
        margin: const EdgeInsets.only(bottom: 10, right: 4, left: 4),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Image Section
              ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: Image.asset(
                  img,
                  height: 70,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),

              /// Title
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),

              /// Description
              Text(
                description,
                textAlign: TextAlign.start,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );

    // If it's not wide, wrap in Expanded for use in Row
    // If it's wide, return the child directly
    return isWide ? child : Expanded(flex: 1, child: child);
  }
}
