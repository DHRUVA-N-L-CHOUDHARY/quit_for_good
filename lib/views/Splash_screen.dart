import 'package:flutter/material.dart';
import 'package:quit_for_good/utils/String.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: screenheight,
        width: screenWidth,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(splash))),
        child: const Text(
          "QUUIT FOR GOOD",
          style: TextStyle(
              color: Color.fromRGBO(87, 51, 83, 1),
              fontWeight: FontWeight.bold,
              fontSize: 30.0),
        ),
      ),
    );
  }
}
