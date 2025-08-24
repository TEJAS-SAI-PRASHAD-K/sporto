import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:playo/core/utils/show_snackbar.dart';
import 'package:playo/features/onboarding/providers/auth_state_provider.dart';
import 'package:playo/features/onboarding/view/pages/complete_your_profile_page.dart';
import 'package:playo/features/onboarding/view/widgets/otp_input_row.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';

const double _pagePadding = 16.0;
const double _buttonHeight = 48.0;

SliverWoltModalSheetPage emailOtpModalPage(BuildContext modalSheetContext) {
  return WoltModalSheetPage(
    topBar: null,
    hasTopBarLayer: false,
    hasSabGradient: false,
    enableDrag: true,
    child: Padding(
      padding: const EdgeInsets.all(_pagePadding),
      child: EmailOtpPageContent(),
    ),
  );
}

class EmailOtpPageContent extends ConsumerStatefulWidget {
  const EmailOtpPageContent({super.key});

  @override
  ConsumerState<EmailOtpPageContent> createState() =>
      _EmailOtpPageContentState();
}

class _EmailOtpPageContentState extends ConsumerState<EmailOtpPageContent> {
  String _otpCode = '';
  bool _isVerifying = false;
  bool _isResending = false;

  void _onOtpChanged(String otp) {
    setState(() {
      _otpCode = otp;
    });
    ref.read(authStateProvider.notifier).setOtpCode(otp);
  }

  Future<void> _verifyOtp() async {
    final authState = ref.read(authStateProvider);
    if (_otpCode.length != 6 || authState.email == null) {
      showSnackBar(
        context,
        'Please enter a valid 6-digit OTP',
        SnackBarType.error,
      );
      return;
    }

    setState(() {
      _isVerifying = true;
    });

    await ref
        .read(authViewModelProvider.notifier)
        .verifyEmailOtp(email: authState.email!, token: _otpCode);
  }

  Future<void> _resendOtp() async {
    final authState = ref.read(authStateProvider);
    if (authState.email == null) return;

    setState(() {
      _isResending = true;
    });

    await ref
        .read(authViewModelProvider.notifier)
        .signUpWithEmailOtp(email: authState.email!);

    setState(() {
      _isResending = false;
    });

    if (mounted) {
      showSnackBar(context, 'OTP sent successfully', SnackBarType.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    // Listen to auth state changes
    ref.listen<AsyncValue<void>?>(authViewModelProvider, (previous, next) {
      if (next != null) {
        if (next.hasError) {
          setState(() {
            _isVerifying = false;
          });
          showSnackBar(context, next.error.toString(), SnackBarType.error);
        } else if (next.hasValue) {
          setState(() {
            _isVerifying = false;
          });
          Navigator.of(context).pop(); // Close the modal
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (builder) => const CompleteYourProfile(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      }
    });

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
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
              "Sent to email",
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(
                  context,
                ).colorScheme.inverseSurface.withValues(alpha: 0.7),
              ),
            ),
            if (authState.email != null)
              Flexible(
                child: Text(
                  authState.email!,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inverseSurface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          "We've sent a 6-digit verification code to your email",
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(
              context,
            ).colorScheme.inverseSurface.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 24),
        OtpInputRow(onOtpChanged: _onOtpChanged),
        const SizedBox(height: 32),
        Center(
          child: GestureDetector(
            onTap: _isResending ? null : _resendOtp,
            child: Text(
              _isResending ? "Sending..." : "Resend OTP",
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 14,
                color: _isResending
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
          onPressed: _isVerifying || _otpCode.length != 6 ? null : _verifyOtp,
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, _buttonHeight),
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          child: _isVerifying
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
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
  }
}
