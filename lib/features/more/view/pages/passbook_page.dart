import 'package:flutter/material.dart';
import 'package:playo/features/more/view/pages/passbook/credits_tab.dart';
import 'package:playo/features/more/view/pages/passbook/gametime_unlocked_tab.dart';
import 'package:playo/features/more/view/pages/passbook/karma_tab.dart';
import 'package:playo/features/more/view/pages/passbook/loyalty_tab.dart';
import 'package:playo/features/more/view/pages/passbook/savedcard_tab.dart';

class PassbookPage extends StatefulWidget {
  const PassbookPage({super.key});

  @override
  State<PassbookPage> createState() => _PassbookPageState();
}

class _PassbookPageState extends State<PassbookPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = [
    Tab(text: 'GameTime Unlocked'),
    Tab(text: 'Credits'),
    Tab(text: 'Karma'),
    Tab(text: 'Saved Cards'),
    Tab(text: 'Loyalty/Credits'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Passbook',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            tabs: _tabs,
            tabAlignment: TabAlignment.start,
            indicatorColor: Theme.of(context).colorScheme.primary,
            labelColor: Theme.of(context).colorScheme.primary,
            unselectedLabelColor: Theme.of(context).colorScheme.outline,
            isScrollable: true,
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                GametimeUnlockedTab(),
                CreditsTab(),
                KarmaTab(),
                SavedcardTab(),
                LoyaltyTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
