import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:softi_packages/packages/auth/models/auth_user.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/firebase_auth_provider.dart';
import 'package:softi_packages/packages/auth/interfaces/i_auth_service.dart';

class FirebaseAuthFacebookSignIn extends IFacebookAuthProvider with FirebaseAuthProvider {
  String get providerId => 'facebook.com';

  final String? facebookClientId;
  final FirebaseAuth firebaseAuth;

  FirebaseAuthFacebookSignIn(this.firebaseAuth, {this.facebookClientId});

  Future<AuthCredential> getFacebookAuthCredential(Future<String> Function(Widget)? navigator) async {
    // String result = await Navigator.push(
    //   context,
    //   //! CustomWebView for Facebook login
    //   MaterialPageRoute(
    //     builder: (context) => getFacebookLoginWebView(context, settings.facebookClientId),
    //     maintainState: true,
    //   ),
    // );

    var result = '';
    //await navigator(facebookLoginWebView(facebookClientId));

    // if (result != null) {
    return FacebookAuthProvider.credential(result);
    // } else {
    //   throw PlatformException(code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    // }
  }

  Future<AuthUser?> signInWithFacebook(dynamic context, {linkToUser = false}) async {
    return signInWithCredential(await getFacebookAuthCredential(context), linkToUser: linkToUser);
  }
}
