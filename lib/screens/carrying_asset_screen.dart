import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:secure_access/screens/thankyou_screen.dart';
import 'package:secure_access/utils/toast_notify.dart';

class CarryingAssetsScreen extends StatefulWidget {
  const CarryingAssetsScreen(
      {super.key,
      this.countryCode,
      this.fullName,
      this.email,
      this.purpose,
      this.mobNo,
      this.meetingFor});

  final String? countryCode, fullName, email, purpose, mobNo;
  final int? meetingFor;

  @override
  State<CarryingAssetsScreen> createState() => _CarryingAssetsScreenState();
}

class _CarryingAssetsScreenState extends State<CarryingAssetsScreen> {
  final TextEditingController toolNameController = TextEditingController();
  final TextEditingController makeController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isYes = false;

  late String currentTime;
  late String currentDate;
  late String selectedCountryCode;

  final String? toolName = '';
  final String? make = '';
  final String? quantity = '';
  final String? remark = '';
  int? hasTool = 0;

  late XFile? selectedImage;
  bool displayImage = false;
  String? base64ImageTool;
  @override
  void initState() {
    super.initState();
    // // Get the current date
    // DateTime now = DateTime.now();
    // currentDate =
    //     "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    // // Get the current time in 24-hour format
    // currentTime =
    //     "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";

    // // Initialize the selectedCountryCode with the default country code
    // selectedCountryCode = '+91'; // You can set it to any default value
  }

  @override
  Widget build(BuildContext context) {
    // print(currentDate);
    // print(currentTime);
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
                    backgroundColor: const Color.fromARGB(2, 192, 198, 199),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    if (isYes == true) {
                      // if (displayImage == false) {
                      //   toast('please take photo');
                      // }
                      // if (_formKey.currentState!.validate()) {
                      Get.to(
                        ThankyouScreen(
                          countryCode: widget.countryCode,
                          fullName: widget.fullName,
                          email: widget.email,
                          mobNo: widget.mobNo,
                          purpose: widget.purpose,
                          meetingFor: widget.meetingFor,
                          hasTool: hasTool,
                          toolName: toolNameController.text,
                          make: makeController.text,
                          remark: remarkController.text,
                          quantity: int.parse(quantityController.text),
                          base64ToolImage: base64ImageTool,
                        ),
                      );
                      // }
                    } else {
                      toast('please fill all fields');
                    }
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
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
              const Text(
                'Are you carrying anything like a laptop/tablet etc?',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              // const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          hasTool = 1;
                          isYes = true;
                        });
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(width: 50),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          hasTool = 0;
                        });
                        Get.to(
                          ThankyouScreen(
                            countryCode: widget.countryCode,
                            fullName: widget.fullName,
                            email: widget.email,
                            mobNo: widget.mobNo,
                            purpose: widget.purpose,
                            meetingFor: widget.meetingFor,
                            hasTool: hasTool,
                            // toolName: toolNameController.text,
                            // make: makeController.text,
                            // remark: remarkController.text,
                            // quantity: int.parse(quantityController.text),
                            // base64ToolImage: base64ImageTool,
                          ),
                        );
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              if (isYes == true)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: TextFormField(
                          // controller: emailController,
                          controller: toolNameController,
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
                            labelText: '    Tool name',
                            // hintText: 'username',
                          ),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.deny(
                          //       RegExp(r'\s')), // no spaces allowed
                          // ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter tool name";
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: TextFormField(
                          // controller: emailController,
                          controller: makeController,
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
                            labelText: '    Make',
                            // hintText: 'username',
                          ),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.deny(
                          //       RegExp(r'\s')), // no spaces allowed
                          // ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter make name";
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: TextFormField(
                          keyboardType: TextInputType.number,

                          // controller: emailController,
                          controller: quantityController,
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
                            labelText: '    Quantity',
                            // hintText: 'username',
                          ),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.deny(
                          //       RegExp(r'\s')), // no spaces allowed
                          // ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter quantity";
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: TextFormField(
                          // controller: emailController,
                          controller: remarkController,
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
                            labelText: '    Remark',
                            // hintText: 'username',
                          ),
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.deny(
                          //       RegExp(r'\s')), // no spaces allowed
                          // ],
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return "Please enter a name";
                          //   } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          //     return "Name can only contain alphabets and spaces";
                          //   }
                          //   return null;
                          // },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 4),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () async {
                            final PermissionStatus permission =
                                await Permission.camera.status;

                            if (permission.isGranted) {
                              final ImagePicker _picker = ImagePicker();
                              selectedImage = (await _picker.pickImage(
                                  source: ImageSource.camera))!;

                              if (selectedImage != null) {
                                // Convert the selected image to a base64 string
                                List<int> imageBytes =
                                    File(selectedImage!.path).readAsBytesSync();
                                base64ImageTool = base64Encode(imageBytes);

                                // Handle the selected image here
                                displayImage = true;
                                setState(() {});
                              }
                            } else {
                              final PermissionStatus newPermission =
                                  await Permission.camera.request();

                              if (newPermission.isGranted) {
                                final ImagePicker _picker = ImagePicker();
                                selectedImage = (await _picker.pickImage(
                                    source: ImageSource.camera))!;

                                if (selectedImage != null) {
                                  // Handle the selected image here

                                  setState(() {});
                                }
                              } else if (newPermission.isPermanentlyDenied) {
                                // Handle the case where the user has permanently denied permission
                              }
                            }
                          },
                          child: const Text(
                            'Take photo',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      if (displayImage == true)
                        Container(
                          height: 200,
                          width: 200,
                          child: Image.file(File(selectedImage!.path)),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
