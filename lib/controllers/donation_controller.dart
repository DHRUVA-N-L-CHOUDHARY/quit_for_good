import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/models/Donation_payment_model.dart';
import 'package:quit_for_good/views/Navigation_screen.dart';

class DonationPaymentController extends GetxController
{
   Future<dynamic> addUserInfo(DonationPaymentModel customerDetails) {
    print("djflksd");
    return FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("donation").doc(customerDetails.trsid)
        .set(customerDetails.toJson())
        .then((value) => Get.offAll(() => NavigationScreen(tabIndex: 0,)))
        .catchError((error) => print("Failed to send details: $error"));
  }
}