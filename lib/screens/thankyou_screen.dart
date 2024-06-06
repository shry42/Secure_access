import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/controllers/final_thankyou_form_controller.dart';
import 'package:secure_access/screens/first_tab_screen.dart';
import 'package:secure_access/screens/thankyou_final_screen.dart';
import 'package:secure_access/utils/toast_notify.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen(
      {super.key,
      this.countryCode,
      this.fullName,
      this.email,
      this.purpose,
      this.mobNo,
      this.meetingFor,
      this.toolName,
      this.make,
      this.remark,
      this.quantity,
      this.base64ToolImage,
      this.hasTool,
      this.firebaseKey});

  final String? countryCode,
      fullName,
      email,
      purpose,
      mobNo,
      toolName,
      make,
      remark,
      firebaseKey,
      base64ToolImage;
  final int? meetingFor, quantity, hasTool;

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

final TextEditingController signCont = TextEditingController();

class _ThankyouScreenState extends State<ThankyouScreen> {
  final ThankyouFormSubmissionController thanksFormController =
      ThankyouFormSubmissionController();

  late String currentTime;
  late String currentDate;
  late String selectedCountryCode;

  @override
  void initState() {
    // Get the current date
    DateTime now = DateTime.now();
    currentDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    // Get the current time in 24-hour format
    currentTime =
        "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    // Initialize the selectedCountryCode with the default country code
    selectedCountryCode = '+91'; // You can set it to any default value
    super.initState();
  }

  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  void _handleSaveButtonPressed() async {
    final data =
        await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    // Convert the image to a base64 string
    final base64Image = base64Encode(bytes!.buffer.asUint8List());
    await thanksFormController.ThankyouFinalForm(
        widget.fullName.toString(),
        widget.email,
        widget.countryCode,
        widget.mobNo,
        'company',
        widget.purpose,
        'description',
        currentDate,
        currentTime,
        base64Image,
        widget.toolName,
        widget.make,
        widget.remark,
        widget.base64ToolImage,
        widget.meetingFor!.toInt(),
        widget.hasTool.toString(),
        widget.quantity,
        widget.firebaseKey);

    if (AppController.accessToken == null) {
      AppController.setnoMatched('No');
      Get.offAll(const ThankyouFinalScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                    )),
                const SizedBox(
                  width: 290,
                ),
                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Color.fromARGB(2, 192, 198, 199),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //   ),
                //   onPressed: () {
                //     // Get.to(const FirstVisitScreen());
                //   },
                //   child: const Text(
                //     'Next',
                //     style: TextStyle(color: Colors.black),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
              children: [
                Text(
                  'Thankyou!',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Text(
                  'One last thing before you come in. Please sign this NDA',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Text(
                  '1. I may be given access to confidential information belonging to the Gegagdyne Energy through my relationship with Company or as a result of my access to Compnay\'s premises',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Text(
                  '2. I understand and acknowledge that Compnay\'s trade secrets consist of information and materials that are valuable and not generally known by Compnay\'s competitors, including:',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Text(
                  '(a) Any and all information concerning Compnay\'s current, future or proposed products, including, but not limited to, computer code,drawings, specificatons, notebook entries, technical notes and graphs, computer printouts, technical memoranda and correspondence, product development agreements and related agreements. ',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  '(b) Information and materials relating to Compnay\'s purchasing, accounting and marketing; including, but not limited to, marketing plans, sales data, unpublished promotional material, cost and pricing information and customer lists',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  '(c) Information of the type described above which Company obtained from another party and which Company treats as confidential, whether or not owned or developed by Company.',
                  textAlign: TextAlign.center,
                ),
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                        child: SfSignaturePad(
                            key: signatureGlobalKey,
                            backgroundColor: Colors.white,
                            strokeColor: Colors.black,
                            minimumStrokeWidth: 1.0,
                            maximumStrokeWidth: 4.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)))),
                Row(children: <Widget>[
                  TextButton(
                    child: Text('Save'),
                    onPressed: _handleSaveButtonPressed,
                  ),
                  TextButton(
                    child: Text('Clear'),
                    onPressed: _handleClearButtonPressed,
                  )
                ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
              ],
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center),
        ),
      ),
    );
  }
}
