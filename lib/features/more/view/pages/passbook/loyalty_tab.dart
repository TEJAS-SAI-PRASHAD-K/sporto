import 'package:flutter/material.dart';

class LoyaltyTab extends StatelessWidget {
  const LoyaltyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 18),
          Container(
            width: 356,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              color: Theme.of(context).colorScheme.surfaceContainerLow,
            ),
            child: Text(
              "Find all your loyalty and credit balances from all the venues here.",
            ),
          ),

          SizedBox(height: 60),
          Text(
            "No Saved cards or wallets",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
