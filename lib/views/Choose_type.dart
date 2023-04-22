import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/views/Donate_to_social_communites.dart';

class ChooseTypeScreen extends StatelessWidget {
  const ChooseTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            typecard("Transfer to you savings account", (){
              // Get.to(() => )
            }),
            typecard("Donate to social communites",(){
              Get.to(() => DonateToSocialCommunites());
            })
          ],
        ),
      ),
    );
  }

  Widget typecard(String inptxt, Function press ) {
    return InkWell(
      onTap: press as void Function(),
      child: Card(
        child: SizedBox(
          width: 150.w,
          child: Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: Text(
              inptxt, textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }
}
