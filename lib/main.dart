import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/providers/theme_provider.dart';
import 'package:playo/core/providers/current_user_provider.dart';
import 'package:playo/features/onboarding/view/pages/onboarding_page.dart';
import 'package:playo/core/widgets/bottom_navigation_bar.dart';
import 'package:playo/init_dependecies.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> main() async {
  await initDependencies();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    _requestNotificationPermission();
  }

  Future<void> _requestNotificationPermission() async {
    await Permission.notification.request();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeModeNotifierProvider);
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
