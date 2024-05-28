import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:secure_access/controllers/app_controller.dart';
import 'package:secure_access/screens/whom_meeting_today_screen.dart';

class FirstVisitScreen extends StatefulWidget {
  const FirstVisitScreen(
      {super.key, this.countryCode, this.mobNo, this.purpose});

  final String? countryCode;
  final String? mobNo;
  final String? purpose;

  @override
  State<FirstVisitScreen> createState() => _FirstVisitScreenState();
}

class _FirstVisitScreenState extends State<FirstVisitScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
                    backgroundColor: const Color.fromARGB(255, 150, 199, 24),
                  ),
                  onPressed: () {
                    // Get.to(const MayIKnowYourPurposeScreen());
                    if (_formKey.currentState!.validate()) {
                      Get.to(
                        WhomMeetingTodayScreen(
                          countryCode: widget.countryCode,
                          mobNo: widget.mobNo,
                          purpose: widget.purpose,
                          fullName: fullNameController.text,
                          email: emailController.text,
                        ),
                      );
                    }
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Hello! I guess you\'re visiting us for the first time .\n May I know your details?',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 221, 216, 216),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      width: 280,
                      height: 40,
                      child: Center(
                        child: Text(
                          '${widget.mobNo}                                                  ',
                          // textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    const CircleAvatar(
                      // child: Image.asset(''),
                      radius: 20,
                      backgroundColor: Color.fromARGB(255, 224, 219, 219),
                    )
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: TextFormField(
                    // controller: emailController,
                    controller: fullNameController,
                    // initialValue: widget.firstName,
                    onChanged: (value) {
                      // AppController.setemailId(emailController.text);
                      // c.userName.value = emailController.text;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: '    Full Name',
                      // hintText: 'username',
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                          RegExp(r'\s')), // no spaces allowed
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter a name";
                      } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return "Name can only contain alphabets and spaces";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                  child: TextFormField(
                    // controller: emailController,
                    controller: emailController,
                    // initialValue: widget.firstName,
                    onChanged: (value) {
                      // AppController.setemailId(emailController.text);
                      // c.userName.value = emailController.text;
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: '    Email',
                      // hintText: 'username',
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                          RegExp(r'\s')), // no spaces allowed
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter an email address";
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                          .hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
