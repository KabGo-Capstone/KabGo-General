import 'package:dio/dio.dart';
import 'package:driver/screens/home_dashboard/home_dashboard.dart';
import 'package:driver/screens/home_screen/index.dart';
import 'package:driver/screens/login_screen.dart';
import 'package:driver/screens/register_screen/info_register.dart';
import 'package:driver/screens/register_screen/register_screen.dart';
import 'package:driver/screens/register_screen/select_service.dart';
import 'package:driver/screens/splash_screen.dart';
import 'package:driver/services/dio_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneSignInController extends ChangeNotifier {
  ConfirmationResult? confirmation;

  User? _user;
  String? _redirectPath;
  bool _isChecking = true;

  User? get user => _user;
  String? get redirectPath => _redirectPath;
  bool get isChecking => _isChecking;

  var _verficationId = '';
  bool get isAuthenticated => _user != null;

  PhoneSignInController() : super() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null &&
          user.phoneNumber != null &&
          user.phoneNumber!.isNotEmpty) {
        print('OK');
        _user = user;
      }
    });
  }

  Future<void> signIn(String phonenumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: '+84${phonenumber.replaceFirst('0', '')}',
      verificationCompleted: (credential) async {
        // await FirebaseAuth.instance.signInWithCredential(credential);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verficationId = verificationId;
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeAutoRetrievalTimeout: (String verificationId) {
        _verficationId = verificationId;
      },
    );
  }

  Future<UserCredential?> verifyOTP(String otp) async {
    return await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: _verficationId, smsCode: otp));
  }

  Future<dynamic> phoneValidate(String currentPath) async {
    var data = null;

    try {
      DioClient client = DioClient();
      final token = await FirebaseAuth.instance.currentUser!.getIdToken();

      final res = await client.request('/phone',
          options: Options(
            method: 'POST',
            headers: {'Authorization': 'Bearer $token'},
          ),
          data: {'phone': _user!.phoneNumber});

      if (res.statusCode == 200) {
        switch (res.data['step']) {
          case 'SERVICE':
            _redirectPath = SelectService.path;
            break;
          case 'INFO':
            _redirectPath = InfoRegister.path;
            break;
          case 'REGISTER':
            signOut();
            _redirectPath = LoginScreen.path;
            break;
          case 'HOME':
            _redirectPath = HomeDashboard.path;
            break;
          default:
            signOut();
            _redirectPath = LoginScreen.path;
            break;
        }
      }

      data = res.data['data'];
    } catch (_) {
        signOut();
      _redirectPath = LoginScreen.path;
    }

    return {'redirect': _redirectPath, 'user': data};
  }

  void clearRedirect() {
    _redirectPath = null;
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
