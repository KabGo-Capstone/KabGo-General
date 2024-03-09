import 'package:driver/firebase/auth/google_sign_in.dart';
import 'package:driver/firebase/auth/phone_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final googleAuthProvider = ChangeNotifierProvider((ref) => GoogleSignInController());
final phoneAuthProvider = ChangeNotifierProvider((ref) => PhoneSignInController());