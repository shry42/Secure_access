import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/controllers/checkout_controller.dart';
import 'package:secure_access/controllers/user_by_firebase_id_controller.dart';
import 'package:secure_access/model_face/user_model.dart';
import 'package:secure_access/screens/first_tab_screen.dart';
import 'package:secure_access/utils/toast_notify.dart';

class IdentifiedCheckoutScreen extends StatefulWidget {
  final UserModel user;
  final dynamic dispImg;
  const IdentifiedCheckoutScreen(
      {super.key, required this.user, required this.dispImg});

  @override
  State<IdentifiedCheckoutScreen> createState() =>
      _IdentifiedCheckoutScreenState();
}

class _IdentifiedCheckoutScreenState extends State<IdentifiedCheckoutScreen> {
  dynamic image;
  final UserByFirebaseIdController ubfic = UserByFirebaseIdController();
  final CheckoutController cc = CheckoutController();
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
              height: 400,
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 80, width: 80, child: image),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'We recognise you from your \n      last visit!',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    textAlign: TextAlign.center,
                    'Hello ${widget.user.name}\nDo you want to checkout?',
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
                            minimumSize: const Size(100, 40),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            toast('Chckout cancelled');
                            Get.offAll(const FirstTabScreen());
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
                            minimumSize: const Size(100, 40),
                            backgroundColor:
                                const Color.fromARGB(255, 152, 225, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () async {
                            await ubfic.getNamesList('${widget.user.id}');
                            if (AppController.visitorInviteStatus == 1) {
                              await cc.checkout(AppController.visitorId);
                              toast('Checkout successful');
                              Get.offAll(const FirstTabScreen());
                            } else {
                              toast('Your Checkin is not yet approved');
                              Get.offAll(const FirstTabScreen());
                            }
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
