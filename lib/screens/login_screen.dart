import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/controllers/login_controller.dart';
import 'package:secure_access/custom_painter/custom_painter_login.dart';
import 'package:secure_access/screens/first_tab_screen.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController lc = Get.put(loginController());

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();
  TextEditingController empIdResetController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _formReset = GlobalKey();

  bool showDialog = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                right: 40,
                top: 290,
                width: 80,
                height: 150,
                child: FadeInUp(
                  from: 120,
                  duration: const Duration(seconds: 1),
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/playstore.png'),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 400,
                      child: CustomPaint(
                        painter: RPSCustomPainter(),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 30,
                              width: 80,
                              height: 200,
                              child: FadeInUp(
                                duration: const Duration(seconds: 1),
                                child: Container(
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              'assets/images/light-1.png'))),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 140,
                              width: 80,
                              height: 150,
                              child: FadeInUp(
                                duration: const Duration(milliseconds: 1200),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/light-2.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 40,
                              top: 40,
                              width: 80,
                              height: 150,
                              child: FadeInUp(
                                  duration: const Duration(milliseconds: 1300),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/clock.png'))),
                                  )),
                            ),
                            Positioned(
                              child: FadeInUp(
                                  duration: const Duration(milliseconds: 1600),
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 50),
                                    child: const Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            FadeInUp(
                                duration: const Duration(milliseconds: 1800),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              188, 190, 230, 1)),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: emailController,
                                          onChanged: (value) {
                                            // AppController.setemailId(emailController.text);
                                            lc.email.value =
                                                emailController.text;
                                          },
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Employee Id",
                                              hintStyle: TextStyle(
                                                  color: Colors.grey[700])),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                value == "") {
                                              return 'Please enter a valid Employee Id';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(height: 12),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1800),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color.fromRGBO(
                                              188, 190, 230, 1)),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: passController,
                                          onChanged: (value) {
                                            lc.password.value =
                                                passController.text;
                                          },
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[700]),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty ||
                                                value == "") {
                                              return 'Please enter a password';
                                            }
                                            return null;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            FadeInUp(
                                duration: const Duration(milliseconds: 1900),
                                child: Shimmer(
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await lc.loginUser();
                                        if (AppController.message != null) {
                                          Get.defaultDialog(
                                            title: "Unauthorized!",
                                            middleText:
                                                "${AppController.message}",
                                            textConfirm: "OK",
                                            confirmTextColor: Colors.white,
                                            onConfirm: () async {
                                              AppController.setmessage(null);
                                              Get.back(); // Close the dialog
                                            },
                                          );
                                          return;
                                        } else
                                        // if (lc.role == 'frontDesk' )
                                        {
                                          await Get.offAll(
                                              const FirstTabScreen(),
                                              transition:
                                                  Transition.rightToLeft);
                                        }
                                        //  else if (lc.role == 'superAdmin' &&
                                        //     lc.isManager == 1) {
                                        //   await Get.offAll(
                                        //       const BottomNavSuperAdmin(),
                                        //       transition:
                                        //           Transition.rightToLeft);
                                        // } else if (lc.role == 'user' &&
                                        //     lc.isManager == 1) {
                                        //   await Get.offAll(
                                        //       const BottomNavUsers(),
                                        //       transition:
                                        //           Transition.rightToLeft);
                                        // } else if (lc.role == 'user') {
                                        //   await Get.offAll(
                                        //       const MyTimesheetScreen(
                                        //           title: 'My TimeSheet'),
                                        //       transition:
                                        //           Transition.rightToLeft);
                                        // }
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient:
                                              const LinearGradient(colors: [
                                            Color.fromARGB(255, 117, 198, 25),
                                            Color.fromARGB(255, 165, 240, 79),
                                          ])),
                                      child: const Center(
                                        child: Text(
                                          "Login",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                )),

                            //
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () {
                              // setState(() {
                              //   if (showDialog == false) {
                              //     showDialog = true;
                              //   } else {
                              //     showDialog = false;
                              //   }
                              // });
                              // Get.defaultDialog(
                              //   barrierDismissible: false,
                              //   backgroundColor:
                              //       const Color.fromARGB(255, 195, 215, 196),
                              //   title: 'Enter Employee Id',
                              //   content: ForgotPassWithMailScreen(),
                              // );
                            },
                            child: const Text(
                              'Forgot Password ?',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          //
                          //   if (showDialog == true)
                          //     Container(
                          //       padding: const EdgeInsets.all(5),
                          //       decoration: BoxDecoration(
                          //           color: Colors.white,
                          //           borderRadius: BorderRadius.circular(10),
                          //           border: Border.all(
                          //               color: const Color.fromRGBO(
                          //                   188, 190, 230, 1)),
                          //           boxShadow: const [
                          //             BoxShadow(
                          //                 color:
                          //                     Color.fromRGBO(143, 148, 251, .2),
                          //                 blurRadius: 20.0,
                          //                 offset: Offset(0, 10))
                          //           ]),
                          //       child: Column(
                          //         children: <Widget>[
                          //           Container(
                          //             padding: const EdgeInsets.all(2.0),
                          //             child: TextFormField(
                          //               controller: empIdResetController,
                          //               onChanged: (value) {
                          //                 empIdResetController.text = value;
                          //               },
                          //               decoration: InputDecoration(
                          //                   border: InputBorder.none,
                          //                   hintText: "Employee Id",
                          //                   hintStyle: TextStyle(
                          //                       color: Colors.grey[700])),
                          //             ),
                          //           )
                          //         ],
                          //       ),
                          //     ),

                          //   //
                          //   const SizedBox(height: 10),
                          //   if (showDialog == true)
                          //     GestureDetector(
                          //       onTap: () {
                          //         if (empIdResetController.text != '') {
                          //           Get.to(ResestPassScreenByOtpScreen(
                          //             empId: empIdResetController.text,
                          //           ));
                          //         } else {
                          //           toast('Please enter a valid Employee Id');
                          //         }
                          //       },
                          //       child: Container(
                          //         height: 50,
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(10),
                          //             gradient: const LinearGradient(colors: [
                          //               Color.fromARGB(255, 117, 198, 25),
                          //               Color.fromARGB(255, 165, 240, 79),
                          //             ])),
                          //         child: const Center(
                          //           child: Text(
                          //             "Submit",
                          //             style: TextStyle(
                          //                 color: Colors.white,
                          //                 fontWeight: FontWeight.bold),
                          //           ),
                          //         ),
                          //       ),
                          //     ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
