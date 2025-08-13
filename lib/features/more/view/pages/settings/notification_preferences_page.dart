import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class NotificationPreferencesPage extends ConsumerStatefulWidget {
  const NotificationPreferencesPage({super.key});

  @override
  ConsumerState<NotificationPreferencesPage> createState() =>
      _NotificationPreferencesPageState();
}

class _NotificationPreferencesPageState
    extends ConsumerState<NotificationPreferencesPage> {
  // Push notification settings
  bool pushGameInvites = true;
  bool pushGameUpdates = true;
  bool pushMessages = true;
  bool pushPromotions = false;

  // Email notification settings
  bool emailWeeklyDigest = true;
  bool emailMarketing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification Preferences",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Push Notifications Section
          ListTile(
            tileColor: Theme.of(context).colorScheme.tertiary,
            title: Text(
              "Push Notifications",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            leading: Icon(Iconsax.game_copy),
            title: Text("Game Invites"),
            subtitle: Text("Get notified when someone invites you to play"),
            trailing: Transform.scale(
              scale: 0.9,
              child: Switch.adaptive(
                value: pushGameInvites,
                onChanged: (value) {
                  setState(() {
                    pushGameInvites = value;
                  });
                },
              ),
            ),
            onTap: () {
              setState(() {
                pushGameInvites = !pushGameInvites;
              });
            },
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            leading: Icon(Iconsax.refresh_copy),
            title: Text("Game Updates"),
            subtitle: Text("Updates about your scheduled games"),
            trailing: Transform.scale(
              scale: 0.9,
              child: Switch.adaptive(
                value: pushGameUpdates,
                onChanged: (value) {
                  setState(() {
                    pushGameUpdates = value;
                  });
                },
              ),
            ),
            onTap: () {
              setState(() {
                pushGameUpdates = !pushGameUpdates;
              });
            },
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            leading: Icon(Iconsax.message_copy),
            title: Text("Messages"),
            subtitle: Text("New messages from other players"),
            trailing: Transform.scale(
              scale: 0.9,
              child: Switch.adaptive(
                value: pushMessages,
                onChanged: (value) {
                  setState(() {
                    pushMessages = value;
                  });
                },
              ),
            ),
            onTap: () {
              setState(() {
                pushMessages = !pushMessages;
              });
            },
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            leading: Icon(Iconsax.discount_shape_copy),
            title: Text("Promotions"),
            subtitle: Text("Special offers and promotional content"),
            trailing: Transform.scale(
              scale: 0.9,
              child: Switch.adaptive(
                value: pushPromotions,
                onChanged: (value) {
                  setState(() {
                    pushPromotions = value;
                  });
                },
              ),
            ),
            onTap: () {
              setState(() {
                pushPromotions = !pushPromotions;
              });
            },
          ),

          // Email Section
          ListTile(
            tileColor: Theme.of(context).colorScheme.tertiary,
            title: Text(
              "Email",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: null,
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            leading: Icon(Iconsax.calendar_copy),
            title: Text("Weekly Digest"),
            subtitle: Text("Summary of your weekly activities"),
            trailing: Transform.scale(
              scale: 0.9,
              child: Switch.adaptive(
                value: emailWeeklyDigest,
                onChanged: (value) {
                  setState(() {
                    emailWeeklyDigest = value;
                  });
                },
              ),
            ),
            onTap: () {
              setState(() {
                emailWeeklyDigest = !emailWeeklyDigest;
              });
            },
          ),
          ListTile(
            tileColor: Theme.of(context).colorScheme.surfaceContainer,
            leading: Icon(Iconsax.sms_copy),
            title: Text("Marketing Emails"),
            subtitle: Text("News, tips, and promotional emails"),
            trailing: Transform.scale(
              scale: 0.9,
              child: Switch.adaptive(
                value: emailMarketing,
                onChanged: (value) {
                  setState(() {
                    emailMarketing = value;
                  });
                },
              ),
            ),
            onTap: () {
              setState(() {
                emailMarketing = !emailMarketing;
              });
            },
          ),
        ],
      ),
    );
  }
}
