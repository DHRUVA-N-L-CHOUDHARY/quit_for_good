import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/views/chating/controller/chat_controller.dart';
import 'package:quit_for_good/views/chating/screen/chat_screen.dart';

class GroupTile extends StatelessWidget {
  final String userName;
  final String groupId;
  final String groupName;

  const GroupTile(
      {Key? key,
      required this.groupName,
      required this.userName,
      required this.groupId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.put(ChatController()).groupName.value = groupName;
        Get.put(ChatController()).groupId.value = groupId;
        Get.put(ChatController()).userName.value = userName;

        Get.to(() => ChatScreen());
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.r,
            backgroundColor: kPrimaryColor,
            child: Text(groupName.substring(0, 1).toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500)),
          ),
          title: Text(
            groupName.toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Join the conversation as $userName",
            style: TextStyle(fontSize: 13.sp),
          ),
        ),
      ),
    );
  }
}
