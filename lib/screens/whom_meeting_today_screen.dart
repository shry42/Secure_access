import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/controllers/usernames_whom_to_meet_controller.dart';
import 'package:secure_access/screens/carrying_asset_screen.dart';
import 'package:secure_access/screens/may_i_know_purpose_screen.dart';
import 'package:secure_access/screens/thankyou_screen.dart';

class WhomMeetingTodayScreen extends StatefulWidget {
  const WhomMeetingTodayScreen(
      {super.key,
      this.countryCode,
      this.fullName,
      this.email,
      this.purpose,
      this.mobNo});

  final String? countryCode, fullName, email, purpose, mobNo;
  // final String? mobNo;
  // final String? purpose;

  @override
  State<WhomMeetingTodayScreen> createState() => _WhomMeetingTodayScreenState();
}

class _WhomMeetingTodayScreenState extends State<WhomMeetingTodayScreen> {
  final UserNamesWhomToMeetController unwtmc = UserNamesWhomToMeetController();
  final _formKey = GlobalKey<FormState>();

  List<dynamic> namesList = [];

  int? nameId;

  void getListNames() async {
    namesList = await unwtmc.getNamesList();
    setState(() {});
  }

  @override
  void initState() {
    getListNames();
    // setState(() {
    //   namesList = unwtmc.getNamesList();
    // });
    super.initState();
  }

  // List namesList = ['rohan', 'sangam', 'shravan'];

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
                    backgroundColor: const Color.fromARGB(2, 192, 198, 199),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (AppController.noMatched == 'No') {
                        Get.to(CarryingAssetsScreen(
                          countryCode: widget.countryCode,
                          fullName: widget.fullName,
                          email: widget.email,
                          mobNo: widget.mobNo,
                          purpose: widget.purpose,
                          meetingFor: nameId,
                        ));
                      } else {
                        Get.to(
                          MayIKnowYourPurposeScreen(
                            countryCode: AppController.countryCode,
                            mobileNumber: AppController.mobile,
                            meetingFor: nameId,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                AppController.noName != null
                    ? 'Hello ${AppController.noName}! Who are you meeting today?'
                    : 'Great! Who are you meeting today?',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: DropdownButtonFormField<int>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a name';
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // focusColor: Colors.transparent,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color:
                              Colors.black12), // Set the focused border color
                    ),
                    labelText: 'Select Name',
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                  // value: widget.reportingManagerId,
                  items: namesList
                      .map((names) => DropdownMenuItem<int>(
                            value: names.id,
                            child: Text('${names.firstName} ${names.lastName}'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      nameId = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'if your visit is scheduled, Scan your QR Code',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 32,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 31,
                  child: Image.asset(
                    'assets/images/qr.png',
                    height: 32,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
