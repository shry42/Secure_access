import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:secure_access/screens/first_visit_screen.dart';
import 'package:secure_access/screens/provide_phone_number_screen.dart';

class CaptureImageScreen extends StatefulWidget {
  const CaptureImageScreen({super.key});

  @override
  State<CaptureImageScreen> createState() => _CaptureImageScreenState();
}

class _CaptureImageScreenState extends State<CaptureImageScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1500), () {
      Get.to(() =>
          // const FirstVisitScreen()
          const ProvidePhoneNumberScreen()); // Replace NextScreen with the actual name of the next screen
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Smile Please',
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/smile.png',
            height: 40,
          ),
          const SizedBox(height: 10),
          const Text(
            'As a part of our registration process, your photo',
            style: TextStyle(color: Colors.white, fontSize: 20),
            // textAlign: TextAlign.center,
          ),
          const Text(
            'will be captured now',
            style: TextStyle(color: Colors.white, fontSize: 20),
            // textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
