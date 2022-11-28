import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:softi_packages/packages/core/services/BaseService.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_auth/models/settings.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_auth/services/firebase_auth_provider.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_apple.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_email.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_email_link.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_google.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_auth/services/providers/firebase_auth_phone.dart';
import 'package:softi_packages/packages/services/auth/interfaces/i_auth_service.dart';
import 'package:softi_packages/packages/services/auth/models/auth_user.dart';

class FirebaseAuthService extends IAuthService {
  final FirebaseAuth firebaseAuth;
  final FirebaseSettings settings;

  final FirebaseAppleSignin appleSignin;
  final FirebaseGoogleSignin googleSignin;
  // final FirebaseAuthFacebookSignIn facebookSignin;
  final FirebaseAuthEmalPassword emailSignin;
  final FirebaseAuthPhone phoneSignin;
  final FirebaseAuthEmailLink emailLinkSignin;

  FirebaseAuthService(this.firebaseAuth, this.settings)
      : appleSignin = FirebaseAppleSignin(
          firebaseAuth,
          appleSignInCallbackUrl: settings.appleSignInCallbackUrl,
          appleSignInClientId: settings.appleSignInClientId,
        ),
        // facebookSignin = FirebaseAuthFacebookSignIn(firebaseAuth),
        emailLinkSignin = FirebaseAuthEmailLink(
          firebaseAuth,
          actionCodeSettings: settings.actionCodeSettings,
        ),
        googleSignin = FirebaseGoogleSignin(firebaseAuth),
        emailSignin = FirebaseAuthEmalPassword(firebaseAuth),
        phoneSignin = FirebaseAuthPhone(firebaseAuth);

  @override
  Future<AuthUser?> get getCurrentUser => Future.value(FirebaseAuthProvider.authUserFromUser(firebaseAuth.currentUser));

  @override
  Stream<AuthUser?> get authUserStream => firebaseAuth.authStateChanges().asyncMap(FirebaseAuthProvider.authUserFromUser);

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
  Future<void> refresh() async {
    firebaseAuth.currentUser?.reload();
    await firebaseAuth.currentUser?.getIdToken(true);
  }

  @override
  Future<AuthUser?> signInAnonymously() {
    return failureCatcher<AuthUser?>(() async {
      final authResult = await firebaseAuth.signInAnonymously();
      return FirebaseAuthProvider.userFromFirebase(authResult);
    });
  }

  @override
  Future<void> signOut() {
    return failureCatcher<void>(() => firebaseAuth.signOut());
  }

  @override
  ServiceFailure? errorHandler(dynamic error) {
    return null;
  }

  @override
  Future<void> deleteAccount() async {
    await firebaseAuth.currentUser?.delete();
  }
}

// EmailAuthProviderID: password
// PhoneAuthProviderID: phone
// GoogleAuthProviderID: google.com
// FacebookAuthProviderID: facebook.com
// TwitterAuthProviderID: twitter.com
// GitHubAuthProviderID: github.com
// AppleAuthProviderID: apple.com
// YahooAuthProviderID: yahoo.com
// MicrosoftAuthProviderID: hotmail.com
