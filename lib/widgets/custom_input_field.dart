import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? prewidget;
  final bool emptyValidation;
  final Widget? sufwidget;
  final TextInputType textInputType;
  var validation;
   CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prewidget,
    this.sufwidget,
    this.textInputType = TextInputType.text,
    this.emptyValidation = true,
    this.validation,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    return TextFormField(
      style: const TextStyle(
        fontFamily: "BentonSans",
      ),
      controller: controller,
      keyboardType: textInputType,
      validator: emptyValidation
          ? (value) {
              if (value == null || value.isEmpty) {
                return '$hintText Required';
              }
              return null;
            }
          : validation,
      decoration: InputDecoration(
        prefixIcon: prewidget,
        suffixIcon: sufwidget,
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: "BentonSans",
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: Colors.black,
            width: 20.0,
          ),
        ),
      ),
    );
  }
}
