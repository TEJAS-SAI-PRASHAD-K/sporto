import 'package:flutter/material.dart';

class KarmaTab extends StatelessWidget {
  const KarmaTab({super.key});

  final karma = 50;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 40),
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
              "Earn karma by participating in games and use\nthem to get discounts while booking venues \nand experiences.",
            ),
          ),

          SizedBox(height: 16),
          Container(
            width: 356,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: "Lifetime earned karma\n",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: "$karma",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: 356,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            child: Text.rich(
              textAlign: TextAlign.center,
              TextSpan(
                children: [
                  TextSpan(
                    text: "Available Karma for Redemption\n",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ),
                  TextSpan(
                    text: "$karma",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: Size(MediaQuery.sizeOf(context).width - 72, 56),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(9),
              ),
            ),
            onPressed: () {},
            child: Text(
              "REDEEM NOW",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
