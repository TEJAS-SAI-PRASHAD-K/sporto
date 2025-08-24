import 'package:flutter/material.dart';
import 'package:playo/core/common/widgets/main_app_bar.dart';

class TrainPage extends StatefulWidget {
  const TrainPage({super.key});

  @override
  State<TrainPage> createState() => _TrainPageState();
}

class _TrainPageState extends State<TrainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Search By Academy', style: TextStyle(fontSize: 16)),
                  Icon(Icons.search),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.list, size: 20),
                          SizedBox(width: 6),
                          Text("List with Us"),
                        ],
                      ),
                    ),
                  ),

                  // Divider
                  Container(
                    height: 20,
                    width: 1,
                    color: Colors.grey,
                    margin: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 6),
                          Icon(Icons.question_answer, size: 20),
                          SizedBox(width: 6),
                          Text("Queries"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "What're you looking up to level up on?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
