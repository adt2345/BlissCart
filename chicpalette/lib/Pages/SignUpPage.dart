import 'package:chicpalette/Pages/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginPage.dart';
import 'authentication/auth_services.dart';

void main() {
  runApp(ChicPalette());
}

class ChicPalette extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _FullNameController = TextEditingController();
  TextEditingController _AddressController = TextEditingController();
  TextEditingController _MobileNumberController = TextEditingController();
  TextEditingController _EmailIdController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                Image.asset(
                  'lib/images/loginbg2.png',
                  alignment: Alignment.center,
                ),
                SizedBox(height: 10),
                buildTextField(_FullNameController, "Full Name"),
                buildTextField(_AddressController, "Address"),
                buildTextField(_MobileNumberController, "Mobile Number"),
                buildTextField(_EmailIdController, "Email"),
                buildTextField(_PasswordController, "Password", isPassword: true),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    signUpWithEmailAndPassword(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple[50]),
                  child: Text("Sign Up", style: TextStyle(fontStyle:FontStyle.normal, color: Colors.black, fontSize: 20)),
                ),
                SizedBox(height: 10),
                // Add the button to navigate to the login page
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text("Already have an account? Login here"),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.purple[50],
    );
  }

  Widget buildTextField(TextEditingController controller, String hintText, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey.shade100,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void signUpWithEmailAndPassword(BuildContext context) async {
    try {
      print('Attempting to sign up...');

      UserCredential authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _EmailIdController.text.trim(),
        password: _PasswordController.text.trim(),
      );

      // Get the UID of the newly created user
      String uid = authResult.user!.uid;

      // Store additional user details in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'fullName': _FullNameController.text.trim(),
        'address': _AddressController.text.trim(),
        'mobileNumber': _MobileNumberController.text.trim(),
        'email': _EmailIdController.text.trim(),
        // Do not store the password in Firestore
        // Add other fields as needed
      });

      // Navigate to the dashboard or perform other actions
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign up successful!'),
          duration: Duration(seconds: 2),
        ),
      );

      print('Sign up successful!');
    } on FirebaseAuthException catch (e) {
      print('FirebaseAuthException: ${e.message}');

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error: $e');

      // Show generic error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An unexpected error occurred.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
