import 'package:flutter/material.dart';

class GametimeUnlock extends StatelessWidget {
  const GametimeUnlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            Transform.rotate(
              angle: 90,
              child: Image.asset(
                "assets/images/credit-card.png",
                height: 200,
                width: 200,
              ),
            ),
            SizedBox(height: 60),
            Text(
              "No Subscriptions till now",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
