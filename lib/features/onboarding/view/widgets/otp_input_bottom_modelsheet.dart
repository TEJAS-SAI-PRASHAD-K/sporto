import 'package:flutter/material.dart';
import 'package:playo/features/onboarding/view/pages/complete_your_profile.dart';
import 'package:playo/features/onboarding/view/widgets/otp_input_row.dart';

class OtpInputSheet extends StatelessWidget {
  const OtpInputSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: viewInsets.bottom + 24,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Enter OTP",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  "+1-212-456-7890",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const OtpInputRow(),
            const SizedBox(height: 32),
            Text(
              "Resend OTP",

              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inverseSurface,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => CompleteYourProfile(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                child: const Text(
                  'Verify',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
