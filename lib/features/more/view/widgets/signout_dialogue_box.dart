import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/providers/current_user_provider.dart';
import 'package:playo/features/onboarding/view/pages/onboarding_page.dart';

/// Shows a sign out confirmation dialog
Future<void> showSignOutDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        title: Text('Sign Out', style: Theme.of(context).textTheme.titleLarge),
        content: Text(
          'Do you want to sign out of your account?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Consumer(
            builder: (context, ref, child) {
              final currentUserNotifier = ref.watch(
                currentUserNotifierProvider.notifier,
              );
              return TextButton(
                onPressed: () async {
                  await currentUserNotifier.logout();
                  Navigator.of(context).pop(); // Close dialog first
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingPage(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text(
                  'Sign Out',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}
