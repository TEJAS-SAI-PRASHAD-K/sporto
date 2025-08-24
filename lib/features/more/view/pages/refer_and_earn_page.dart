import 'package:flutter/material.dart';
import 'package:playo/core/utils/show_snackbar.dart';
import 'package:share_plus/share_plus.dart';

class ReferAndEarnPage extends StatefulWidget {
  const ReferAndEarnPage({super.key});

  @override
  State<ReferAndEarnPage> createState() => _ReferAndEarnPageState();
}

class _ReferAndEarnPageState extends State<ReferAndEarnPage> {
  Future<ShareParams> _shareContent() async {
    final shareParams = ShareParams(
      text: 'Hey you have to checkout this is the bestq qThis is the referral link to be shared',
      subject: 'refer and earn',
      title: 'Referral Link',
    );
    return shareParams;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Do Good. Get Good",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                "Invite friends to join them and play with you",
                style: TextStyle(color: Theme.of(context).colorScheme.outline),
              ),
              SizedBox(height: 16),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Refer now and earn",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 18,
                                ),
                              ),
                              TextSpan(
                                text: " 50 Karma ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 28,
                                ),
                              ),
                              TextSpan(
                                text: "Points",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          "Send a reffaral link to your friends via SMS,\nEmail, WhatsApp or others",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                "0 Referrals Earned",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 24,
                ),
              ),
            ],
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              minimumSize: Size(MediaQuery.sizeOf(context).width - 50, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(9),
              ),
            ),
            onPressed: () async {
              final shareParams = _shareContent();
              final result = await SharePlus.instance.share(await shareParams);
              if (result.status == ShareResultStatus.success) {
                showSnackBar(
                  context,
                  'You now earned 50 credits',
                  SnackBarType.success,
                );
              }
            },
            child: Text(
              "REFER NOW",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
