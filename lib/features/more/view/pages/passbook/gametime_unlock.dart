import 'package:flutter/material.dart';

class GametimeUnlock extends StatelessWidget {
  const GametimeUnlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset("assets/images/credit-card.png"),
          Row(children: [Text("No Subscriptions till now")]),
        ],
      ),
    );
  }
}
