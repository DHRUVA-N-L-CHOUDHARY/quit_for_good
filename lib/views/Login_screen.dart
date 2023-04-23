import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/utils/String.dart';
import 'package:quit_for_good/views/enter_details_screen.dart';
import 'package:quit_for_good/views/homepage/screen/home.dart';
import 'package:quit_for_good/widgets/custom_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  Future<bool> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await _auth.signInWithCredential(credential);

      final User? user = authResult.user;
      return user != null ? true : false;
    } catch (e) {
      // return false;
      throw (e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(
      //   title: "Quit for Good",
      //   act: false,
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Welcome to Quit for Good',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontFamily: "Brugty",
              fontWeight: FontWeight.w400,
            ),
          ),
          Center(child: Image.asset(applogo)),
          const Text(
            'Login to continue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontFamily: "Brugty",
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () async {
              bool isSuccess = await loginWithGoogle();
              if (isSuccess) {
                Get.offAll(EnterDetailsScreen());
              }
            },
            child: Card(
              elevation: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.black)
                ),
                width: 280.w,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.network(
                        "https://static.vecteezy.com/system/resources/previews/009/469/630/original/google-logo-isolated-editorial-icon-free-vector.jpg",
                        height: 60,
                        width: 60,
                      ),
                      Text(
                        "Sign In with google",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                fontFamily: "Brugty",
                            fontWeight: FontWeight.w100),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
