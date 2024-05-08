import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Cloud Firestore
import 'package:menu_generator/Authentication/LoginScreen.dart';
import 'package:menu_generator/common/widgets/custom_button.dart';
import 'package:menu_generator/common/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize Firebase Auth
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Initialize Firestore
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController companyName = TextEditingController();

  // Function to handle user registration
  void _registerUser() async {
    if (password.text != password2.text) {
      // Check if passwords match
      print("Passwords do not match");
      // You can also show a snackbar or dialog to inform the user.
      return;
    }

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Registration successful
      print("Registration successful");

      // Save user info in Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': email.text,
        'subscribed': false,
        'companyName': companyName.text
        // Add more user info here if needed
      });

      // You can navigate to another screen or perform other actions here.
    } catch (e) {
      // Handle errors such as weak password, email already in use, etc.
      print("Error registering user: $e");
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
          CustomTextField(controller: password2, hintText: "Re-type Password"),
          CustomTextField(
              controller: companyName, hintText: "Company Name(Optional)"),
          CustomButton(text: "Register", onTap: _registerUser),
          CustomButton(
            text: "Login",
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ),
          ),
        ],
      ),
    );
  }
}
