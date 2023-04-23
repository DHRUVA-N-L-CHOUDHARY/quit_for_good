import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/views/chating/controller/chat_controller.dart';
import 'package:quit_for_good/widgets/message_tile.dart';

class ChatScreen extends GetView<ChatController> {
  static const String routeName = "/chatScreen";

  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.onInit();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(controller.groupName.value),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(children: [
        chatMessages(),
        Container(
          alignment: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[700],
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: controller.messageController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: "Send message...",
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 16.sp),
                        border: InputBorder.none),
                  )),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () {
                      controller.sendMessage();
                    },
                    child: Container(
                      height: 50.h,
                      width: 50.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  )
                ],
              )),
        ),
      ]),
    );
  }

  chatMessages() {
    return Obx(() {
      return StreamBuilder(
          stream: controller.chats.value,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              log("if");
              log(snapshot.data.docs.toString());
              return Container(
                height: 440.h,
                child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MessageTile(
                          message: snapshot.data.docs[index]["message"],
                          sendByMe: controller.userName.value ==
                              snapshot.data.docs[index]["sender"],
                          sender: snapshot.data.docs[index]["sender"]);
                    }),
              );
            } else {
              return Container();
            }
          });
    });
  }
}
