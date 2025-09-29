import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:playo/core/models/user.dart';
import 'package:playo/core/providers/current_user_provider.dart';
import 'package:playo/features/more/view/pages/help_and_support_page.dart';
import 'package:playo/features/more/view/pages/my_bookings_page.dart';
import 'package:playo/features/more/view/pages/offers_page.dart';
import 'package:playo/features/more/view/pages/passbook_page.dart';
import 'package:playo/features/more/view/pages/playpals_page.dart';
import 'package:playo/features/more/view/pages/preference_and_privacy_page.dart';
import 'package:playo/features/more/view/pages/refer_and_earn_page.dart';
import 'package:playo/features/more/view/widgets/more_list_tile.dart';
import 'package:playo/features/more/view/widgets/signout_dialogue_box.dart';
import 'package:playo/core/common/pages/profile_page.dart';

class MorePage extends ConsumerStatefulWidget {
  const MorePage({super.key});

  @override
  ConsumerState<MorePage> createState() => _MorePageState();
}

class _MorePageState extends ConsumerState<MorePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(userId: user?.userId ?? ''),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Avatar
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.primaryContainer,
                    child: _buildAvatarImage(user),
                  ),
                ),
                const SizedBox(width: 18),
                // Name and subtitle
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user?.firstName ?? 'Profile Name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text('View your profile', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => PassbookPage(),
                            ),
                          );
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
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => HelpAndSupportPage(),
                            ),
                          );
                        },
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

  Widget _buildAvatarImage(User? user) {
    // If no user or no avatarUrl, show default
    if (user?.avatarUrl == null || user!.avatarUrl!.isEmpty) {
      return ClipOval(
        child: Image.asset(
          "assets/images/boy_10.png",
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      );
    }

    final avatarUrl = user.avatarUrl!;

    // Check if it's a network URL (starts with http/https)
    if (avatarUrl.startsWith('http://') || avatarUrl.startsWith('https://')) {
      return ClipOval(
        child: Image.network(
          avatarUrl,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return ClipOval(
              child: Image.asset(
                "assets/images/boy_10.png",
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      );
    }

    // Otherwise, treat it as an asset path (from onboarding selection)
    return ClipOval(
      child: Image.asset(
        avatarUrl.startsWith('assets/')
            ? avatarUrl
            : "assets/images/$avatarUrl",
        width: 40,
        height: 40,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return ClipOval(
            child: Image.asset(
              "assets/images/boy_10.png",
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
