import 'package:dio/dio.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/screens/register_screen/otp_screen.dart';
import 'package:driver/screens/register_screen/register_screen.dart';
import 'package:driver/screens/register_screen/select_service.dart';
import 'package:driver/services/dio_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController extends ChangeNotifier {
  static final _googleSignIn = GoogleSignIn();

  User? _user;
  String? _redirectPath;

  User? get user => _user;
  String? get redirectPath => _redirectPath;

  bool get isAuthenticated => _user != null;

  GoogleSignInController() : super() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<UserCredential?> signIn() async {
    try {
      final googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<dynamic> googleValidate(String currentPath) async {
    var data = null;

    try {
      DioClient client = DioClient();
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final res = await client.request('/google',
          options: Options(
            method: 'POST',
            headers: {'Authorization': 'Bearer $token'},
          ),
          data: {'googleId': _user!.uid});

      if (res.statusCode == 200) {
        switch (res.data['step']) {
          case 'SERVICE':
            _redirectPath = SelectService.path;
            break;
          case 'INFO':
            _redirectPath = InfoRegister.path;
            break;
          case 'REGISTER':
            _redirectPath = RegisterScreen.path;
            break;
          case 'OTP':
            _redirectPath = OTPScreen.path;
            break;
          default:
            _redirectPath = LoginScreen.path;
            break;
        }
      }
      data = res.data['data'];
    } catch (_) {
      _redirectPath = LoginScreen.path;
    }

    return {
      'redirect': _redirectPath,
      'user': data
    };
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
