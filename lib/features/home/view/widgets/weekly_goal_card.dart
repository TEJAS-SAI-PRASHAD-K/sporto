import 'package:flutter/material.dart';

class WeeklyGoalCard extends StatelessWidget {
  const WeeklyGoalCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(9),
        ),
        leading: const Icon(
          Icons.local_fire_department,
          color: Colors.orange,
          size: 35,
        ),
        title: const Text(
          'Set your weekly fit goal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: const Text('Keep yourself fit!'),
        trailing: const Icon(Icons.chevron_right_rounded, size: 32),
        onTap: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text(''))),
      ),
    );
  }
}
