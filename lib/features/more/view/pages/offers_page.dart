import 'package:flutter/material.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Offers")),
      body: Center(
        child: Text(
          textAlign: TextAlign.center,
          "Sorry seems like there are no offers in your city currently",
          style: TextStyle(
            color: Theme.of(context).colorScheme.outline,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
