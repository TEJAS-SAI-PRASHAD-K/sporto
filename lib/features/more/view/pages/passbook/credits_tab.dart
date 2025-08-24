import 'package:flutter/material.dart';

class CreditsTab extends StatelessWidget {
  const CreditsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          // TODO: ADD A CARD IMAGE
          SizedBox(height: 60),
          Text(
            "You don't have any credits at this time.",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
