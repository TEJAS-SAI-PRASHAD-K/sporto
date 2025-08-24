import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:playo/core/common/widgets/loader.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';
import 'package:playo/core/utils/show_snackbar.dart';
import 'package:playo/features/onboarding/providers/auth_state_provider.dart';
import 'package:playo/features/onboarding/viewmodel/auth_view_model.dart';

const double _pagePadding = 16.0;
const double _buttonHeight = 48.0;

SliverWoltModalSheetPage emailInputModalPage(BuildContext modalSheetContext) {
  return WoltModalSheetPage(
    topBar: null,
    hasTopBarLayer: false,
    hasSabGradient: false,
    enableDrag: true,
    child: Padding(
      padding: const EdgeInsets.all(_pagePadding),
      child: EmailInputPageContent(),
    ),
  );
}

class EmailInputPageContent extends ConsumerStatefulWidget {
  const EmailInputPageContent({super.key});

  @override
  ConsumerState<EmailInputPageContent> createState() =>
      _EmailInputPageContentState();
}

class _EmailInputPageContentState extends ConsumerState<EmailInputPageContent> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  Future<void> _sendEmailOtp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Store email in state
    ref.read(authStateProvider.notifier).setEmail(_emailController.text.trim());

    await ref
        .read(authViewModelProvider.notifier)
        .signUpWithEmailOtp(email: _emailController.text.trim());
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final isLoading = ref.watch(
          authViewModelProvider.select((val) => val?.isLoading == true),
        );

        // Listen to auth state changes
        ref.listen(authViewModelProvider, (_, next) {
          next?.when(
            data: (_) {
              WoltModalSheet.of(
                context,
              ).showAtIndex(3); // Navigate to email OTP page
            },
            error: (error, st) {
              showSnackBar(context, error.toString(), SnackBarType.error);
            },
            loading: () {},
          );
        });

        return Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              const Text(
                'Enter Email',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "We'll send you an OTP to verify your email address",
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.inverseSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                decoration: InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'Enter your email address',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: isLoading ? null : _sendEmailOtp,
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
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
