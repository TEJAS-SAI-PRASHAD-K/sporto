import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/providers/theme_provider.dart';
import 'package:playo/features/onboarding/view/pages/avatar.dart';
import 'package:playo/features/onboarding/view/pages/complete_your_profile.dart';
import 'package:playo/features/onboarding/view/pages/onboarding_page.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeNotifierProvider);

    return MaterialApp(
      title: 'Playo',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}
