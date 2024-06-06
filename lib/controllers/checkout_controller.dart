import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/screens/first_tab_screen.dart';
import 'package:secure_access/services/api_services.dart';

class CheckoutController extends GetxController {
  Future checkout(int visitorId) async {
    http.Response response = await http.put(
      Uri.parse('${ApiService.baseUrl}/api/visitor/checkoutVisitor'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({"visitorId": visitorId}),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      bool? status = result['status'];
      String message = result['message'];

      AppController.setVisitorInviteStatus(null);
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
            Get.offAll(const FirstTabScreen());
            // Get.back(); // Close the dialog
          },
        );
      }
    }
  }
}
