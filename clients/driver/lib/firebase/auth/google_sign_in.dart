import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController extends ChangeNotifier {
  final _googleSignIn = GoogleSignIn();

  User? _user;
  User? get user => _user;
  bool get isAuthenticated => _user != null;

  GoogleSignInController(): super() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<UserCredential> signIn() async {
    final googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
