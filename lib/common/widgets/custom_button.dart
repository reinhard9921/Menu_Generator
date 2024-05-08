import 'package:flutter/material.dart';
import 'package:menu_generator/constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          left: width * 0.25,
          bottom: height * 0.01,
          right: width * 0.25,
          top: height * 0.01),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: color == null ? GlobalVariables.primaryColor : color,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: GlobalVariables.fontName,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
