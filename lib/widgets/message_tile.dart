import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final String sender;
  final bool sendByMe;

  const MessageTile(
      {Key? key,
      required this.message,
      required this.sendByMe,
      required this.sender})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 4.h,
        bottom: 4.h,
        left: sendByMe ? 0 : 24,
        right: sendByMe ? 24 : 0,
      ),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30.w)
            : EdgeInsets.only(right: 30.w),
        padding:
            EdgeInsets.only(top: 17.h, bottom: 17.h, left: 20.w, right: 20.w),
        decoration: BoxDecoration(
            color: sendByMe ? Theme.of(context).primaryColor : Colors.grey[700],
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                    bottomLeft: Radius.circular(20.r))
                : BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            sender.toString().toUpperCase(),
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.sp, color: Colors.white),
          )
        ]),
      ),
    );
  }
}
