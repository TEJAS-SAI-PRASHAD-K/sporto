import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class PlaypalsTab extends StatelessWidget {
  const PlaypalsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No conversations',
            style: TextStyle(
              fontSize: 18,
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'There are no game with conversations',
            style: TextStyle(
              fontSize: 14,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: Theme.of(context).colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(9),
              ),
              leading: Icon(Iconsax.user_add_copy),
              title: Text(
                'Pending Requests',
                style: TextStyle(
                  fontSize: 14,
                  // color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Container(
                alignment: Alignment.center,
                width: 28,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.orange,
                ),
                child: Text(
                  "0",
                  style: TextStyle(
                    fontSize: 14,
                    // color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
