import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/utils/show_snackbar.dart';
import 'package:playo/features/onboarding/view/pages/complete_your_profile_page.dart';
import 'package:playo/features/onboarding/view/widgets/otp_input_row.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';

class EmailOtpInputSheet extends ConsumerStatefulWidget {
  final String email;

  const EmailOtpInputSheet({super.key, required this.email});

  @override
  ConsumerState<EmailOtpInputSheet> createState() => _EmailOtpInputSheetState();
}

class _EmailOtpInputSheetState extends ConsumerState<EmailOtpInputSheet> {
  String _otpCode = '';
  bool _isVerifying = false;
  bool _isResending = false;

  void _onOtpChanged(String otp) {
    setState(() {
      _otpCode = otp;
    });
  }

  Future<void> _verifyOtp() async {
    if (_otpCode.length != 6) {
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
        .verifyEmailOtp(email: widget.email, token: _otpCode);
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isResending = true;
    });

    await ref
        .read(authViewModelProvider.notifier)
        .signUpWithEmailOtp(email: widget.email);

    setState(() {
      _isResending = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;

    // Listen to auth state changes
    ref.listen<AsyncValue<void>?>(authViewModelProvider, (previous, next) {
      if (next != null) {
        if (next.hasError) {
          setState(() {
            _isVerifying = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error.toString()),
              backgroundColor: Colors.red,
            ),
          );
        } else if (next.hasValue) {
          setState(() {
            _isVerifying = false;
          });
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => CompleteYourProfile()),
            (Route<dynamic> route) => false,
          );
        }
      }
    });

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
                Flexible(
                  child: Text(
                    widget.email,
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
            GestureDetector(
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
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isVerifying || _otpCode.length != 6
                    ? null
                    : _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isVerifying
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
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
            ),
          ],
        ),
      ),
    );
  }
}
