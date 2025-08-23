import 'package:flutter/material.dart';

class PasbookPage extends StatefulWidget {
  const PasbookPage({super.key});

  @override
  State<PasbookPage> createState() => _PasbookPageState();
}

class _PasbookPageState extends State<PasbookPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        debugPrint("Switched to tab: ${_tabController.index}");
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text("Passbook"),
            elevation: 0,
          ),
          TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: Colors.green,
            indicatorWeight: 3,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black54,
            tabs: const [
              Tab(text: "GameTime Unlocked"),
              Tab(text: "Playo credits"),
              Tab(text: "Karma"),
              Tab(text: "Something"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(child: Text("GameTime Unlocked Content")),
                Center(child: Text("Playo credits Content")),
                Center(child: Text("Karma Content")),
                Center(child: Text("Something Content")),
              ],
            ),
          )
        ],
      ),
    );
  }
}
