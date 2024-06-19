import 'package:chicpalette/Pages/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

signInWithGoogle(context)async{

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  _googleSignIn.signOut();
  try{
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    if(googleSignInAccount != null){
      final GoogleSignInAuthentication googleSignInAuthentication = await
      googleSignInAccount.authentication;


      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,

      );

      var login = await _firebaseAuth.signInWithCredential(credential);
      print("Firebase Sign-In Result: ${login.toString()}");
      if(login.user != null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    }

  }
  catch (e) {
    print("Error during Google Sign-In: $e");
  }

}

createUserWithEmailAndPassword(String email, String password) async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
signInWithEmailAndPassword(String email, String password)async{
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}