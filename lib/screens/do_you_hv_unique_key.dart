import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/controllers/unique_key_visitor.dart';
import 'package:secure_access/model_face/user_model.dart';
import 'package:secure_access/screens/carrying_asset_screen.dart';
import 'package:secure_access/screens/provide_phone_number_screen.dart';
import 'package:secure_access/screens/whom_meeting_today_screen.dart';
import 'package:secure_access/utils/toast_notify.dart';

class DoYouHaveUniqueKey extends StatefulWidget {
  const DoYouHaveUniqueKey(
      {super.key,
      this.countryCode,
      this.fullName,
      this.email,
      this.purpose,
      this.mobNo,
      this.meetingFor,
      this.firebaseKey,
      this.image,
      this.faceFeatures});

  final String? countryCode, fullName, email, purpose, mobNo, firebaseKey;
  final int? meetingFor;
  final String? image;
  final FaceFeatures? faceFeatures;

  @override
  State<DoYouHaveUniqueKey> createState() => _DoYouHaveUniqueKeyState();
}

class _DoYouHaveUniqueKeyState extends State<DoYouHaveUniqueKey> {
  final TextEditingController uniqueKeyController = TextEditingController();
  final TextEditingController mobileControlller = TextEditingController();
  final UniqueKeyController ukc = UniqueKeyController();
  final _formKey = GlobalKey<FormState>();

  bool isYes = false;

  // late String currentTime;
  // late String currentDate;
  late String selectedCountryCode;

  final String? toolName = '';
  final String? make = '';
  final String? quantity = '';
  final String? remark = '';
  int? hasTool = 0;

  late XFile? selectedImage;
  bool displayImage = false;
  String? base64ImageTool;
  Uint8List? bytes;
  late String currentTime;
  late String currentDate;

  @override
  void initState() {
    void initState() {
      String base64String =
          widget.image.toString(); // Replace with your base64 string
      bytes = base64Decode(base64String);
      // Get the current date
      DateTime now = DateTime.now();
      currentDate =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      // Get the current time in 24-hour format
      currentTime =
          "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

      super.initState();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Do you have unique key?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                // const SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            hasTool = 1;
                            isYes = true;
                          });
                        },
                        child: const Text(
                          'Yes',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 50),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () {
                          if (AppController.noMatched == 'Yes') {
                            Get.to(
                              WhomMeetingTodayScreen(
                                countryCode: AppController.countryCode,
                                email: AppController.email,
                                mobNo: AppController.mobile,
                                // purpose: widget.purpose,
                                // meetingFor: nameId,
                                image: widget.image,
                                faceFeatures: widget.faceFeatures,
                                firebaseKey: AppController.firebaseKey,
                              ),
                            );
                          } else {
                            Get.to(ProvidePhoneNumberScreen(
                              image: widget.image,
                              faceFeatures: widget.faceFeatures,
                            ));
                          }
                        },
                        child: const Text(
                          'No',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                if (isYes == true)
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: uniqueKeyController,
                            onChanged: (value) {
                              // AppController.setemailId(emailController.text);
                              // c.userName.value = emailController.text;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: '    unique key',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Unique key";
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 4),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: mobileControlller,
                            onChanged: (value) {
                              // AppController.setemailId(emailController.text);
                              // c.userName.value = emailController.text;
                            },
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              labelText: '    mobile number',
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter mobile number";
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                await ukc.getUniqueVistorByUniqueKey(
                                    uniqueKeyController.text,
                                    mobileControlller.text);
                                if (AppController.isValidKey == 1) {
                                  Get.to(CarryingAssetsScreen(
                                    countryCode: AppController.countryCode,
                                    fullName: AppController.noName,
                                    email: AppController.email,
                                    mobNo: AppController.mobile,
                                    image: widget.image,
                                    faceFeatures: widget.faceFeatures,
                                    firebaseKey: AppController.firebaseKey,
                                  ));
                                } else {
                                  return;
                                }
                              }
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.black),
                            ))
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
