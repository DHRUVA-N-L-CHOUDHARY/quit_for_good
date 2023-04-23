import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/models/call_request_model.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/views/Navigation_screen.dart';
import 'package:quit_for_good/views/Video_Call_screen.dart';
import 'package:quit_for_good/widgets/Custom_container.dart';
import 'package:quit_for_good/widgets/Custom_input_fi.dart';
import 'package:quit_for_good/widgets/custom_input_field.dart';

class RequestCallScreen extends StatefulWidget {
  final Function(DateTime)? onChanged;
  final DateTime? initialDate;
  final DateTime? finalDate;
  final String img;
  const RequestCallScreen(
      {super.key, this.onChanged, this.initialDate, this.finalDate, required this.img});

  @override
  State<RequestCallScreen> createState() => _RequestCallScreenState();
}

class _RequestCallScreenState extends State<RequestCallScreen> {
  @override
  onInit() {
    getUserData();
  }

  void getUserData() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('')
        .where("email", isEqualTo: FirebaseAuth.instance.currentUser?.email)
        .get();
    CallRequest _user = CallRequest.fromJson(querySnapshot.docs[0].data());
    print("ssss");
  }

  TextEditingController descriptionController = TextEditingController();
  late String dateTime;
  DateTime selectedDate = DateTime.now();
  final callrequestformkey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: widget.initialDate ?? DateTime.now(),
        lastDate: widget.finalDate ?? DateTime(2030));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text =
            formatDate(selectedDate, [dd, '/', mm, '/', yyyy]);
      });
    }
    return selectedDate;
  }

  Future<dynamic> addUserInfo(CallRequest callRequest) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('videoCallRequests')
        .add(callRequest.toJson())
        .then((value) => Get.to(() => VideoCallScreen()))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  void initState() {
    _dateController.text = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dateTime = formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]);
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Form(
          key: callrequestformkey,
          child: ListView(
            children: [
              ListTile(
                visualDensity: const VisualDensity(horizontal: -4, vertical: 0),
                leading: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Text(
                            "Request a Call",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 26,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration:  BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: CircleAvatar(backgroundImage: NetworkImage(widget.img),),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "You can request a call 3 time in a week",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  )
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Describe a topic",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: CustomInputField1(
                  height: 150,
                  hintText: "Write in 20 words",
                  emptyValidation: true,
                  prefix: false,
                  suffix: false,
                  inptline: 10,
                  controller: descriptionController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Date of Request",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8).h,
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () async {
                          DateTime date = await _selectDate(context);
                          widget.onChanged!(date);
                        },
                        child: CustomContainer(
                          padding: 5,
                          borderColor: Colors.white,
                          borderRadius: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(right:8.0),
                                  child: Image.asset(calender, scale: 1.1, color: Colors.black,),
                                ),
                              ),
                              enabled: false,
                              controller: _dateController,
                              onSaved: (String? val) {},
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    CallRequest callRequest = CallRequest(
                        date: _dateController.text,
                        description: descriptionController.text,
                        requestedby:  FirebaseAuth.instance.currentUser!.uid,
                        requestto: "",
                        status: "",
                        type: "",
                        cnt:""
                        );
                    addUserInfo(callRequest);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Container(
                      height: 60,
                      width: 360.w,
                      decoration: BoxDecoration(
                          color:kPrimaryColor,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white12,
                              spreadRadius: 3,
                              blurRadius: 3,
                            ),
                          ]),
                      child: Center(
                        child: Text(
                          "Update Request",
                          style: TextStyle(
                              color: kContrColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
