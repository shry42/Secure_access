import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:secure_access/common/utils/custom_snackbar.dart';
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/model_face/user_model.dart';
import 'package:secure_access/screens/whom_meeting_today_screen.dart';
import 'package:uuid/uuid.dart';

class FirstVisitScreen extends StatefulWidget {
  const FirstVisitScreen(
      {super.key,
      this.countryCode,
      this.mobNo,
      this.purpose,
      this.image,
      this.faceFeatures});

  final String? countryCode;
  final String? mobNo;
  final String? purpose;
  final String? image;
  final FaceFeatures? faceFeatures;

  @override
  State<FirstVisitScreen> createState() => _FirstVisitScreenState();
}

class _FirstVisitScreenState extends State<FirstVisitScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Uint8List? bytes;
  late String currentTime;
  late String currentDate;

  @override
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                        )),
                    const SizedBox(
                      width: 220,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 150, 199, 24),
                      ),
                      onPressed: () {
                        // Get.to(const MayIKnowYourPurposeScreen());
                        if (_formKey.currentState!.validate()) {
                          // //
                          // String userId = Uuid().v1();
                          // UserModel user = UserModel(
                          //   id: userId,
                          //   name: fullNameController.text,
                          //   image: widget.image,
                          //   registeredOn: '$currentDate $currentTime',
                          //   faceFeatures: widget.faceFeatures,
                          // );
                          // FirebaseFirestore.instance
                          //     .collection("users")
                          //     .doc(userId)
                          //     .set(user.toJson())
                          //     .catchError((e) {})
                          //     .whenComplete(() {
                          //   Future.delayed(const Duration(seconds: 1), () {
                          Get.to(
                            WhomMeetingTodayScreen(
                              countryCode: widget.countryCode,
                              mobNo: widget.mobNo,
                              purpose: widget.purpose,
                              fullName: fullNameController.text,
                              email: emailController.text,
                              image: widget.image,
                              faceFeatures: widget.faceFeatures,
                              // firebaseKey: userId,
                            ),
                          );
                          // });
                          // });
                          //
                          // Get.to(
                          //   WhomMeetingTodayScreen(
                          //     countryCode: widget.countryCode,
                          //     mobNo: widget.mobNo,
                          //     purpose: widget.purpose,
                          //     fullName: fullNameController.text,
                          //     email: emailController.text,
                          //   ),
                          // );
                        }
                      },
                      child: const Text('Next'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Hello! I guess you\'re visiting us for the first time .\n May I know your details?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 221, 216, 216),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      width: 270,
                      height: 40,
                      child: Center(
                        child: Text(
                          '${widget.mobNo}                                                  ',
                          // textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    CircleAvatar(
                      // child: Image.asset(''),
                      backgroundImage:
                          bytes != null ? MemoryImage(bytes!) : null,
                      radius: 20,
                      backgroundColor: const Color.fromARGB(255, 224, 219, 219),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                TextFormField(
                  // controller: emailController,
                  controller: fullNameController,
                  // initialValue: widget.firstName,
                  onChanged: (value) {
                    // AppController.setemailId(emailController.text);
                    // c.userName.value = emailController.text;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: '    Full Name',
                    // hintText: 'username',
                  ),
                  // inputFormatters: [
                  //   FilteringTextInputFormatter.deny(
                  //       RegExp(r'\s')), // no spaces allowed
                  // ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a name";
                    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                      return "Name can only contain alphabets and spaces";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  // controller: emailController,
                  controller: emailController,
                  // initialValue: widget.firstName,
                  onChanged: (value) {
                    // AppController.setemailId(emailController.text);
                    // c.userName.value = emailController.text;
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    labelText: '    Email',
                    // hintText: 'username',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(
                        RegExp(r'\s')), // no spaces allowed
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter an email address";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                        .hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
