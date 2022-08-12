import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:softi_packages/packages/external/auth/interfaces/i_auth_service.dart';
import 'package:softi_packages/packages/external/auth/models/auth_user.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/firebase_auth_provider.dart';

class FirebaseAuthFacebookSignIn extends IFacebookAuthProvider with FirebaseAuthProvider {
  String get providerId => 'facebook.com';

  final String? facebookClientId;
  final FirebaseAuth firebaseAuth;

  FirebaseAuthFacebookSignIn(this.firebaseAuth, {this.facebookClientId});

  Future<AuthCredential> getFacebookAuthCredential() async {
    final LoginResult result = await FacebookAuth.instance.login();
    // by default we request the email and the public profile
    // or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      return FacebookAuthProvider.credential(accessToken.token);
    } else {
      print(result.status);
      print(result.message);

      throw PlatformException(code: result.status.toString(), message: result.message);
    }
  }

  Future<AuthUser?> signIn({linkToUser = false}) async {
    return signInWithCredential(await getFacebookAuthCredential(), linkToUser: linkToUser);
  }
}
