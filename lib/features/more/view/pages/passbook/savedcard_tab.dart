import 'package:flutter/material.dart';

class SavedcardTab extends StatelessWidget {
  const SavedcardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 40),

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
