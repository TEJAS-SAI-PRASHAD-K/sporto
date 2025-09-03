import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:playo/features/home/view/pages/weekly_fit_goal_info.dart';

class WeeklyFitGoalPage extends StatefulWidget {
  const WeeklyFitGoalPage({super.key});

  @override
  State<WeeklyFitGoalPage> createState() => _WeeklyFitGoalPageState();
}

class _WeeklyFitGoalPageState extends State<WeeklyFitGoalPage> {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with gradient using theme colors
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [cs.primary, cs.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                "Weekly Fit Goal",
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Subtitle
            Text(
              "Set Fit Goals and keep your fitness in check.",
              style: textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
            const SizedBox(height: 24),

            // Options Grid
            Expanded(
              child: Center(
                child: Wrap(
                  spacing: 30,
                  runSpacing: 30,
                  alignment: WrapAlignment.center,
                  children: [
                    _GoalOption(
                      icon: Iconsax.flash_1,
                      label: "Calories",
                      backgroundColor: cs.tertiaryContainer,
                      iconColor: cs.onTertiaryContainer,
                    ),
                    _GoalOption(
                      icon: Iconsax.activity_copy,
                      label: "Step Count",
                      backgroundColor: cs.secondaryContainer,
                      iconColor: cs.onSecondaryContainer,
                    ),
                    _GoalOption(
                      icon: Iconsax.location,
                      label: "Distance",
                      backgroundColor: cs.tertiaryContainer,
                      iconColor: cs.onTertiaryContainer,
                    ),
                    _GoalOption(
                      icon: Iconsax.heart,
                      label: "Heart Beat",
                      backgroundColor: cs.errorContainer,
                      iconColor: cs.onErrorContainer,
                    ),
                    _GoalOption(
                      icon: Iconsax.cup,
                      label: "Achievements",
                      backgroundColor: cs.surfaceContainerHigh,
                      iconColor: cs.onSurfaceVariant,
                    ),
                    _GoalOption(
                      icon: Iconsax.google,
                      label: "Google Fit",
                      backgroundColor: Colors.amber.withValues(alpha: 0.2),
                      iconColor: cs.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
            ),

            // Bottom button
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeeklyFitGoalInfoPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cs.primary,
                    foregroundColor: cs.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(
                    "What is Weekly Fit Goal?",
                    style: textTheme.titleMedium?.copyWith(
                      color: cs.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconColor;

  const _GoalOption({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: backgroundColor,
          child: Icon(icon, color: iconColor, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: textTheme.bodySmall),
      ],
    );
  }
}
