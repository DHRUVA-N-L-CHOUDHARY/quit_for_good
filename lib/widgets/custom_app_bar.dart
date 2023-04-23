import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool act;
  const CustomAppBar({super.key, required this.title, this.act = true,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      leading: act ? IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
      )  : Container(),
      title: Text(
        title.capitalize ?? "Quit For Good",
        style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.w100, fontFamily: "Brugty"),
      ),
      centerTitle: true,
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
