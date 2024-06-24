import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/controllers/user_by_firebase_id_controller.dart';
import 'package:secure_access/model_face/user_model.dart';
import 'package:secure_access/screens/carrying_asset_screen.dart';
import 'package:secure_access/screens/do_you_hv_unique_key.dart';
import 'package:secure_access/screens/login_screen.dart';
import 'package:secure_access/screens/provide_phone_number_screen.dart';
import 'package:secure_access/screens/whom_meeting_today_screen.dart';

class IdentifiedImageScreen extends StatefulWidget {
  final UserModel user;
  final dynamic dispImg;
  final FaceFeatures? faceFeatures;
  const IdentifiedImageScreen(
      {super.key,
      required this.user,
      required this.dispImg,
      this.faceFeatures});

  @override
  State<IdentifiedImageScreen> createState() => _IdentifiedImageScreenState();
}

class _IdentifiedImageScreenState extends State<IdentifiedImageScreen> {
  dynamic image;
  final UserByFirebaseIdController ubfic = UserByFirebaseIdController();
  @override
  void initState() {
    String base64String = widget.dispImg; // Replace with your base64 string
    Uint8List bytes = base64Decode(base64String);
    image = Image.memory(bytes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("${AppController.accessToken}");
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
              height: 320,
              width: 280,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(height: 80, width: 80, child: image),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'We recognise you from your \n      last visit!',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Are you ${widget.user.name}?',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
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
                            // Get.offAll(
                            //     ProvidePhoneNumberScreen(
                            //       firebaseKey: '${widget.user.id}',
                            //       faceFeatures: widget.faceFeatures,
                            //       image: widget.dispImg,
                            //     ),
                            //     transition: Transition.rightToLeft,
                            //     duration: const Duration(milliseconds: 500));
                            Get.offAll(
                              // ProvidePhoneNumberScreen(
                              //   firebaseKey: '${widget.user.id}',
                              // ),
                              const DoYouHaveUniqueKey(),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            );
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
                            // if (AppController.accessToken == null) {
                            //   Get.offAll(LoginPage());
                            // } else
                            // if (AppController.noMatched == 'No') {
                            Get.offAll(
                              DoYouHaveUniqueKey(
                                faceFeatures: widget.faceFeatures,
                                image: widget.dispImg,
                                firebaseKey: AppController.firebaseKey,
                              ),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 500),
                            );
                            // Get.to(MayIKnowYourPurposeScreen(
                            //   countryCode: selectedCountryCode,
                            //   mobileNumber: _phoneController.text,
                            //   image: widget.image ?? '',
                            //   faceFeatures: widget.faceFeatures,
                            // ));
                            // }
                            // else {
                            // Get.offAll(
                            //   WhomMeetingTodayScreen(
                            //     firebaseKey: '${widget.user.id}',
                            //   ),
                            //   transition: Transition.rightToLeft,
                            //   duration: const Duration(milliseconds: 500),
                            // );
                            // Get.to(CarryingAssetsScreen(
                            //   countryCode: AppController.countryCode,
                            //   fullName: AppController.noName,
                            //   email: AppController.email,
                            //   mobNo: AppController.mobile,
                            //   // image: widget.image,
                            //   // faceFeatures: widget.faceFeatures,
                            //   firebaseKey: AppController.firebaseKey,
                            // ));
                            // }
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
