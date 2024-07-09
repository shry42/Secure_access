import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/services/api_services.dart';
import 'package:secure_access/utils/toast_notify.dart';

class UniqueKeyController extends GetxController {
  getUniqueVistorByUniqueKey(dynamic uniqueKey, mobileNo) async {
    http.Response response = await http.post(
      Uri.parse('${ApiService.baseUrl}/api/visitor/getVisitorData'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
      body: json.encode({"uniqueKey": uniqueKey, "mobileNo": mobileNo}),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      Map<String, dynamic> data = result['data'];

      final uniqueVistorId = data['id'];
      final fullName = data['fullName'];
      final email = data['email'];
      final mobileNo = data['mobileNo'];
      final countryCode = data['countryCode'];
      final firebaseKey = data['firebaseKey'];

      AppController.setnoName(fullName);
      AppController.setEmail(email);
      AppController.setMobile(mobileNo);
      AppController.setCountryCode(countryCode);
      AppController.setFirebaseKey(firebaseKey);
      AppController.setVisitorId(uniqueVistorId);
      AppController.setCallUpadteMethod(1);
      AppController.setValidKey(1);
      // toast('success');
    } else {
      Map<String, dynamic> result = json.decode(response.body);
      String title = result['title'];
      String message = result['message'];
      AppController.setmessage(message);

      if (title == 'Validation Failed') {
        Get.defaultDialog(
          barrierDismissible: false,
          title: "Error",
          middleText: message,
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            // Get.offAll(const FirstTabScreen());
            Get.back();
          },
        );
      }
      // AppController.setValidKey(0);
      // toast('Invalid key \n Enter valid key');
      // return;
    }
  }
}
