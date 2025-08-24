import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:playo/core/utils/show_snackbar.dart';
import 'package:playo/features/onboarding/providers/auth_state_provider.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';

const double _pagePadding = 16.0;
const double _buttonHeight = 48.0;

SliverWoltModalSheetPage loginModalPage(BuildContext modalSheetContext) {
  return WoltModalSheetPage(
    topBar: null,
    hasTopBarLayer: false,
    hasSabGradient: false,
    enableDrag: true,
    child: Padding(
      padding: const EdgeInsets.all(_pagePadding),
      child: LoginPageContent(),
    ),
  );
}

class LoginPageContent extends ConsumerStatefulWidget {
  const LoginPageContent({super.key});

  @override
  ConsumerState<LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends ConsumerState<LoginPageContent> {
  final TextEditingController _mobileController = TextEditingController();

  void _handleEmailLogin() {
    WoltModalSheet.of(context).showAtIndex(1); // Navigate to email input page
  }

  void _handleGoogleLogin() {
    // TODO: Implement Google login logic
  }

  Future<void> _handleSendOtp() async {
    final mobileNumber = _mobileController.text.trim();

    if (mobileNumber.isEmpty) {
      showSnackBar(context, 'Please enter a mobile number', SnackBarType.error);
      return;
    }

    // Store mobile number in state
    ref.read(authStateProvider.notifier).setMobileNumber(mobileNumber);

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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Consumer(
      builder: (context, ref, child) {
        final authViewState = ref.watch(authViewModelProvider);

        // Listen for auth state changes
        ref.listen<AsyncValue<void>?>(authViewModelProvider, (previous, next) {
          if (next?.hasError == true) {
            showSnackBar(context, next!.error.toString(), SnackBarType.error);
          } else if (next?.hasValue == true) {
            WoltModalSheet.of(context).showAtIndex(2); // Navigate to OTP page
          }
        });

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            const Text(
              'You\'re almost there!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              'Enter Mobile Number',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
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
            ElevatedButton(
              onPressed: authViewState?.isLoading == true
                  ? null
                  : _handleSendOtp,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, _buttonHeight),
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: authViewState?.isLoading == true
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox.adaptive(
                  value: authState.receiveWhatsappUpdates,
                  onChanged: (val) {
                    ref
                        .read(authStateProvider.notifier)
                        .setReceiveWhatsappUpdates(val ?? false);
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
            const SizedBox(height: 24),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'By signing up, you agree to the\n',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    const TextSpan(
                      text: 'Terms Of Service',
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(
                      text: ' and ',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inverseSurface,
                      ),
                    ),
                    const TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Expanded(child: Divider(thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Or continue with',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (Platform.isIOS || Platform.isMacOS) ...[
                  IconButton(
                    onPressed: _handleEmailLogin,
                    icon: const Icon(Iconsax.apple_bold, size: 28),
                    style: IconButton.styleFrom(
                      maximumSize: const Size(50, 50),
                      minimumSize: const Size(28, 28),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                IconButton(
                  onPressed: _handleEmailLogin,
                  icon: const Icon(Icons.email_rounded, size: 28),
                  style: IconButton.styleFrom(
                    maximumSize: const Size(50, 50),
                    minimumSize: const Size(28, 28),
                    foregroundColor: Theme.of(
                      context,
                    ).colorScheme.onInverseSurface,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                IconButton(
                  onPressed: _handleGoogleLogin,
                  icon: Image.asset(
                    "assets/logos/google_light.png",
                    height: 80,
                  ),
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                    maximumSize: const Size(50, 50),
                    minimumSize: const Size(28, 28),
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
