import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:softi_packages/packages/auth/models/auth_user.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/firebase_auth_provider.dart';
import 'package:softi_packages/packages/auth/interfaces/i_auth_service.dart';

class FirebaseGoogleSignin extends IGoogleAuthProvider with FirebaseAuthProvider {
  String get providerId => 'google.com';

  final FirebaseAuth firebaseAuth;
  FirebaseGoogleSignin(
    this.firebaseAuth,

    //
    //   {
    //   this.appleSignInCallbackUrl,
    //   this.appleSignInClientId,
    // }
    //
  );

  Future<AuthCredential> getCredentialForGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.accessToken != null || googleAuth.idToken != null) {
        return GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
      } else {
        throw PlatformException(code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN', message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  Future<AuthUser?> signIn({linkToUser = false}) async {
    return failureCatcher<AuthUser?>(() async => signInWithCredential(await getCredentialForGoogle(), linkToUser: linkToUser));
  }
}
