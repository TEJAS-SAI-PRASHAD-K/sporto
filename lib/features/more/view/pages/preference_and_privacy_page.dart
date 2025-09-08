import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:playo/core/providers/theme_provider.dart';
import 'package:playo/core/theme/app_theme.dart';
import 'package:playo/features/more/view/pages/settings/blocked_users_page.dart';
import 'package:playo/features/more/view/pages/settings/notification_preferences_page.dart';
import 'package:playo/features/more/view/pages/settings/set_password_page.dart';
import 'package:playo/features/onboarding/view/pages/pick_your_fav_sports_page.dart';

class PreferenceAndPrivacyPage extends ConsumerStatefulWidget {
  const PreferenceAndPrivacyPage({super.key});

  @override
  ConsumerState<PreferenceAndPrivacyPage> createState() =>
      _PreferenceAndPrivacyPageState();
}

class _PreferenceAndPrivacyPageState
    extends ConsumerState<PreferenceAndPrivacyPage> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeModeNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Settings",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          ListTile(
            tileColor: Theme.of(context).colorScheme.tertiary,
            title: Text(
              "Preferences",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: null,
          ),

          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,

            leading: Icon(Iconsax.activity_copy),
            title: Text("Sports"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PickYourFavSportsPage(isLoggedIn: true),
                ),
              );
            },
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,

            leading: Icon(Iconsax.location_copy),
            title: Text("Location"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,

            leading: Icon(Iconsax.notification_copy),
            title: Text("Notification"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationPreferencesPage(),
                ),
              );
            },
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,

            leading: Icon(Iconsax.moon_copy),
            title: Text("Dark Mode"),
            trailing: Transform.scale(
              scale: 0.9,
              child: Switch.adaptive(
                value: theme == darkTheme,
                onChanged: (value) {
                  ref.read(themeModeNotifierProvider.notifier).toggleTheme();
                },
              ),
            ),
            onTap: () {
              ref.read(themeModeNotifierProvider.notifier).toggleTheme();
            },
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.tertiary,
            title: Text(
              "Privacy",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            title: Text("Set Password"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SetPasswordPage()),
              );
            },
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            title: Text("Blocked Users"),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BlockedUsersPage()),
              );
            },
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            title: Text("Reset Account"),
            onTap: () {},
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            title: Text("Delete Account"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
