import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:softi_packages/packages/auth/interfaces/i_auth_service.dart';
import 'package:softi_packages/packages/auth/models/auth_user.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/firebase_auth_provider.dart';

class FirebaseAuthPhone extends IPhoneAuthProvider with FirebaseAuthProvider {
  String get providerId => 'phone';

  final FirebaseAuth firebaseAuth;

  FirebaseAuthPhone(this.firebaseAuth);

  Future<AuthCredential> _getCredentialForPhone(String verificationId, String smsCode) async {
    return PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
  }

  Future<SendCodeResult> _sendSignInWithPhoneCodeWeb(String phoneNumber) async {
    var confirmation = await firebaseAuth.signInWithPhoneNumber(phoneNumber);

    return SendCodeResult(
      phoneNumber: phoneNumber,
      codeVerification: ((code, linkToUser) async => FirebaseAuthProvider.userFromFirebase((await confirmation.confirm(code)))!),
      resendCode: () => _sendSignInWithPhoneCodeWeb(phoneNumber),
    );
  }

  Future<SendCodeResult> _sendSignInWithPhoneCodeNative({
    required String phoneNumber,
    bool autoRetrive = true,
    int autoRetrievalTimeoutSeconds = 30,
    bool linkToUser = false,

    ///
    dynamic resendingId,
  }) async {
    var _sendCodeCompleter = Completer<SendCodeResult>();

    var autoRetriveCompleter = Completer<AuthUser>();

    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      forceResendingToken: resendingId,
      codeSent: (verificationId, [resendingId]) {
        var result = SendCodeResult(
          ///
          phoneNumber: phoneNumber,

          ///
          codeVerification: (String code, bool linkToUser) async {
            var _result = await signInWithPhone(verificationId, code, linkToUser: linkToUser);
            autoRetriveCompleter.complete(_result);
            return _result!;
          },

          ///
          resendCode: () => _sendSignInWithPhoneCodeNative(
            phoneNumber: phoneNumber,
            resendingId: resendingId,
            autoRetrive: autoRetrive,
            autoRetrievalTimeoutSeconds: autoRetrievalTimeoutSeconds,
          ),

          ///
          autoAuthResult: autoRetriveCompleter.future,
        );

        _sendCodeCompleter.complete(result);
      },

      verificationFailed: (authException) {
        _sendCodeCompleter.completeError(authException);
        return;
      },

      //? Auto retrieving flow

      timeout: Duration(seconds: autoRetrive ? autoRetrievalTimeoutSeconds : 0),

      verificationCompleted: (AuthCredential authCredential) async {
        var _user = await signInWithCredential(authCredential, linkToUser: linkToUser);
        autoRetriveCompleter.complete(_user);
      },

      codeAutoRetrievalTimeout: (String verificationId) {
        // Dismiss autoretrieve timeout
        return;
      },
    );

    return _sendCodeCompleter.future;
  }

  Future<AuthUser?> signInWithPhone(dynamic verificationId, String smsOTP, {bool linkToUser = false}) {
    return failureCatcher<AuthUser?>(() async => signInWithCredential(await _getCredentialForPhone(verificationId, smsOTP), linkToUser: linkToUser));
  }

  Future<SendCodeResult> sendPhoneCode({
    required String phoneNumber,
    int autoRetrievalTimeoutSeconds = 30,
    bool autoRetrive = true,
    bool linkToUser = false,
  }) {
    return failureCatcher<SendCodeResult>(() {
      if (kIsWeb) {
        return _sendSignInWithPhoneCodeWeb(phoneNumber);
      } else {
        var test = _sendSignInWithPhoneCodeNative(
          phoneNumber: phoneNumber,
          autoRetrive: autoRetrive,
          autoRetrievalTimeoutSeconds: autoRetrievalTimeoutSeconds,
        );
        return test;
      }
    });
  }
}
