import 'package:flutter/material.dart';
import 'package:playo/features/onboarding/view/pages/onboarding_page.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            // Avatar
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(9)),
              child: CircleAvatar(
                radius: 20,
                foregroundImage: AssetImage("assets/images/boy_10.png"),
              ),
            ),
            const SizedBox(width: 18),
            // Name and subtitle
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Profile Name',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'View your profile',
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Container with 4 ListTiles
            Flexible(
              flex: 4,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tileColor: Theme.of(
                          context,
                        ).colorScheme.surfaceContainerLow,
                        leading: Icon(Icons.person, color: Colors.blueAccent),
                        title: Text(
                          'Profile Settings',
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          'Manage your personal information',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                    ),
                    Divider(height: 1),
                    Flexible(
                      child: ListTile(
                        leading: Icon(Icons.payment, color: Colors.orange),
                        title: Text(
                          'My Bookings',
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          'View Transactions and Receipts',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                    ),
                    Divider(height: 1),
                    Flexible(
                      child: ListTile(
                        leading: Icon(
                          Icons.people,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text('PlayPals', style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                          'Edit and Manage Players',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                    ),
                    Divider(height: 1),
                    Flexible(
                      child: ListTile(
                        leading: Icon(Icons.privacy_tip, color: Colors.purple),
                        title: Text(
                          'Priference and Privacy',
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          'Sports, Location, Notifications, etc',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Second Container with 5 ListTiles
            Flexible(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ListTile(
                        leading: Icon(Icons.help, color: Colors.blue),
                        title: Text(
                          'Help & Support',
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          'Get help and contact support',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                    ),
                    Divider(height: 1),
                    Flexible(
                      child: ListTile(
                        leading: Icon(Icons.info, color: Colors.teal),
                        title: Text('About', style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                          'App version and information',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                    ),
                    Divider(height: 1),
                    Flexible(
                      child: ListTile(
                        leading: Icon(Icons.star, color: Colors.amber),
                        title: Text('Rate Us', style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                          'Rate our app on the store',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                    ),
                    Divider(height: 1),
                    Flexible(
                      child: ListTile(
                        leading: Icon(Icons.share, color: Colors.indigo),
                        title: Text(
                          'Share App',
                          style: TextStyle(fontSize: 14),
                        ),
                        subtitle: Text(
                          'Share with friends and family',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {},
                      ),
                    ),
                    Divider(height: 1),
                    Flexible(
                      child: ListTile(
                        leading: Icon(Icons.logout, color: Colors.red),
                        title: Text('Logout', style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                          'Sign out of your account',
                          style: TextStyle(fontSize: 12),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),

                              content: Text(
                                'Do you want to sign out of your account?',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              actions: [
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                    ),
                                  ),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign Out',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onPrimary,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OnboardingPage(),
                                      ),
                                      (Route<dynamic> route) => false,
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
