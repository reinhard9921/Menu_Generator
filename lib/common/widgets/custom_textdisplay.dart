import 'package:flutter/material.dart';
import 'package:menu_generator/constants/global_variables.dart';

class CustomTextDisplay extends StatelessWidget {
  final String text;
  final String? heading;
  final int maxLines;
  const CustomTextDisplay({
    Key? key,
    required this.text,
    this.heading,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    if (heading == null) {
      return Padding(
        padding: EdgeInsets.only(
            left: width * 0.1,
            bottom: height * 0.01,
            right: width * 0.1,
            top: height * 0.01),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: GlobalVariables.fontName, ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            left: width * 0.1,
            bottom: height * 0.01,
            right: width * 0.1,
            top: height * 0.01),
        child: Column(
          children: [
            Text(
              heading!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: GlobalVariables.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  ),
            ),
            const SizedBox(height: 2),
            Text(text, textAlign: TextAlign.center, style: TextStyle(
                  fontFamily: GlobalVariables.fontName,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  ),),
          ],
        ),
      );
    }
  }
}
