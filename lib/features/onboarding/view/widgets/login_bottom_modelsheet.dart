import 'dart:io';
import 'package:flutter/material.dart';
import 'package:playo/features/onboarding/view/widgets/otp_input_bottom_modelsheet.dart';
import 'package:icons_plus/icons_plus.dart';

void showCustomModelSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => const CustomModelContent(),
  );
}

class CustomModelContent extends StatelessWidget {
  const CustomModelContent({super.key});

  void _handleEmailLogin(BuildContext context) {
    // TODO: Implement email login logic
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Email login clicked')));
  }

  void _handleGoogleLogin(BuildContext context) {
    // TODO: Implement Google login logic
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Google login clicked')));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: mediaQuery.viewInsets.bottom,
        left: 16,
        right: 16,
        top: 8,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'You\'re almost there!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter Mobile Number',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Mobile Number',
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the current bottom sheet
                showOtpInputBottomSheet(context); // Show OTP entry sheet
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Send OTP',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox.adaptive(value: true, onChanged: (_) {}),
                Expanded(
                  child: Text(
                    'I agree to receive updates over WhatsApp',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),

            SizedBox(height: 24),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'By signing up, you agree to the\n',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  TextSpan(
                    text: 'Terms Of Service',
                    style: TextStyle(color: Colors.blue),
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Or continue with',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Expanded(child: Divider(thickness: 1)),
              ],
            ),
            SizedBox(height: 16),

            Row(
              children: [
                if (Platform.isIOS || Platform.isMacOS) ...[
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // Handle email login
                        Navigator.pop(context);
                        _handleEmailLogin(context);
                      },
                      icon: Icon(Icons.apple_rounded, size: 16),
                      label: Text('Apple', style: TextStyle(fontSize: 12)),
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(0, 45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                ],
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Handle email login
                      Navigator.pop(context);
                      _handleEmailLogin(context);
                    },
                    icon: Icon(Icons.email_outlined, size: 16),
                    label: Text('Email', style: TextStyle(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(0, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Handle Google login
                      Navigator.pop(context);
                      _handleGoogleLogin(context);
                    },
                    icon: Icon(Bootstrap.google, size: 16),
                    label: Text('Google', style: TextStyle(fontSize: 12)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(0, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}

void showOtpInputBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => const OtpInputSheet(),
  );
}
