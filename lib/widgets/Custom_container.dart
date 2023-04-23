import 'package:flutter/material.dart';
import 'package:quit_for_good/utils/Colors.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final double borderRadius;
  final double radius;
  final double padding;
  const CustomContainer({Key? key, required this.child, this.borderColor = const Color(0xFF06283D), this.borderRadius = 0, this.radius = 15, this.padding = 15}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: kContrColor,
                border: Border.all(
                  style: BorderStyle.solid,
                    color: borderColor,
                    width: borderRadius
                )
            ),
            child: Padding(
              padding: EdgeInsets.only(top:padding),
              child: child,
            ),
      ),
    );
  }
}
