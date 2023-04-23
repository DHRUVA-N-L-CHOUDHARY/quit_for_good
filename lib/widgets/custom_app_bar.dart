import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quit_for_good/utils/String.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool act;
  const CustomAppBar({super.key, required this.title, this.act = true,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
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
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).w,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              color: Colors.white,
              ),
              child: Image.asset(applogo, height: 40.0,width: 40.0,)),
          ),
          Text(
            title,
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      elevation: 0.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.h);
}
