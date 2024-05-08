import 'package:flutter/material.dart';

String uri = 'http://plantcybackend-env.eba-fkc3qf9b.us-east-1.elasticbeanstalk.com/';
//String uri = 'http://localhost:3000';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(217, 66, 202, 16),
      Color.fromARGB(243, 58, 237, 76),
    ],
    stops: [0.5, 1.0],
  );
  static const fontName = "Oxygen";
  static const headerColor = Color.fromARGB(235, 216, 16, 16);
  static const primaryColor = Color.fromRGBO(204, 0, 0, 1);
  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const secondaryColorCalendar = Color.fromARGB(255, 51, 244, 17);
  static const primaryColorCalendar = Color.fromARGB(255, 33, 161, 13);
  static const backgroundColor = Color.fromARGB(255, 57, 57, 57);
  static const navbarBackgroundColor = Color.fromARGB(255, 46, 46, 46);
  static const textTheme = Color.fromARGB(255, 0, 0, 0);
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Color.fromARGB(255, 240, 13, 13);
  static const unselectedNavBarColor = Colors.black87;
  // STATIC IMAGES

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];
}
