import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/providers/theme_provider.dart';
import 'package:playo/core/providers/current_user_provider.dart';
import 'package:playo/core/models/user.dart';
import 'package:playo/features/onboarding/view/pages/onboarding_page.dart';
import 'package:playo/core/widgets/bottom_navigation_bar.dart';
import 'package:playo/init_dependecies.dart';

Future<void> main() async {
  await initDependencies();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeNotifierProvider);
    final currentUser = ref.watch(currentUserNotifierProvider);
    final currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);

    return MaterialApp(
      title: 'Sporto',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: _buildHome(currentUser, currentUserNotifier),
    );
  }

  Widget _buildHome(User? currentUser, CurrentUserNotifier notifier) {
    // Use isAuthenticated instead of isLoggedIn to avoid waiting for user data
    // isAuthenticated = has valid session (immediate)
    // isLoggedIn = has valid session + user data loaded (requires waiting)

    if (notifier.isAuthenticated) {
      // User has valid session - show main app immediately
      // User data will load in background and update the UI when available
      return const BottomNavBar();
    }

    // No valid session - show onboarding
    return const OnboardingPage();
  }
}
