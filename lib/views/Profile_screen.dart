import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Quit for Good",
        act: false,
      ),
      body: ListView(
        children: [
          profilesection(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              balcont("2398479", "Donation", "420948"),
              balcont("2398479", "Savings","37094"),
            ],
          )
        ],
      ),
    );
  }

  Widget profilesection() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  // ignore: prefer_const_constructors
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName ??
                        "User name",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.0),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Email : ${FirebaseAuth.instance.currentUser?.email}",
                  style: TextStyle(fontSize: 15)),
              const SizedBox(height: 8),
            ],
          ),
          ClipOval(
            child: CircleAvatar(
                radius: 30,
                child: Image.network(
                    FirebaseAuth.instance.currentUser?.photoURL ?? profileimg)),
          )
        ],
      ),
    );
  }

  Widget balcont(String bal, String amttype, String mthbal) {
    return Container(
      height: 100.h,
      width: 160.w,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: Cross,
        children: [
          Text(amttype, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: kContrColor),),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Balance:$bal",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kContrColor),
          ),
          Text(
            "Month's $amttype: $mthbal",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: kContrColor),
          )
        ],
      ),
    );
  }
}
