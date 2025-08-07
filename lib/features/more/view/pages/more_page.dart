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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // First Container with 4 ListTiles
            Expanded(
              flex: 4,
              child: Container(
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
                  children: [
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.blueAccent),
                      title: Text('Profile Settings'),
                      subtitle: Text('Manage your personal information'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.notifications, color: Colors.orange),
                      title: Text('Notifications'),
                      subtitle: Text('Configure notification preferences'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.security, color: Colors.green),
                      title: Text('Privacy & Security'),
                      subtitle: Text('Manage privacy settings'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.payment, color: Colors.purple),
                      title: Text('Payment Methods'),
                      subtitle: Text('Manage cards and payment options'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Second Container with 5 ListTiles
            Expanded(
              flex: 5,
              child: Container(
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
                  children: [
                    ListTile(
                      leading: Icon(Icons.help, color: Colors.blue),
                      title: Text('Help & Support'),
                      subtitle: Text('Get help and contact support'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.info, color: Colors.teal),
                      title: Text('About'),
                      subtitle: Text('App version and information'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.star, color: Colors.amber),
                      title: Text('Rate Us'),
                      subtitle: Text('Rate our app on the store'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.share, color: Colors.indigo),
                      title: Text('Share App'),
                      subtitle: Text('Share with friends and family'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
                    ),
                    Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text('Logout'),
                      subtitle: Text('Sign out of your account'),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {},
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
