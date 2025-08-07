import 'package:flutter/material.dart';

class EmptyGamesWidget extends StatelessWidget {
  final String imageAsset;
  final String title;
  final String buttonText;

  const EmptyGamesWidget({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imageAsset, height: 110, fit: BoxFit.contain),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        if (buttonText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 28),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                minimumSize: const Size(210, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Text(
                buttonText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
