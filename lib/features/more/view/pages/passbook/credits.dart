import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

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
              "You don't have any credits at this time.",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
