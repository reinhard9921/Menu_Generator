import 'package:flutter/material.dart';
import 'package:menu_generator/constants/global_variables.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final bool? passwordText;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.passwordText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.05,
          bottom: height * 0.01,
          right: width * 0.05,
          top: height * 0.01),
      child: TextFormField(
        controller: controller,
        obscureText: passwordText!,
        style: TextStyle(
            fontFamily: GlobalVariables.fontName,
            color: GlobalVariables.textTheme),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontFamily: GlobalVariables.fontName,
              color: GlobalVariables.textTheme),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                color: GlobalVariables.textTheme,
              )),
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              borderSide: BorderSide(
                color: GlobalVariables.textTheme,
              )),
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter your $hintText';
          }
          return null;
        },
        maxLines: maxLines,
      ),
    );
  }
}
