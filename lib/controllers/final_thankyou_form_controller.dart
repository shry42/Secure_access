import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/screens/login_screen.dart';
import 'package:secure_access/screens/thankyou_final_screen.dart';
import 'package:secure_access/services/api_services.dart';
import 'package:secure_access/utils/toast_notify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThankyouFormSubmissionController extends GetxController {
  Future ThankyouFinalForm(
    String fullName,
    email,
    countryCode,
    mobileNo,
    company,
    purpose,
    description,
    visitDate,
    visitTime,
    ndaSignature,
    toolName,
    make,
    remark,
    toolPic,
    int meetingFor,
    hasTool,
    quantity,
    firebaseKey,
  ) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/visitor/createVisitorInvite'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        "fullName": fullName,
        "email": email,
        "countryCode": countryCode,
        "mobileNo": mobileNo,
        "company": company,
        "purpose": purpose,
        "description": description,
        "visitDate": visitDate,
        "visitTime": visitTime,
        "meetingFor": meetingFor,
        "hasTool": hasTool,
        "firebaseKey": firebaseKey,
        "ndaSignature": ndaSignature,
        "toolDetails": {
          "toolName": toolName,
          "make": make,
          "quantity": quantity,
          "remark": remark,
          "toolPic": toolPic,
        }
      }),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];
      String message = result['message'];
      AppController.setnoName('');
      AppController.setEmail('');
      AppController.setMobile('');
      AppController.setCountryCode('');
      AppController.setUserName('');
      AppController.setFirebaseKey(null);
      AppController.setnoMatched('No');
      AppController.setCallUpadteMethod(0);
      AppController.setValidKey(0);
      AppController.setFaceMatched(0);
      Get.offAll(const ThankyouFinalScreen());
      // if (status == true) {
      //   Get.defaultDialog(
      //     title: "Success",
      //     middleText: message,
      //     textConfirm: "OK",
      //     confirmTextColor: Colors.white,
      //     onConfirm: () {
      //       Get.back();
      //     },
      //   );
      // }
    } else if (response.statusCode == 401) {
      AppController.setnoMatched('No');
      AppController.setaccessToken(null);
      toast('unauthorized');
      AppController.setnoMatched('No');
      AppController.setCallUpadteMethod(0);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      Get.offAll(LoginPage());
    } else {
      toast('Failed to send invitation');
    }
  }
}
