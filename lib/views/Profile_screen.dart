import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/widgets/custom_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final dataMap = <String, double>{
    "immunity and lung function": 75,
  };

  final colorList = <Color>[
    Color.fromARGB(255, 210, 192, 234)
  ];

  final Datamap = <String, double>{
    "reduced risk of heart": 80,
  };

  final datamap = <String, double>{
    "gum texture": 90,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: "Quit for Good",
      //   act: false,
      // ),
      body: ListView(
        children: [
          profilesection(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0).h,
            child: Text(
              "My Progress",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w100,
                letterSpacing: 0.0,
                color: Color.fromARGB(173, 0, 0, 0),
                fontFamily: "Brugty",
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              balcont("₹ 23", "Donated", "42"),
              balcont("₹ 23", "Saved", "37"),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              balcont("23", "Life Regained", "42"),
              balcont("23", "Cigarettes", "37"),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0).h,
            child: Text(
              "My Health",
              style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w100,
                  letterSpacing: 0.0,
                  color: Color.fromARGB(172, 0, 0, 0),
                  fontFamily: "Brugty"),
              textAlign: TextAlign.left,
            ),
          ),
          chart(dataMap, "Immunity and Lung Function"),
          chart(Datamap, "Reduced risk of heart"),
          chart(datamap, "Gum texture")
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
                    "Hi, ${FirebaseAuth.instance.currentUser?.displayName ?? "User name"}"
                            .capitalize ??
                        "",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Color.fromRGBO(0, 0, 0, 0.699),
                        fontWeight: FontWeight.w100,
                        fontFamily: "Brugty",
                        letterSpacing: 0.0),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 8),
            ],
          ),
          // ClipOval(
          //   child: CircleAvatar(
          //       radius: 30,
          //       child: Image.network(
          //           FirebaseAuth.instance.currentUser?.photoURL ?? profileimg)),
          // )
        ],
      ),
    );
  }

  Widget balcont(String bal, String amttype, String mthbal) {
    return Container(
      height: 55.h,
      width: 160.w,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  color: kContrColor,
                ),
                Text(
                  amttype,
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: "Brugty",
                      fontWeight: FontWeight.w100,
                      color: kContrColor),
                ),
              ],
            ),
            Center(
              child: Text(
                "$bal",
                style: TextStyle(
                    fontSize: 17,
                    fontFamily: "Brugty",
                    fontWeight: FontWeight.w100,
                    color: kContrColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chart(Map<String, double> datamap, String txt) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            PieChart(
              chartLegendSpacing: 10.0.w,
              legendOptions: LegendOptions(showLegends: false),
              dataMap: datamap,
              chartRadius: 80.w,
              chartType: ChartType.ring,
              baseChartColor: Color.fromARGB(255, 245, 245, 250),
              colorList: colorList,
              totalValue: 100,
            ),
            Container(width: 100.w, child: Text(txt, style: TextStyle(fontFamily: "Brugty",
                    fontWeight: FontWeight.w100,
                    color: Color.fromARGB(177, 0, 0, 0)),))
          ],
        ),
      ),
    );
  }
}
