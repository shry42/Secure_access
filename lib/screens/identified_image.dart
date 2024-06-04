import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:secure_access/model_face/user_model.dart';
import 'package:secure_access/screens/provide_phone_number_screen.dart';

class IdentifiedImageScreen extends StatefulWidget {
  final UserModel user;
  final dynamic dispImg;
  const IdentifiedImageScreen(
      {super.key, required this.user, required this.dispImg});

  @override
  State<IdentifiedImageScreen> createState() => _IdentifiedImageScreenState();
}

class _IdentifiedImageScreenState extends State<IdentifiedImageScreen> {
  dynamic image;
  @override
  void initState() {
    String base64String = widget.dispImg; // Replace with your base64 string
    Uint8List bytes = base64Decode(base64String);
    image = Image.memory(bytes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              height: 300,
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 80, width: 80, child: image),
                  SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'We recognise you from your \n      last visit!',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Are you ${widget.user.name}?',
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 40),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            Get.offAll(const ProvidePhoneNumberScreen(),
                                transition: Transition.rightToLeft,
                                duration: Duration(seconds: 1));
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(
                                color: Color.fromARGB(255, 152, 225, 50),
                                fontSize: 18),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(100, 40),
                            backgroundColor: Color.fromARGB(255, 152, 225, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            Get.offAll(const ProvidePhoneNumberScreen(),
                                transition: Transition.rightToLeft,
                                duration: Duration(seconds: 1));
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(
                                color: Color.fromARGB(255, 249, 249, 249),
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
