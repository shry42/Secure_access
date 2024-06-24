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

class UpdateThankuouOfUniqueVisitor extends GetxController {
  Future upadteFinalUniqueKey(
    String? ndaSignature,
    toolName,
    make,
    remark,
    firebaseKey,
    toolPic,
    dynamic hasTool,
    quantity,
  ) async {
    http.Response response = await http.put(
      Uri.parse('${ApiService.baseUrl}/api/visitor/updateInvite'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({
        // "fullName": fullName,
        // "email": email,
        // "countryCode": countryCode,
        // "mobileNo": mobileNo,
        // "company": company,
        // "purpose": purpose,
        // "description": description,
        // "visitDate": visitDate,
        // "visitTime": visitTime,
        // "meetingFor": meetingFor,
        "visitId": AppController.visitorId,
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
      AppController.setFirebaseKey('');
      AppController.setnoName('');
      AppController.setEmail('');
      AppController.setCallUpadteMethod(0);
      AppController.setValidKey(0);
      AppController.setFaceMatched(0);
      AppController.setnoMatched('No');
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      Get.offAll(LoginPage());
    } else {
      toast('Failed to send invitation');
    }
  }
}
