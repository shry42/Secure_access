import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:secure_access/controllers/get_all_visitors_controller.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({
    super.key,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GetAllVisitorsController gavc = GetAllVisitorsController();
  final _formKey = GlobalKey<FormState>();

  List<dynamic> visitorsList = [];

  int? nameId;

  late String currentDate;

  void getListNames(String date) async {
    visitorsList = await gavc.getAllVistorsList(date);
    setState(() {});
  }

  @override
  void initState() {
    DateTime now = DateTime.now();
    currentDate =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    getListNames(currentDate);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                      )),
                  // const SizedBox(
                  //   width: 220,
                  // ),
                  // Spacer(),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Please selct name for checkout',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 25),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: DropdownButtonFormField<int>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a name';
                    }
                  },
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // focusColor: Colors.transparent,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color:
                              Colors.black12), // Set the focused border color
                    ),
                    labelText: 'Select Name',
                    labelStyle: const TextStyle(color: Colors.black),
                  ),
                  // value: widget.reportingManagerId,
                  items: visitorsList
                      .map((names) => DropdownMenuItem<int>(
                            value: names.id,
                            child: Text('${names.fullName}'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      nameId = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
