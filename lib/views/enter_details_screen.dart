import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/models/enter_details_model.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/views/Navigation_screen.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({super.key});

  @override
  State<EnterDetailsScreen> createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  final GlobalKey<FormState> customerdetailskey = GlobalKey<FormState>();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController profpackcontroller = TextEditingController();
  TextEditingController smkprdycontroller = TextEditingController();
  TextEditingController quitdtcontroller = TextEditingController();
  TextEditingController mvtcontroller = TextEditingController();

  void clear() {
    namecontroller.clear();
    agecontroller.clear();
    profpackcontroller.clear();
    smkprdycontroller.clear();
    quitdtcontroller.clear();
    mvtcontroller.clear();
  }

  @override
  void dispose() {
    super.dispose();
    namecontroller.dispose();
    agecontroller.dispose();
    profpackcontroller.dispose();
    smkprdycontroller.dispose();
    quitdtcontroller.dispose();
    mvtcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0).h,
            child: Form(
              key: customerdetailskey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0).w,
                    child: Text(
                      "hi there.",
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Brugty",
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                  ),
                  texthead("Your name"),
                  cstcont(namecontroller, TextInputType.name, "name", [], 3),
                  texthead("Your age"),
                  cstcont(agecontroller, TextInputType.number, "age",
                      [FilteringTextInputFormatter.digitsOnly], 1),
                  texthead("Price of Packet"),
                  cstcont(
                      profpackcontroller,
                      TextInputType.number,
                      "Enter Price of Packet",
                      [FilteringTextInputFormatter.digitsOnly],
                      1),
                  texthead("How many do you smoke a day?"),
                  cstcont(
                      smkprdycontroller, TextInputType.name, "5 cigar", [], 1),
                  texthead("What is you Quit date?"),
                  cstcont(quitdtcontroller, TextInputType.datetime,
                      "Your quit date", [], 1),
                  texthead("Your motivation to quit"),
                  cstcont(mvtcontroller, TextInputType.name,
                      "I want to better my health", [], 1),
                  button(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget texthead(String head) {
    return Text(
      head,
      style: TextStyle(
          fontFamily: "Brugty",
          fontSize: 17,
          fontWeight: FontWeight.w400,
          color: Colors.black),
    );
  }

  Widget cstcont(
    TextEditingController controller,
    TextInputType textInputType,
    String hintText,
    List<TextInputFormatter>? inputformatter,
    int num,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0, top: 8.0),
      child: TextFormField(
        style: const TextStyle(
          fontFamily: "Brugty",
        ),
        controller: controller,
        keyboardType: textInputType,
        validator: (value) {
          if (value == null || value.length < num) {
            return 'Enter Valid $hintText';
          }
          return null;
        },
        inputFormatters: inputformatter,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: "Brugty",
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.black,
              width: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> addUserInfo(EnterDetailsModel customerDetails) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("detailsmodel")
        .doc(customerDetails.name)
        .set(customerDetails.toJson())
        .then((value) => Get.to(() => NavigationScreen(
              tabIndex: 0,
            )))
        .catchError((error) => print("Failed to send details: $error"));
  }

  Widget button(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: GestureDetector(
        onTap: () {
          if (customerdetailskey.currentState!.validate()) {
            EnterDetailsModel enterDetailsScreen = EnterDetailsModel(
                name: namecontroller.text,
                img: FirebaseAuth.instance.currentUser?.photoURL,
                mvt: mvtcontroller.text,
                age: agecontroller.text,
                priceofpacket: profpackcontroller.text,
                smkprd: smkprdycontroller.text,
                qtdate: quitdtcontroller.text);
                addUserInfo(enterDetailsScreen);
            print("jfsldkfjdslkf");
            // clear();
            // dispose();
          }
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          height: screenHeight / 16,
          width: screenWidth / 1.2,
          decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.white12,
                  spreadRadius: 3,
                  blurRadius: 3,
                ),
              ]),
          child: Center(
            child: Text(
              "Finish",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "Brugty",
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }
}
