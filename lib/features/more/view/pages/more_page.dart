import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:playo/features/more/view/pages/my_bookings_page.dart';
import 'package:playo/features/more/view/pages/offers_page.dart';
import 'package:playo/features/more/view/pages/playpals_page.dart';
import 'package:playo/features/more/view/pages/preference_and_privacy_page.dart';
import 'package:playo/features/more/view/pages/refer_and_earn_page.dart';
import 'package:playo/features/more/view/widgets/more_list_tile.dart';
import 'package:playo/features/more/view/widgets/signout_dialogue_box.dart';

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
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text('View your profile', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MoreListTile(
                        isFirst: true,
                        leading: Iconsax.receipt_copy,
                        title: 'My Bookings',
                        subTitle: "View Transactions & Receipts",
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyBookingsPage(),
                            ),
                          );
                        },
                        tileColor: null,
                        titleStyle: TextStyle(fontSize: 16),
                      ),
                      MoreListTile(
                        isFirst: false,
                        leading: Iconsax.people_copy,
                        title: 'PlayPals',
                        subTitle: "View & Manage Players",
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaypalsPage(),
                            ),
                          );
                        },
                        tileColor: null,
                        titleStyle: TextStyle(fontSize: 16),
                      ),
                      MoreListTile(
                        isFirst: false,
                        leading: Iconsax.money_copy,
                        title: 'Passbook',
                        subTitle: "Manage Score, Playo credits, etc",
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => PassbookPage(),
                          //   ),
                          // );
                        },
                        tileColor: null,
                        titleStyle: TextStyle(fontSize: 16),
                      ),
                      MoreListTile(
                        isFirst: false,
                        leading: Iconsax.security_copy,
                        title: 'Preference and Privacy',
                        subTitle: "Sports, Locations, notifications, etc",
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => PreferenceAndPrivacyPage(),
                            ),
                          );
                        },
                        tileColor: null,
                        titleStyle: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MoreListTile(
                        isFirst: true,
                        leading: Iconsax.discount_shape_copy,
                        title: 'Offers',
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => OffersPage(),
                            ),
                          );
                        },
                        tileColor: null,
                        titleStyle: TextStyle(fontSize: 16),
                      ),
                      MoreListTile(
                        isFirst: false,
                        leading: Iconsax.gift_copy,
                        title: 'Invite and Earn',
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => ReferAndEarnPage(),
                            ),
                          );
                        },
                        tileColor: null,
                        titleStyle: TextStyle(fontSize: 16),
                      ),
                      MoreListTile(
                        isFirst: false,
                        leading: Iconsax.support_copy,
                        title: 'Help & Support',
                        onTap: () {},
                        tileColor: null,
                        titleStyle: TextStyle(fontSize: 16),
                      ),
                      MoreListTile(
                        isFirst: false,
                        leading: Iconsax.logout_copy,
                        title: 'Logout',
                        onTap: () {
                          showSignOutDialog(context);
                        },
                        tileColor: null,
                        leadingIconColor: Theme.of(context).colorScheme.error,
                        titleStyle: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.bold,
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
