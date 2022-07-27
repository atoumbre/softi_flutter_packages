import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:softi_packages/packages/auth/interfaces/i_auth_service.dart';
import 'package:softi_packages/packages/auth/models/auth_user.dart';
import 'package:softi_packages/packages/core/services/BaseService.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/models/settings.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/firebase_auth_provider.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_apple.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_email.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_email_link.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_facebook.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_google.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/providers/firebase_auth_phone.dart';

class FirebaseAuthService extends IAuthService {
  final FirebaseAuth firebaseAuth;
  final FirebaseSettings settings;

  final FirebaseAppleSignin appleSignin;
  final FirebaseGoogleSignin googleSignin;
  final FirebaseAuthFacebookSignIn facebookSignin;
  final FirebaseAuthEmalPassword emailSignin;
  final FirebaseAuthPhone phoneSignin;
  final FirebaseAuthEmailLink emailLinkSignin;

  FirebaseAuthService(this.firebaseAuth, this.settings)
      : appleSignin = FirebaseAppleSignin(
          firebaseAuth,
          appleSignInCallbackUrl: settings.appleSignInCallbackUrl,
          appleSignInClientId: settings.appleSignInClientId,
        ),
        facebookSignin = FirebaseAuthFacebookSignIn(
          firebaseAuth,
          facebookClientId: settings.facebookClientId,
        ),
        emailLinkSignin = FirebaseAuthEmailLink(
          firebaseAuth,
          actionCodeSettings: ActionCodeSettings(
            url: settings.url!,
            //
            androidMinimumVersion: settings.androidMinimumVersion,
            androidInstallApp: settings.androidInstallIfNotAvailable,
            androidPackageName: settings.androidPackageName,
            //
            iOSBundleId: settings.iOSBundleID,
            handleCodeInApp: true,
            // dynamicLinkDomain: null,
          ),
        ),
        googleSignin = FirebaseGoogleSignin(firebaseAuth),
        emailSignin = FirebaseAuthEmalPassword(firebaseAuth),
        phoneSignin = FirebaseAuthPhone(firebaseAuth);

  @override
  Future<AuthUser?> get getCurrentUser => Future.value(FirebaseAuthProvider.authUserFromUser(firebaseAuth.currentUser));

  @override
  Stream<AuthUser?> get authUserStream => firebaseAuth.authStateChanges().map(FirebaseAuthProvider.authUserFromUser);

  @override
  Future<void> init() async {
    // ignore: todo
    // TODO: implement refresh
  }

  @override
  Future<void> dispose() async {
    // ignore: todo
    // TODO: implement refresh
  }

  @override
  void refresh() {
    // ignore: todo
    // TODO: implement refresh
  }

  @override
  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password) {
    return failureCatcher<AuthUser?>(() => emailSignin.createUserWithEmailAndPassword(email, password));
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    return failureCatcher<void>(() => emailSignin.sendPasswordResetEmail(email));
  }

  @override
  Future<void> sendSignInWithEmailLink({required String email}) {
    return failureCatcher<void>(() => emailLinkSignin.sendSignInWithEmailLink(email: email));
  }

  @override
  Future<SendCodeResult> sendSignInWithPhoneCode({
    String? phoneNumber,
    resendingId,
    bool? autoRetrive,
    int autoRetrievalTimeoutSeconds = 30,
  }) {
    return failureCatcher<SendCodeResult>(
      () => phoneSignin.sendSignInWithPhoneCode(
        phoneNumber: phoneNumber,
        resendingId: resendingId,
        autoRetrive: true,
        autoRetrievalTimeoutSeconds: autoRetrievalTimeoutSeconds,
      ),
    );
  }

  @override
  Future<AuthUser?> signInAnonymously() {
    return failureCatcher<AuthUser?>(() async {
      final authResult = await firebaseAuth.signInAnonymously();
      return FirebaseAuthProvider.userFromFirebase(authResult);
    });
  }

  @override
  Future<AuthUser?> signInWithApple({linkToUser = false}) {
    return failureCatcher<AuthUser?>(() => appleSignin.signInWithApple(linkToUser: linkToUser));
  }

  @override
  Future<AuthUser?> signInWithEmailAndLink({required String email, required String link}) {
    return failureCatcher<AuthUser?>(() => emailLinkSignin.signInWithEmailAndLink(email: email, link: link));
  }

  @override
  Future<AuthUser?> signInWithEmailAndPassword(String email, String password) {
    return failureCatcher<AuthUser?>(() => emailSignin.signInWithEmailAndPassword(email, password));
  }

  @override
  Future<AuthUser?> signInWithFacebook(param, {linkToUser = false}) {
    return failureCatcher<AuthUser?>(() => facebookSignin.signInWithFacebook(param, linkToUser: linkToUser));
  }

  @override
  Future<AuthUser?> signInWithGoogle({linkToUser = false}) {
    return failureCatcher<AuthUser?>(() => googleSignin.signInWithGoogle(linkToUser: linkToUser));
    // return googleSignin.signInWithGoogle(linkToUser: linkToUser);
  }

  @override
  Future<AuthUser?> signInWithPhone(verificationId, smsOTP) {
    return failureCatcher<AuthUser?>(() => phoneSignin.signInWithPhone(verificationId, smsOTP));
  }

  @override
  Future<bool> isSignInWithEmailLink({String? link}) {
    return failureCatcher<bool>(() => emailLinkSignin.isSignInWithEmailLink(link!));
  }

  @override
  Future<void> signOut() {
    return failureCatcher<void>(() => firebaseAuth.signOut());
  }

  @override
  ServiceFailure? errorHandler(dynamic error) {
    return null;
  }
}
