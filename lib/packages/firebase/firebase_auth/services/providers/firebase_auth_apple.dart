import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:softi_packages/packages/auth/models/auth_user.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/firebase_auth_provider.dart';

class FirebaseAppleSignin extends FirebaseAuthProvider {
  final String? appleSignInCallbackUrl;
  final String? appleSignInClientId;

  FirebaseAppleSignin(
    FirebaseAuth firebaseAuth, {
    this.appleSignInCallbackUrl,
    this.appleSignInClientId,
  }) : super(firebaseAuth);

  Future<AuthCredential> getCredentialForApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: appleSignInClientId!,
        redirectUri: Uri.parse(
          //. 'https://us-central1-resto-ci.cloudfunctions.net/appleSignInCallback',
          appleSignInCallbackUrl!,
        ),
      ),
    );

    final oAuthProvider = OAuthProvider('apple.com');

    return oAuthProvider.credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );
  }

  Future<AuthUser?> signInWithApple({linkToUser = false}) async => signInWithCredential(await getCredentialForApple(), linkToUser: linkToUser);
}
