
import 'package:flutter/material.dart';

import 'config/Colors.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    Key? key,
    this.text,
    this.margins,
    this.press,
    this.customwidth = double.infinity,
    this.customheight = 50,
    this.inputcolor = Colors.green,
    this.inputrad = 5,
    required this.textStyle,
  }) : super(key: key);
  final String? text;
  final double? margins;
  final double inputrad;
  final Function? press;
  final TextStyle textStyle;
  final Color? inputcolor;
  final double? customwidth;
  final double? customheight;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(margins ?? 0),
        padding: EdgeInsets.all(margins ?? 0),
        child: SizedBox(
          width: customwidth,
          height: customheight,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(inputrad)),
              foregroundColor: Colors.white,
              backgroundColor: inputcolor,
            ),
            onPressed: press as void Function()?,
            child: Text(text!, style: textStyle),
          ),
        ));
  }
}
