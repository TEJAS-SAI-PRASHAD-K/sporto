import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:playo/core/widgets/bottom_navigation_bar.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:playo/core/common/widgets/loader.dart';
import 'package:playo/core/utils/show_snackbar.dart';
import 'package:playo/features/onboarding/providers/auth_state_provider.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'package:playo/features/onboarding/view/pages/complete_your_profile_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;
import 'package:playo/init_dependecies.dart';
import 'package:playo/core/providers/current_user_provider.dart';

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
  bool _isSigningIn = false;

  void _handleEmailLogin() {
    WoltModalSheet.of(context).showAtIndex(1); // Navigate to email input page
  }

  void _handleGoogleLogin() {
    _signInWithGoogle();
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isSigningIn = true;
    });

    try {
      // Use provided web client id for web builds; other platforms pick from
      // platform files (google-services.json / GoogleService-Info.plist).
      const webClientId =
          '907897828805-j5p2gl8a45fdpien3qjq18rvtbdag7gn.apps.googleusercontent.com';

      final googleSignIn = GoogleSignIn(clientId: kIsWeb ? webClientId : null);

      // Always sign out before sign-in to avoid stale sessions (all platforms)
      try {
        await googleSignIn.signOut();
      } catch (e) {
        debugPrint('GoogleSignIn.preSignOut failed: $e');
      }

      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // user cancelled
        try {
          await googleSignIn.signOut();
        } catch (_) {}
        return;
      }

      final googleAuth = await googleUser.authentication;
      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      if (idToken == null) {
        showSnackBar(
          context,
          'Google sign-in failed: missing id token',
          SnackBarType.error,
        );
        return;
      }

      final supabase = serviceLocator<SupabaseClient>();

      final res = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (res.user == null || supabase.auth.currentSession == null) {
        showSnackBar(context, 'Google sign-in failed', SnackBarType.error);
        // Extra: sign out from Google to clear any partial session
        try {
          await googleSignIn.signOut();
        } catch (_) {}
        return;
      }

      // Extract profile info and derive names if missing
      final email = res.user!.email ?? '';
      String firstName = res.user!.userMetadata?['given_name'] as String? ?? '';
      String? lastName = res.user!.userMetadata?['family_name'] as String?;
      final avatar = res.user!.userMetadata?['picture'] as String?;

      if (firstName.isEmpty && email.isNotEmpty) {
        final local = email.split('@').first;
        final parts = local.split(RegExp(r'[._\\-]'));
        if (parts.isNotEmpty) {
          firstName = _capitalize(parts[0]);
          if (parts.length > 1)
            lastName = _capitalize(parts.sublist(1).join(' '));
        }
      }

      final currentUserNotifier = ref.read(
        currentUserNotifierProvider.notifier,
      );

      // Upsert the app-level user after Supabase session is active
      await currentUserNotifier.createOrUpdateUser(
        emailAddress: email,
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatar,
      );

      if (!mounted) return;

      // Read provider state to decide navigation
      final currentUser = ref.read(currentUserNotifierProvider);
      if (currentUser == null) {
        showSnackBar(
          context,
          'Signed in but failed to load profile',
          SnackBarType.error,
        );
        return;
      }

      if (currentUser.firstName.isEmpty) {
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CompleteYourProfile(
              initialFirstName: firstName,
              initialLastName: lastName,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavBar()),
        );
      }
    } catch (e) {
      debugPrint('Error during Google sign-in: $e');
      showSnackBar(
        context,
        'Error signing in with Google: $e',
        SnackBarType.error,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSigningIn = false;
        });
      }
    }
  }

  String _capitalize(String input) {
    if (input.isEmpty) return input;
    return input[0].toUpperCase() + input.substring(1);
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
        final isLoading = ref.watch(
          authViewModelProvider.select((val) => val?.isLoading == true),
        );

        // Listen to auth view model changes (example: when OTP sent)
        ref.listen(authViewModelProvider, (_, next) {
          next?.when(
            data: (_) {
              WoltModalSheet.of(context).showAtIndex(2); // Navigate to OTP page
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
            const SizedBox(height: 20),
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
                // prefixIcon: Icon(Iconsax.call_bold),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoading ? null : _handleSendOtp,
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
                      text: 'By signing up, you agree to the\\n',
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
                SizedBox(
                  width: 50,
                  height: 50,
                  child: _isSigningIn
                      ? const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Loader(),
                          ),
                        )
                      : IconButton(
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
