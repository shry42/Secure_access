import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:secure_access/authenticate_face/authenticate_face_view.dart';
import 'package:secure_access/common/utils/custom_snackbar.dart';
import 'package:secure_access/common/utils/extensions/size_extension.dart';
import 'package:secure_access/common/utils/screen_size_util.dart';
import 'package:secure_access/common/views/custom_button.dart';
import 'package:secure_access/constants/theme.dart';
import 'package:secure_access/register_face/enter_password_view.dart';
import 'package:secure_access/register_face/register_face_view.dart';
import 'package:secure_access/screens/first_tab_screen.dart';
import 'package:secure_access/screens/login_screen.dart';
import 'package:secure_access/screens/thankyou_final_screen.dart';
import 'package:secure_access/firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Secure_access',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: LoginPage(),   // for tab working
      home: const Home(),
      // home: const ThankyouFinalScreen(),
      // home: const FirstTabScreen(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeUtilContexts(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              scaffoldTopGradientClr,
              scaffoldBottomGradientClr,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Face Authentication",
              style: TextStyle(
                color: textColor,
                fontSize: 0.033.sh,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 0.07.sh),
            CustomButton(
              text: "Register User",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>

                        // EnterPasswordView(),
                        const RegisterFaceView(),
                  ),
                );
              },
            ),
            SizedBox(height: 0.025.sh),
            CustomButton(
              text: "Authenticate User",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AuthenticateFaceView(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void initializeUtilContexts(BuildContext context) {
    ScreenSizeUtil.context = context;
    CustomSnackBar.context = context;
  }
}
