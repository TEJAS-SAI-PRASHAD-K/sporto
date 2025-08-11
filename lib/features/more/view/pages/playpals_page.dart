import 'package:flutter/material.dart';

class PlaypalsPage extends StatefulWidget {
  const PlaypalsPage({super.key});

  @override
  State<PlaypalsPage> createState() => _PlaypalsPageState();
}

class _PlaypalsPageState extends State<PlaypalsPage> {
  void _openFilterSortSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top drag line
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Text(
                      "Filter & Sort",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Sort by options (left)
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sort by",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Sports chips (right)
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),

                              const SizedBox(height: 12),

                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    Text(
                      "Filter Options",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),

                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: Text("Reset"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle apply logic here
                              Navigator.pop(context);
                            },
                            child: Text("Apply"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          bottom: MediaQuery.of(context).padding.bottom,
          left: MediaQuery.of(context).padding.left,
          right: MediaQuery.of(context).padding.right,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top back button
            Padding(
              padding: const EdgeInsets.only(left: 8, top: 8),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),

            // Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "My Playpals",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 12),

            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search Playpals",
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Tabs row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Playpals",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 3,
                        width: 60,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Buttons row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Unsettled Dues Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: Colors.black,
                      ),
                      label: const Text(
                        "Unsettled Dues",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Filter & Sort Button
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _openFilterSortSheet,
                      icon: const Icon(Icons.filter_list, color: Colors.black),
                      label: const Text(
                        "Filter & Sort",
                        style: TextStyle(color: Colors.black),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // No Playpals found text
            const Center(
              child: Text(
                "No Playpals found",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
