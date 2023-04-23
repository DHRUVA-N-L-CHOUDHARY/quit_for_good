// import 'package:chat_app_firbase/services/data_base_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxString adminName = "".obs;
  RxString groupId = "".obs;
  RxString groupName = "".obs;
  RxString userName = "".obs;
  TextEditingController messageController = TextEditingController();
  Rx<Stream<QuerySnapshot>> chats = const Stream<QuerySnapshot>.empty().obs;
  @override
  void onInit() {
    getChatAdmin();
    super.onInit();
  }

  getChatAdmin() {
    // FirebaseFirestore.instance.collection("").getChats(groupId.value).then((val) {
      // chats.value = val;
    // });
    // DataBaseService().getGroupAdmin(groupId.value).then((value) {
      // adminName.value = value;
    // });
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": userName.value,
        "time": DateTime.now().microsecondsSinceEpoch,
      };
      // DataBaseService().sendMessage(groupId.value, chatMessageMap);
      messageController.clear();
    }
  }
}