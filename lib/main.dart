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
    final currentUserNotifier = ref.watch(currentUserNotifierProvider.notifier);
    final isAuthed = currentUserNotifier.isAuthenticated;
    final isComplete = currentUserNotifier.isProfileCompleted;

    return MaterialApp(
      title: 'Sporto',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: isAuthed && isComplete ? BottomNavBar() : OnboardingPage(),
    );
  }
}
