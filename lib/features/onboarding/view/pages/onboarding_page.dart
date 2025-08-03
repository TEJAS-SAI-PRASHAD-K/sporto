import 'package:flutter/material.dart';
import 'package:playo/features/home/view/page/home_page.dart';

import '../widgets/circular_overlay.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        titleSpacing: 0,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/new-logo-playo.png',
            fit: BoxFit.contain,
          ),
        ),
        leadingWidth: 70,
        title: Container(),
      ),

      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CircularOverlayPage(
                  labels: ['One', 'Two', 'Three', 'Four'],
                  imagePaths: [
                    'assets/images/d85b08d3-df7b-455a-98d2-e0e402080a9f.jpeg',
                    'assets/images/d85b08d3-df7b-455a-98d2-e0e402080a9f.jpeg',
                    'assets/images/d85b08d3-df7b-455a-98d2-e0e402080a9f.jpeg',
                    'assets/images/d85b08d3-df7b-455a-98d2-e0e402080a9f.jpeg',
                  ],
                ),
                CircularOverlayPage(
                  labels: ['Five', 'Six', 'Seven', 'Eight'],
                  imagePaths: [
                    'assets/images/d85b08d3-df7b-455a-98d2-e0e402080a9f.jpeg',
                    'assets/images/d85b08d3-df7b-455a-98d2-e0e402080a9f.jpeg',
                    'assets/images/d85b08d3-df7b-455a-98d2-e0e402080a9f.jpeg',
                    'assets/images/d85b08d3-df7b-455a-98d2-e0e402080a9f.jpeg',
                  ],
                ),

                Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/navi.jpeg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/vectors, photos and PSD files _ Free download.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(flex: 4, child: Container(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                showDragHandle: true,
                context: context,
                builder: (builder) => Column(
                  children: [
                    Container(height: 50, color: Colors.red),
                    Text("data"),
                    Container(height: 50, color: Colors.pink),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Let\'s Get Started',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
