import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/views/Donation/donate_to_social_communites.dart';
import 'package:quit_for_good/views/Transfer_amount_savings_screen.dart';

class ChooseTypeScreen extends StatelessWidget {
  const ChooseTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: "Quit for Good",
      //   act: false,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Quit smoking today, start living tomorrow!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromARGB(131, 0, 0, 0),
                  fontWeight: FontWeight.w100,
                  fontSize: 20,
                  fontFamily: "Brugty",
                  ),
            ),
            Image.asset(lungssmk, width: 320.w,),
            Column(
              children: [
                typecard("Transfer to you savings account", () {
                  Get.to(() => TransferAmountSavingsScreen(
                        desc: '',
                        nameoftitle: '',
                        orderval: 10,
                        phonenumb: '',
                      ));
                }),
                typecard("Donate to social communites", () {
                  Get.to(() => DonateToSocialCommunites());
                })
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget typecard(String inptxt, Function press) {
    return InkWell(
      onTap: press as void Function(),
      child: Padding(
        padding: const EdgeInsets.all(10.0).w,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: kPrimaryColor),
          width: 280.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: Text(
              inptxt,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: kContrColor,
                  fontSize: 20,
                  fontFamily: "Brugty",
                  fontWeight: FontWeight.w100),
            ),
          ),
        ),
      ),
    );
  }
}
