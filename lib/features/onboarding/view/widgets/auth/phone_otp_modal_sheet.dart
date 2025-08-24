import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:playo/core/common/widgets/loader.dart';
import 'package:playo/core/utils/show_snackbar.dart';
import 'package:playo/features/onboarding/providers/auth_state_provider.dart';
import 'package:playo/features/onboarding/view/pages/complete_your_profile_page.dart';
import 'package:playo/features/onboarding/view/widgets/otp_input_row.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';

const double _pagePadding = 16.0;
const double _buttonHeight = 48.0;

SliverWoltModalSheetPage phoneOtpModalPage(BuildContext modalSheetContext) {
  return WoltModalSheetPage(
    topBar: null,
    hasTopBarLayer: false,
    hasSabGradient: false,
    enableDrag: true,
    child: Padding(
      padding: const EdgeInsets.all(_pagePadding),
      child: PhoneOtpPageContent(),
    ),
  );
}

class PhoneOtpPageContent extends ConsumerStatefulWidget {
  const PhoneOtpPageContent({super.key});

  @override
  ConsumerState<PhoneOtpPageContent> createState() =>
      _PhoneOtpPageContentState();
}

class _PhoneOtpPageContentState extends ConsumerState<PhoneOtpPageContent> {
  String _otpCode = '';

  void _onOtpChanged(String otp) {
    setState(() {
      _otpCode = otp;
    });
    ref.read(authStateProvider.notifier).setOtpCode(otp);
  }

  Future<void> _verifyOtp() async {
    final authState = ref.read(authStateProvider);
    if (_otpCode.length != 6 || authState.mobileNumber == null) {
      showSnackBar(
        context,
        'Please enter a valid 6-digit OTP',
        SnackBarType.error,
      );
      return;
    }

    await ref
        .read(authViewModelProvider.notifier)
        .verifyPhoneOtp(mobileNumber: authState.mobileNumber!, token: _otpCode);
  }

  Future<void> _resendOtp() async {
    final authState = ref.read(authStateProvider);
    if (authState.mobileNumber == null) return;

    await ref
        .read(authViewModelProvider.notifier)
        .signUpWithOtp(mobileNumber: authState.mobileNumber!);

    if (mounted) {
      showSnackBar(context, 'OTP sent successfully', SnackBarType.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Consumer(
      builder: (context, ref, child) {
        final isLoading = ref.watch(
          authViewModelProvider.select((val) => val?.isLoading == true),
        );

        // Listen to auth state changes
        ref.listen(authViewModelProvider, (_, next) {
          next?.when(
            data: (_) {
              Navigator.of(context).pop(); // Close the modal
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (builder) => const CompleteYourProfile(),
                ),
                (Route<dynamic> route) => false,
              );
            },
            error: (error, st) {
              showSnackBar(context, error.toString(), SnackBarType.error);
            },
            loading: () {},
          );
        });

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            const Text(
              'Enter OTP',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sent to mobile",
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.inverseSurface.withValues(alpha: 0.7),
                  ),
                ),
                if (authState.mobileNumber != null)
                  Text(
                    authState.mobileNumber!,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inverseSurface,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            OtpInputRow(onOtpChanged: _onOtpChanged),
            const SizedBox(height: 32),
            Center(
              child: GestureDetector(
                onTap: isLoading ? null : _resendOtp,
                child: Text(
                  isLoading ? "Sending..." : "Resend OTP",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    color: isLoading
                        ? Theme.of(
                            context,
                          ).colorScheme.inverseSurface.withValues(alpha: 0.5)
                        : Theme.of(context).colorScheme.inverseSurface,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading || _otpCode.length != 6 ? null : _verifyOtp,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, _buttonHeight),
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              child: isLoading
                  ? const SizedBox(width: 20, height: 20, child: Loader())
                  : const Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
