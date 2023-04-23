import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quit_for_good/firebase_options.dart';
import 'package:quit_for_good/utils/Colors.dart';
import 'package:quit_for_good/views/Login_screen.dart';
import 'package:quit_for_good/views/Navigation_screen.dart';
import 'package:quit_for_good/views/doctors_list_screen.dart';
import 'package:quit_for_good/views/enter_details_screen.dart';
import 'package:quit_for_good/views/request_call_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
       builder: (context, child) =>
     GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: kPrimaryColor),
      debugShowCheckedModeBanner: false,
      home: Authenticate(),
    ),
    designSize: const Size(360, 690),
      minTextAdapt: true,
    );
  }
}

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        print(snapshot.data.toString());
        print("dkslfsjdkjfjkdf");
        return snapshot.data != null
            ? NavigationScreen(tabIndex: 0,)
            : LoginScreen();
      },
    );
  }
}