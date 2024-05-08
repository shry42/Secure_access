import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:secure_access/screens/capture_image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secure_access',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 118,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('வரவேற்பு'),
              SizedBox(
                width: 25,
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
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
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 25,
              ),
              Text('Wollenna'),
            ],
          ),
          SizedBox(height: 5),
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
          SizedBox(height: 18),
          Row(
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
          SizedBox(height: 10),
          Row(
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
          SizedBox(height: 7),
          Row(
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
          SizedBox(height: 10),
          Row(
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
          SizedBox(height: 12),
          Row(
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
          SizedBox(
            height: 210,
          ),
          Stack(children: [
            Container(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.logout,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Checkout',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  )
                ],
              ),
              color: Colors.green,
            ),
            Positioned(
              bottom: 50,
              left: 110,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  Get.to(const CaptureImageScreen());
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
}
