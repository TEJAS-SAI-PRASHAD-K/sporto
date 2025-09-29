import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'package:playo/core/common/widgets/loader.dart';
import 'package:playo/core/utils/show_snackbar.dart';
import 'package:playo/core/providers/current_user_provider.dart';
import 'package:playo/features/onboarding/providers/auth_state_provider.dart';
import 'package:playo/features/onboarding/view/pages/complete_your_profile_page.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';
import 'package:playo/core/widgets/bottom_navigation_bar.dart';

enum OtpMedium { phone, email }

/// Public factory for a unified OTP modal sheet page
SliverWoltModalSheetPage otpModalPage(
  BuildContext modalSheetContext, {
  required OtpMedium medium,
}) {
  return WoltModalSheetPage(
    topBar: null,
    hasTopBarLayer: false,
    hasSabGradient: false,
    enableDrag: true,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: _OtpPageContent(medium: medium),
    ),
  );
}

class _OtpPageContent extends ConsumerStatefulWidget {
  const _OtpPageContent({required this.medium});
  final OtpMedium medium;

  @override
  ConsumerState<_OtpPageContent> createState() => _OtpPageContentState();
}

class _OtpPageContentState extends ConsumerState<_OtpPageContent> {
  late final TextEditingController _pinController;
  late final FocusNode _focusNode;
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    final authState = ref.read(authStateProvider);
    final isPhone = widget.medium == OtpMedium.phone;
    final target = isPhone ? authState.mobileNumber : authState.email;
    if (_otpCode.length != 6 || target == null) {
      showSnackBar(
        context,
        'Please enter a valid 6-digit OTP',
        SnackBarType.error,
      );
      return;
    }

    if (isPhone) {
      await ref
          .read(authViewModelProvider.notifier)
          .verifyPhoneOtp(mobileNumber: target, token: _otpCode);
    } else {
      await ref
          .read(authViewModelProvider.notifier)
          .verifyEmailOtp(email: target, token: _otpCode);
    }
  }

  Future<void> _resendOtp() async {
    final authState = ref.read(authStateProvider);
    final isPhone = widget.medium == OtpMedium.phone;
    final target = isPhone ? authState.mobileNumber : authState.email;
    if (target == null) return;

    if (isPhone) {
      await ref
          .read(authViewModelProvider.notifier)
          .signUpWithOtp(mobileNumber: target);
    } else {
      await ref
          .read(authViewModelProvider.notifier)
          .signUpWithEmailOtp(email: target);
    }

    if (mounted) {
      showSnackBar(context, 'OTP sent successfully', SnackBarType.success);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final isPhone = widget.medium == OtpMedium.phone;
    final target = isPhone ? authState.mobileNumber : authState.email;

    return Consumer(
      builder: (context, ref, child) {
        final isLoading = ref.watch(
          authViewModelProvider.select((val) => val?.isLoading == true),
        );

        // Listen to auth state changes
        ref.listen(authViewModelProvider, (_, next) {
          next?.when(
            data: (_) {
              Navigator.of(context).pop(); // Close modal
              final currentUser = ref.read(currentUserProvider);

              if (isPhone) {
                // Phone flow logic: profile required if firstName empty OR favoriteSports empty
                final needsProfile =
                    currentUser == null ||
                    (currentUser.firstName.isEmpty ||
                        (currentUser.favoriteSports == null ||
                            currentUser.favoriteSports!.isEmpty));
                if (needsProfile) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CompleteYourProfile(),
                    ),
                    (route) => false,
                  );
                } else {
                  // Already has profile; simply pop back
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                }
              } else {
                // Email flow logic: profile required if firstName empty
                if (currentUser == null || currentUser.firstName.isEmpty) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CompleteYourProfile(),
                    ),
                    (route) => false,
                  );
                } else {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const BottomNavBar()),
                    (route) => false,
                  );
                }
              }
            },
            error: (error, st) {
              showSnackBar(context, error.toString(), SnackBarType.error);
            },
            loading: () {},
          );
        });

        final colorScheme = Theme.of(context).colorScheme;
        final baseBorderColor = colorScheme.outline;
        final focusedBorderColor = colorScheme.primary;

        final defaultPinTheme = PinTheme(
          width: 48,
          height: 56,
          textStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: colorScheme.inverseSurface,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: baseBorderColor),
          ),
        );

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
                  isPhone ? 'Sent to mobile' : 'Sent to email',
                  style: TextStyle(
                    fontSize: 14,
                    color: colorScheme.inverseSurface.withValues(alpha: 0.7),
                  ),
                ),
                if (target != null)
                  Expanded(
                    child: Text(
                      target,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.inverseSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "We've sent a 6-digit verification code to your ${isPhone ? 'mobile number' : 'email'}",
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.inverseSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Pinput(
                length: 6,
                controller: _pinController,
                focusNode: _focusNode,
                defaultPinTheme: defaultPinTheme,
                separatorBuilder: (index) => const SizedBox(width: 8),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  setState(() => _otpCode = val);
                  ref.read(authStateProvider.notifier).setOtpCode(val);
                },
                onCompleted: (val) {
                  setState(() => _otpCode = val);
                  ref.read(authStateProvider.notifier).setOtpCode(val);
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor, width: 2),
                  ),
                ),
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: defaultPinTheme.decoration!.copyWith(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: focusedBorderColor),
                  ),
                ),
                errorPinTheme: defaultPinTheme.copyBorderWith(
                  border: Border.all(color: colorScheme.error),
                ),
              ),
            ),
            const SizedBox(height: 32),
            Center(
              child: GestureDetector(
                onTap: isLoading ? null : _resendOtp,
                child: Text(
                  isLoading ? 'Sending...' : 'Resend OTP',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                    color: isLoading
                        ? colorScheme.inverseSurface.withValues(alpha: 0.5)
                        : colorScheme.inverseSurface,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading || _otpCode.length != 6 ? null : _verifyOtp,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                backgroundColor: colorScheme.primary,
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
