import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneSignInController extends ChangeNotifier {
  ConfirmationResult? confirmation;

  User? _user;
  User? get user => _user;
  bool get isAuthenticated => _user != null;

  PhoneSignInController() : super() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user?.phoneNumber != null) {
        _user = user;
        notifyListeners();
      }
    });
  }

  Future<ConfirmationResult?> signIn(String phonenumber) async {
    confirmation = await FirebaseAuth.instance.signInWithPhoneNumber(phonenumber);
    return confirmation;
  }

  Future<UserCredential?> verifyOTP(String otp) async {
    return await confirmation?.confirm(otp);
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
