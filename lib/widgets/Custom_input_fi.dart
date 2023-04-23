// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quit_for_good/utils/Colors.dart';

class CustomInputField1 extends StatelessWidget {
  final String? errorText;
  final String? labelText;
  final TextEditingController? controller;
  final double height;
  final String iconData;
  final bool prefix;
  final bool suffix;
  final bool isSecure;
  final bool isDigitsOnly;
  final bool emptyValidation;
  final TextInputType textInput;
  final String iconsuffix;
  final String? hintText;
  final String? initalval;
  final int inptline;
  final bool typeof;
  Widget? suffixWidget;
  final Iterable<String>? hintlist;
  // ignore: prefer_typing_uninitialized_variables
  var validation;

  CustomInputField1({
    Key? key,
    this.errorText,
    this.isSecure = false,
    this.isDigitsOnly = false,
    this.suffixWidget,
    this.labelText,
    this.controller,
    this.height = 60,
    this.initalval,
    this.validation,
    this.textInput = TextInputType.text,
    this.emptyValidation = true,
    this.iconData = "",
    this.iconsuffix = "",
    this.prefix = true,
    this.suffix = false,
    this.inptline = 1,
    this.typeof = true,
    this.hintText,
    this.hintlist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorStyle = const TextStyle(
      fontSize: 14,
    );

    return LayoutBuilder(builder: (context, constraints) {
      final textPainter = TextPainter()
        ..text = TextSpan(text: errorText, style: errorStyle)
        ..textDirection = TextDirection.ltr
        ..layout(maxWidth: constraints.maxWidth);

      final heightErrorMessage = textPainter.size.height + 8;
      if (typeof == true) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Stack(
            children: [
              Container(
                height: height,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(5, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: kContrColor,
                    borderRadius: BorderRadius.circular(10)),
                height:
                    errorText != null ? height + heightErrorMessage : height,
                child: TextFormField(
                  maxLines: inptline,
                  keyboardType: textInput,
                  inputFormatters: isDigitsOnly
                      ? [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            try {
                              final text = newValue.text;
                              if (text.isNotEmpty) double.parse(text);
                              return newValue;
                            } catch (e) {
                              e.toString();
                            }
                            return oldValue;
                          }),
                        ]
                      : null,
                  obscureText: isSecure,
                  decoration: InputDecoration(
                      prefixIcon: prefix == true
                          ? Image.asset(
                              iconData,
                              scale: 1.1,
                            )
                          : null,
                      suffixIcon: suffix == true ? suffixWidget : null,
                      fillColor: kContrColor,
                      filled: true,
                      errorStyle: errorStyle,
                      errorText: errorText,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          borderSide: BorderSide.none),
                      hintText: labelText,
                      labelStyle:
                          const TextStyle(fontSize: 18, color: Colors.grey)),
                  validator: emptyValidation
                      ? (value) {
                          if (value == null || value.isEmpty) {
                            return '$labelText Required';
                          }
                          return null;
                        }
                      : validation,
                  controller: controller,
                ),
              ),
            ],
          ),
        );
      } else {
        return TextFormField(
          style: TextStyle(
            color: kContrColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          // onSaved: (newValue) {
          //                = newValue!;
          //             },
          validator: emptyValidation
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return '$labelText Required';
                  }
                  return null;
                }
              : validation,
          maxLines: inptline,
          autofillHints: hintlist,
          keyboardType: textInput,
          initialValue: initalval,
          inputFormatters: isDigitsOnly
              ? [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    try {
                      final text = newValue.text;
                      if (text.isNotEmpty) double.parse(text);
                      return newValue;
                    } catch (e) {
                      e.toString();
                    }
                    return oldValue;
                  }),
                ]
              : null,
          obscureText: isSecure,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(
                  0xff2B638D,
                ),
              ),
            ),
            errorStyle: errorStyle,
            errorText: errorText,
            labelText: labelText,
            labelStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xff0ABABB),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(
                  0xff2B638D,
                ),
              ),
            ),
          ),
          controller: controller,
        );
      }
    });
  }
}
