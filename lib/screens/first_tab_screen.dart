import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:secure_access/authenticate_face/authenticate_face_view.dart';
import 'package:secure_access/common/utils/custom_snackbar.dart';
import 'package:secure_access/common/utils/screen_size_util.dart';
import 'package:secure_access/screens/checkout_authenticate.dart';

class FirstTabScreen extends StatefulWidget {
  const FirstTabScreen({super.key});

  @override
  State<FirstTabScreen> createState() => _FirstTabScreenState();
}

class _FirstTabScreenState extends State<FirstTabScreen> {
  @override
  Widget build(BuildContext context) {
    initializeUtilContexts(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 118,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('வரவேற்பு'),
              SizedBox(
                width: 25,
              )
            ],
          ),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 160,
              ),
              Text(
                'स्वागत है',
                style: TextStyle(fontSize: 22),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 25,
              ),
              Text('Wollenna'),
            ],
          ),
          const SizedBox(height: 5),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/hi.png',
                  height: 40,
                ),
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 35, color: Colors.black),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 30,
              ),
              Text(
                'Failte',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 140,
              ),
              Text(
                'Добродошли',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
              ),
              Text(
                'Boolkhent!',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 7),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
              ),
              Text(
                'Bienvenida',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
              ),
              Text(
                'ಸ್ವಾಗತ',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                width: 145,
              ),
              Text(
                '歡迎',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
              ),
              Text(
                'ようこそ',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          const SizedBox(
            height: 258.05,
          ),
          Stack(children: [
            Container(
              height: 80,
              color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(const AuthenticateCheckoutView());
                        },
                        child: const Text(
                          'Checkout',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 50,
              left: 110,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  // Get.to(const CaptureImageScreen());
                  // Get.to(const ThankyouFinalScreen());
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AuthenticateFaceView(),
                    ),
                  );
                },
                child: const Text(
                  'Tap to Check In',
                  style: TextStyle(
                      color: Color.fromARGB(255, 12, 44, 13), fontSize: 18),
                ),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  void initializeUtilContexts(BuildContext context) {
    ScreenSizeUtil.context = context;
    CustomSnackBar.context = context;
  }
}
