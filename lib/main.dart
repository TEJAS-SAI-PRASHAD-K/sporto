import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/providers/theme_provider.dart';
import 'package:playo/core/providers/current_user_provider.dart';
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
    // Watch the provider state (the current user). Watching the notifier
    // won't rebuild when the authentication changes; we must watch the
    // provider itself so the app reacts to sign-in / sign-out events.
    final currentUser = ref.watch(currentUserNotifierProvider);
    final isAuthed = currentUser != null;

    return MaterialApp(
      title: 'Sporto',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: isAuthed ? BottomNavBar() : OnboardingPage(),
    );
  }
}
