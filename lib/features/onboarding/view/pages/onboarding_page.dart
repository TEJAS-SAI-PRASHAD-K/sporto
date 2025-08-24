import 'dart:async';
import 'package:flutter/material.dart';
import 'package:playo/core/widgets/theme_switch_icon_button.dart';
import 'package:playo/features/onboarding/view/widgets/auth/login_bottom_modal_sheet.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:playo/features/onboarding/view/widgets/circular_overlay.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      int nextPage = (_currentPage + 1) % 2;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double imageHeight = screenHeight * 0.55;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [ThemeSwitchIconButton()],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/abstract_map.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: imageHeight,
                width: double.infinity,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  children: [
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/boy_4.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        // Direction for each overlay can be customized—see directions param
                        CircularOverlayPage(
                          labels: [
                            "Hey!",
                            "I'm available",
                            "At 7?",
                            "Wanna play?",
                          ],
                          imagePaths: [
                            'assets/images/boy_6.png',
                            'assets/images/girl_4.png',
                            'assets/images/girl_12.png',
                            'assets/images/boy_2.png',
                          ],
                          directions: [
                            OverlayDirection
                                .right, // Top-left: label to the right
                            OverlayDirection
                                .bottom, // Top-right: label to the left
                            OverlayDirection
                                .right, // Bottom-left: label below image
                            OverlayDirection
                                .bottom, // Bottom-right: label above image
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Center(
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/golf-club.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        CircularOverlayPage(
                          labels: [
                            "Swimming",
                            "Tennis",
                            "Baseball",
                            "Football",
                          ],
                          imagePaths: [
                            'assets/images/swimming_pool.jpg',
                            'assets/images/tennis_court.png',
                            'assets/images/baseball_court.jpg',
                            'assets/images/football_ground.png',
                          ],
                          directions: [
                            OverlayDirection.right,
                            OverlayDirection.bottom,
                            OverlayDirection.right,
                            OverlayDirection.bottom,
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Center(
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 2,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                activeDotColor: Theme.of(context).colorScheme.primary,
                dotColor: Colors.grey.shade300,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  _currentPage == 0
                      ? 'Find Players in\nYour neighborhood'
                      : 'Book Venues to Play\nwith Friends',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _currentPage == 0
                      ? 'Just like you did as a kid!'
                      : 'Get your squad to play together!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Let's get playing!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    showCustomModelSheet(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                  child: const Text(
                    'READY. SET. GO.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
