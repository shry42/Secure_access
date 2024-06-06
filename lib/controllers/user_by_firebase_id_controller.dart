import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/screens/first_tab_screen.dart';
import 'package:secure_access/screens/login_screen.dart';
import 'package:secure_access/services/api_services.dart';
import 'package:secure_access/utils/toast_notify.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserByFirebaseIdController extends GetxController {
  getNamesList(String firebaseId) async {
    // List<UserByNumberModel> userListObj = [];
    http.Response response = await http.get(
      Uri.parse(
          '${ApiService.baseUrl}/api/visitor/getVisitorByFirebaseId/$firebaseId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${AppController.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      Map<String, dynamic> data = result['data'];
      // final userData = data['data'];
      final visitorId = data['id'];
      final visitorInviteStatus = data['visitorInviteStatus'];
      final fullName = data['fullName'];
      final email = data['email'];
      final mobileNo = data['mobileNo'];
      final countryCode = data['countryCode'];

      AppController.setVisitorId(visitorId);
      AppController.setVisitorInviteStatus(visitorInviteStatus);
      AppController.setnoName(fullName);
      AppController.setEmail(email);
      AppController.setMobile(mobileNo);
      AppController.setCountryCode(countryCode);

      // userListObj = data.map((e) => UserByNumberModel.fromJson(e)).toList();
      AppController.setnoMatched('Yes');

      // return userListObj;
    } else {
      Map<String, dynamic> result = json.decode(response.body);
      // List<dynamic> data = result['data'];
      AppController.setnoMatched('No');
      AppController.setaccessToken(null);
      toast('unauthorized');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
    }
  }
}
