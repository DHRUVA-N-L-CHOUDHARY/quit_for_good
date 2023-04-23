import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/services/data_base_service.dart';

import '../../../services/db.dart';

class HomePageController extends GetxController {
  RxString userName = "".obs;
  RxString email = "".obs;
  RxBool isLoading = false.obs;
  RxString groupName = "".obs;
  Rx<Stream> groups = const Stream.empty().obs;

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void onInit() {
    gettingUserData();
    super.onInit();
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await Db.getUserEmail().then((value) {
      email.value = value!;
    });
    await Db.getUserName().then((value) {
      userName.value = value!;
    });
    groups.value = DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroup();
  }

  Future singOut() async {
    try {
      await Db.saveUserLoggedInStatus(false);
      await Db.saveUserEmail("");
      await Db.saveUserName("");
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
