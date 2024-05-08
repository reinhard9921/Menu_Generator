import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:menu_generator/AddProductDialog.dart';
import 'package:menu_generator/Authentication/LoginScreen.dart';
import 'package:menu_generator/MenuScreen.dart';
import 'package:menu_generator/models/Categories.dart';
import 'package:menu_generator/models/Pricing.dart';
import 'package:menu_generator/models/Product.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core
import 'package:menu_generator/Authentication/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBFivmv1IKa2yu3vyswFl98LFm_CTZN4rM",
        authDomain: "menugenerator-90680.firebaseapp.com",
        projectId: "menugenerator-90680",
        storageBucket: "menugenerator-90680.appspot.com",
        messagingSenderId: "263363857833",
        appId: "1:263363857833:web:cffb95b4d9f86fc96e88b8",
        measurementId: "G-EK0B882ENF"),
  );
  runApp(MenuApp());
}

class MenuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Menu App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
