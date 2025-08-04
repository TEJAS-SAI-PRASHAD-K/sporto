import 'package:flutter/material.dart';

void showCustomModelSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: double.infinity),
          Text('You\'re almost there!'),
          SizedBox(height: 8),
          Text(
            'Enter Mobile Number',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 40),
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mobile Number',
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Send OTP'),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Checkbox.adaptive(value: true, onChanged: (onChanged) {}),
              Expanded(
                child: Text(
                  'I agree to receive updates over Whatsapp',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Text(
                  'By signing up, you agree to the\nTerms Of Service and Privacy Policy',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: Divider(thickness: 1)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'or continue with',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Expanded(child: Divider(thickness: 1)),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Handle email login
                    Navigator.pop(context);
                    _handleEmailLogin(context);
                  },
                  icon: Icon(Icons.email_outlined, size: 20),
                  label: Text('Email'),
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
                  icon: Image.asset(
                    'assets/images/google_icon.png',
                    height: 22,
                  ),
                  label: Text('Google'),
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
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
