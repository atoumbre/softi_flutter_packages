import 'dart:async';

import 'package:softi_packages/packages/external/auth/models/auth_user.dart';
import 'package:softi_packages/packages/core/services/BaseService.dart';

enum AuthMethod { Email, Phone, Google, Apple, FaceBook }

abstract class IAuthService extends IBaseService {
  Future<AuthUser?> get getCurrentUser;
  Stream<AuthUser?> get authUserStream;

  IAppleAuthProvider get appleSignin;
  IGoogleAuthProvider get googleSignin;
  IFacebookAuthProvider get facebookSignin;
  IEmailAndLinkAuthProvider get emailLinkSignin;
  IEmailAndPasswordAuthProvider get emailSignin;
  IPhoneAuthProvider get phoneSignin;

  Future<AuthUser?> signInAnonymously();

  Future<void> signOut();

  Future<void> deleteAccount();

  void refresh();
}

class SendCodeResult {
  final String? phoneNumber;
  final Future<AuthUser>? autoAuthResult;
  final Future<SendCodeResult?> Function() resendCode;
  final Future<AuthUser?> Function(String, bool) codeVerification;

  SendCodeResult({
    required this.phoneNumber,
    required this.codeVerification,
    required this.resendCode,
    this.autoAuthResult,
  });
}

abstract class IAppleAuthProvider extends IBaseService {
  Future<AuthUser?> signIn({bool linkToUser = false});

  //
  Future<AuthUser?> unlink();
  Stream<dynamic> get providerData;
}

abstract class IGoogleAuthProvider extends IBaseService {
  Future<AuthUser?> signIn({bool linkToUser = false});

  //
  Future<AuthUser?> unlink();
  Stream<dynamic> get providerData;
}

abstract class IFacebookAuthProvider extends IBaseService {
  Future<AuthUser?> signIn({bool linkToUser = false});

  //
  Future<AuthUser?> unlink();
  Stream<dynamic> get providerData;
}

abstract class IEmailAndPasswordAuthProvider extends IBaseService {
  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password, {bool linkToUser = false});

  //
  Future<AuthUser?> unlink();
  Stream<dynamic> get providerData;
}

abstract class IEmailAndLinkAuthProvider extends IBaseService {
  Future<AuthUser?> signInWithEmailAndLink({required String email, required String link, required bool linkToUser});
  Future<bool> isSignInWithEmailLink({required String link});
  Future<void> sendSignInWithEmailLink({required String email});

  //
  Future<AuthUser?> unlink();
  Stream<dynamic> get providerData;
}

abstract class IPhoneAuthProvider extends IBaseService {
  Future<AuthUser?> signInWithPhone(dynamic verificationId, String smsOTP, {bool linkToUser = false});
  Future<SendCodeResult> sendPhoneCode({
    required String phoneNumber,
    int autoRetrievalTimeoutSeconds = 30,
    bool autoRetrive = true,
    bool linkToUser = false,
  });

  //
  Future<AuthUser?> unlink();
  Stream<dynamic> get providerData;
}
