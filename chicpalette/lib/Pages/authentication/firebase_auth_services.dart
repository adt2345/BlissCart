import 'package:chicpalette/Pages/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../LoginPage.dart';

class FirebaseAuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future <User?> signUpWithEmailandPassword(String email, String password)async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }
  Future <User?> signInWithEmailandPassword(String email, String password)async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }


}
void signOutUser(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  } catch (e) {
    print("Error signing out: $e");
    // Handle sign-out errors if needed
  }
}