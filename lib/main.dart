import 'package:flutter/material.dart';
import 'package:playo/features/onboarding/view/pages/onboarding_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playo',
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}
