import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirstVisitScreen extends StatefulWidget {
  const FirstVisitScreen({super.key});

  @override
  State<FirstVisitScreen> createState() => _FirstVisitScreenState();
}

class _FirstVisitScreenState extends State<FirstVisitScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.arrow_back_ios),
                SizedBox(
                  width: 220,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 150, 199, 24)),
                  onPressed: () {},
                  child: Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              'Hello! I guess you\'re visiting us for the first time .\n May I know your details?',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 216, 216),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10)),
                  width: 280,
                  height: 40,
                  child: Center(
                    child: Text(
                      '9893726374                                                  ',
                      // textAlign: TextAlign.start,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                CircleAvatar(
                  // child: Image.asset(''),
                  radius: 20,
                  backgroundColor: const Color.fromARGB(255, 224, 219, 219),
                )
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 221, 216, 216),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10)),
                  width: 330,
                  height: 40,
                  child: Center(
                    child: Text(
                      'Shravan Yadav                                                               ',
                      // textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
