import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/models/group_details_model.dart';
import 'package:quit_for_good/views/Navigation_screen.dart';

class GroupInfController extends GetxController {
  Future<dynamic> addUserInfo(GroupDetailsModel customerDetails) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('groups')
        .add(customerDetails.toJson())
        .then((value) => Get.offAll(() => NavigationScreen(
              tabIndex: 1,
            )))
        .catchError((error) => print("Failed to send details: $error"));
  }
}
