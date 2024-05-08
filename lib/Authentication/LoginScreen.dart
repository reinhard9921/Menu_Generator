import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore
import 'package:menu_generator/Authentication/RegisterScreen.dart';
import 'package:menu_generator/MenuScreen.dart';
import 'package:menu_generator/common/widgets/custom_button.dart';
import 'package:menu_generator/common/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize Firebase Auth
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Initialize Firestore
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // Function to handle login
  void _loginUser() async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Get user data from Firestore
      DocumentSnapshot userSnapshot = await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      if (userSnapshot.exists) {
        // User data found
        Map<String, dynamic> userData = userSnapshot.data()!
            as Map<String, dynamic>; // Explicitly cast userData
        // Use userData as needed, for example:
        print("User email: ${userData['email']}");
        print("User subscribed: ${userData['subscribed']}");
        print("User company name: ${userData['companyName']}");
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MenuScreen(userData: userData)),
        );
      } else {
        // User data not found
        print(
            "User Data not found please log a support ticket on our website www.freefallstudios.co.za");
      }

      // Navigate to MenuScreen if login is successful
    } catch (e) {
      // Handle errors such as invalid credentials, etc.
      print("Error logging in: $e");
      // You can also show a snackbar or dialog to inform the user about the error.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomTextField(controller: email, hintText: "Email"),
          CustomTextField(controller: password, hintText: "Password"),
          CustomButton(text: "Login", onTap: _loginUser),
          CustomButton(
            text: "Register",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
