import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class WeeklyFitGoalInfoPage extends StatelessWidget {
  const WeeklyFitGoalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            // Title
            Text(
              "What is Weekly Fit Goal?",
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),

            // Subtitle
            Text(
              "Set fitness goals for yourself and track your progress on a weekly basis.",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
            ),
            const SizedBox(height: 24),

            ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                child: Icon(
                  Iconsax.watch,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
              ),
              title: Text(
                "Link your Google Fit / HealthKit ⌚",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              ),
            ),

            const SizedBox(height: 12),

            ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                child: Icon(
                  Iconsax.activity,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
              ),
              title: Text(
                "Set a weekly Fit goal 🎯",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              ),
            ),

            const SizedBox(height: 12),

            ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                child: Icon(
                  Iconsax.heart,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
              ),
              title: Text(
                "Track progress with calorie, step, and heart rate tracking 💪",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              ),
            ),

            const SizedBox(height: 12),

            ListTile(
              leading: CircleAvatar(
                radius: 22,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.1),
                child: Icon(
                  Iconsax.share,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
              ),
              title: Text(
                "Share success with friends for accountability and celebration 🥳",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(),
              ),
            ),

            const Spacer(),

            // Bottom Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: Icon(
                  Iconsax.heart,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 20,
                ),
                label: Text(
                  "Link Google Fit",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
