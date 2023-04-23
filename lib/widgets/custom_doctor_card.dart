import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/views/request_call_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorCard extends StatelessWidget {
  final String imgPath;
  final String description;
  final String name;
  const DoctorCard(
      {super.key,
      required this.imgPath,
      required this.name,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0).w,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
              onPressed: () async {
                launch('tel://8143957028');
                await FlutterPhoneDirectCaller.callNumber(
                    "+918143957028");
              },
              icon: Icon(
                Icons.phone,
                color: kPrimaryColor,
              )),
            ),
            InkWell(
              onTap: () {
                Get.to(() => RequestCallScreen(img: imgPath));
              },
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      imgPath,
                      height: 40.h,
                      width: 40.w,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black),
                    ),
                    Text(description,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Colors.black)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
