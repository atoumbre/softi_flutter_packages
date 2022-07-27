import 'dart:async';

import 'package:softi_packages/packages/auth/models/auth_user.dart';
import 'package:softi_packages/packages/core/services/BaseService.dart';

enum AuthMethod { Email, Phone, Google, Apple, FaceBook }

abstract class IAuthService extends IBaseService {
  Future<AuthUser?> get getCurrentUser;
  Stream<AuthUser?> get authUserStream;

  // Anonymous login
  Future<AuthUser?> signInAnonymously();

  // Email and password
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password);
  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);

  // OS Login
  Future<AuthUser?> signInWithGoogle({bool linkToUser = false});
  Future<AuthUser?> signInWithApple({bool linkToUser = false});

  // Social Login
  Future<AuthUser?> signInWithFacebook(dynamic param, {linkToUser = false});

  // Email Link login
  Future<AuthUser?> signInWithEmailAndLink({required String email, required String link});
  Future<bool> isSignInWithEmailLink({required String link});
  Future<void> sendSignInWithEmailLink({required String email});

  // Phone login
  Future<AuthUser?> signInWithPhone(verificationId, smsOTP);
  Future<SendCodeResult> sendSignInWithPhoneCode({
    String? phoneNumber,
    dynamic resendingId,
    bool? autoRetrive,
    int autoRetrievalTimeoutSeconds = 30,
  });

  Future<void> signOut();

  Future<void> unlink(AuthMethod authMethod);

  void refresh();
}

class SendCodeResult {
  final String? phoneNumber;
  final Future<AuthUser>? authResult;
  final Future<SendCodeResult?> Function() resendCode;
  final Future<AuthUser?> Function(String) codeVerification;

  SendCodeResult({
    required this.phoneNumber,
    required this.codeVerification,
    required this.resendCode,
    this.authResult,
  });
}

// class AuthError extends Error {
//   AuthError({this.code, this.message});
//   final String? code;
//   final String? message;
// }
