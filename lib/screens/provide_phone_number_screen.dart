import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/controllers/user_by_number_controller.dart';
import 'package:secure_access/screens/may_i_know_purpose_screen.dart';
import 'package:secure_access/screens/whom_meeting_today_screen.dart';

class ProvidePhoneNumberScreen extends StatefulWidget {
  const ProvidePhoneNumberScreen({super.key});

  @override
  State<ProvidePhoneNumberScreen> createState() =>
      _ProvidePhoneNumberScreenState();
}

class _ProvidePhoneNumberScreenState extends State<ProvidePhoneNumberScreen> {
  late String currentTime;
  late String currentDate;
  late String selectedCountryCode;

  final TextEditingController _phoneController = TextEditingController();

  final UserByNumberController ubnc = UserByNumberController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Get the current date
    DateTime now = DateTime.now();
    currentDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    // Get the current time in 24-hour format
    currentTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    // Initialize the selectedCountryCode with the default country code
    selectedCountryCode = '+91'; // You can set it to any default value
  }

  @override
  Widget build(BuildContext context) {
    // print(currentDate);
    // print(currentTime);
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
                  onPressed: () async {
                    // Get.to(const FirstVisitScreen());
                    if (_formKey.currentState!.validate()) {
                      await ubnc.getNamesList(int.parse(_phoneController.text));
                      if (AppController.noMatched == 'No') {
                        Get.to(MayIKnowYourPurposeScreen(
                          countryCode: selectedCountryCode,
                          mobileNumber: _phoneController.text,
                        ));
                      } else {
                        Get.to(const WhomMeetingTodayScreen());
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
              const Text(
                'Please provide your phone number',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Container(
                    width: 330,
                    height: 65,
                    child: IntlPhoneField(
                      validator: (Value) {
                        if (Value == null) {
                          return 'Please enter Mobile Number';
                        }
                      },
                      controller: _phoneController,
                      flagsButtonPadding: const EdgeInsets.all(8),
                      dropdownIconPosition: IconPosition.trailing,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        // Update the selectedCountryCode when the country code changes
                        selectedCountryCode = phone.countryCode!;
                      },
                    ),
                  )
                ],
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