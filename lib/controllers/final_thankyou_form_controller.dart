import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/screens/login_screen.dart';
import 'package:secure_access/services/api_services.dart';

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

      if (status == true) {
        Get.defaultDialog(
          title: "Success",
          middleText: message,
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back();
          },
        );
      }
    } else if (response.statusCode != 200) {
      Map<String, dynamic> result = json.decode(response.body);
      // bool? status = result['status'];
      String title = result['title'];
      String message = result['message'];

      if (title == 'Validation Failed') {
        Get.defaultDialog(
          title: "Error",
          middleText: message,
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // Close the dialog
          },
        );
      } else if (title == 'Unauthorized') {
        Get.defaultDialog(
          title: "Error",
          middleText: "$message \nplease re login",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAll(LoginPage());
            // Get.back(); // Close the dialog
          },
        );
      }
    }
  }
}
