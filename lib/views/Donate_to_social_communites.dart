import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/Custom_button.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/views/Payment_option.dart';
import 'package:quit_for_good/widgets/components/custom_app_bar.dart';

class DonateToSocialCommunites extends StatelessWidget {
  const DonateToSocialCommunites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Quit for Good",),
      body: ListView(
        children: [
          Image.asset(donatengo),
          Center(child: Text("Donate to NGO or Social Communities", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)),
          SizedBox(
            height: 20.h,
          ),
          dontaecard("NGO 1", "ABCD", 100, "9353478558",""
          ),

        ],
      ),
    );
  }

  Widget dontaecard(String nameoftitle, String description, double ordervalue, String phonenumb,String desc ) {
    return Container(
      width: 360.w,
      child: ListTile(
        title: Text(nameoftitle),
        trailing: Custombutton(
          customwidth: 100.w,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.normal,
          ),
          text: "Pay",
          inputcolor: kPrimaryColor,
          press: (){
            Get.to(() => PaymentOption(desc: desc, nameoftitle: nameoftitle, orderval: ordervalue, phonenumb: phonenumb,));
          }
        ),
      ),
    );
  }
}
