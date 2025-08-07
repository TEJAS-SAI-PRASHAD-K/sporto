import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.black26,
        title: Row(
          children: [
            // Avatar
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black26, width: 1),
              ),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[100],
                child: Icon(
                  Icons.person_2_rounded,
                  color: Colors.black,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 18),
            // Name and subtitle
            Expanded(
              child: Column(
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
                    style: TextStyle(color: Colors.black54, fontSize: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // First Container with 4 ListTiles
              Flexible(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: ListTile(
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
                          leading: Icon(Icons.people, color: Colors.green),
                          title: Text(
                            'PlayPals',
                            style: TextStyle(fontSize: 14),
                          ),
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
                          leading: Icon(
                            Icons.privacy_tip,
                            color: Colors.purple,
                          ),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
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
                          title: Text(
                            'Rate Us',
                            style: TextStyle(fontSize: 14),
                          ),
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
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
