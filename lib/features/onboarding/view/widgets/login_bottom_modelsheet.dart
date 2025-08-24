import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/features/onboarding/view/widgets/auth/otp_input_bottom_modal_sheet.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';
import 'package:icons_plus/icons_plus.dart';

void showCustomModelSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => const CustomModelContent(),
  );
}

class CustomModelContent extends ConsumerStatefulWidget {
  const CustomModelContent({super.key});

  @override
  ConsumerState<CustomModelContent> createState() => _CustomModelContentState();
}

class _CustomModelContentState extends ConsumerState<CustomModelContent> {
  final TextEditingController _mobileController = TextEditingController();

  void _handleEmailLogin(BuildContext context) {
    // TODO: Implement email login logic
  }

  void _handleGoogleLogin(BuildContext context) {
    // TODO: Implement Google login logic
  }

  void _handleSendOtp() async {
    final mobileNumber = _mobileController.text.trim();

    if (mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a mobile number')),
      );
      return;
    }

    // Call the auth view model to send OTP
    await ref
        .read(authViewModelProvider.notifier)
        .signUpWithOtp(mobileNumber: mobileNumber);
  }

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  bool receiveWhatsappUpdates = false;

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
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Enter Mobile Number',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: _mobileController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(9.0)),
                ),
                labelText: 'Mobile Number',
                prefixIcon: Icon(Iconsax.call_bold),
              ),
            ),
            const SizedBox(height: 16),
            Consumer(
              builder: (context, ref, child) {
                final authState = ref.watch(authViewModelProvider);

                // Listen for auth state changes
                ref.listen<AsyncValue<void>?>(authViewModelProvider, (
                  previous,
                  next,
                ) {
                  if (next?.hasError == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(next!.error.toString())),
                    );
                  } else if (next?.hasValue == true) {
                    Navigator.pop(context); // Close the current bottom sheet
                    showOtpInputBottomSheet(
                      context,
                      _mobileController.text.trim(),
                    ); // Show OTP entry sheet
                  }
                });

                return ElevatedButton(
                  onPressed: authState?.isLoading == true
                      ? null
                      : () {
                          _handleSendOtp();
                        },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: authState?.isLoading == true
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Send OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox.adaptive(
                  value: receiveWhatsappUpdates,
                  onChanged: (val) {
                    setState(() {
                      receiveWhatsappUpdates = val ?? false;
                    });
                  },
                ),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (Platform.isIOS || Platform.isMacOS) ...[
                  IconButton(
                    onPressed: () {
                      // Handle email login
                      Navigator.pop(context);
                      _handleEmailLogin(context);
                    },
                    icon: Icon(Iconsax.apple_bold, size: 28),
                    style: IconButton.styleFrom(
                      maximumSize: Size(50, 50),
                      minimumSize: Size(28, 28),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                  ),

                  SizedBox(width: 12),
                ],
                IconButton(
                  onPressed: () {
                    // Handle Email login
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.email_rounded, size: 28),
                  style: IconButton.styleFrom(
                    maximumSize: Size(50, 50),
                    minimumSize: Size(28, 28),
                    foregroundColor: Theme.of(
                      context,
                    ).colorScheme.onInverseSurface,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: 12),
                IconButton(
                  onPressed: () {
                    // Handle Google login
                    Navigator.pop(context);
                    _handleGoogleLogin(context);
                  },
                  icon: Image.asset(
                    "assets/logos/google_light.png",
                    height: 80,
                  ),
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    maximumSize: Size(50, 50),
                    minimumSize: Size(28, 28),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
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

void showOtpInputBottomSheet(BuildContext context, String mobileNumber) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => OtpInputSheet(mobileNumber: mobileNumber),
  );
}
