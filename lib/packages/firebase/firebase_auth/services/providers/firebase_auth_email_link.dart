import 'package:firebase_auth/firebase_auth.dart';
import 'package:softi_packages/packages/external/auth/models/auth_user.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/firebase_auth_provider.dart';
import 'package:softi_packages/packages/external/auth/interfaces/i_auth_service.dart';

class FirebaseAuthEmailLink extends IEmailAndLinkAuthProvider with FirebaseAuthProvider {
  String get providerId => 'password';

  final ActionCodeSettings? actionCodeSettings;
  final FirebaseAuth firebaseAuth;

  FirebaseAuthEmailLink(this.firebaseAuth, {this.actionCodeSettings});

  Future<AuthCredential> _getCredentialForEmailAndLink(String email, String link) async {
    return EmailAuthProvider.credentialWithLink(email: email, emailLink: link);
  }

  Future<AuthUser?> signInWithEmailAndLink({required String email, required String link, required bool linkToUser}) {
    return failureCatcher<AuthUser?>(() async => signInWithCredential(await _getCredentialForEmailAndLink(email, link), linkToUser: linkToUser));
  }

  Future<bool> isSignInWithEmailLink({required String link}) {
    return failureCatcher<bool>(() => Future.value(firebaseAuth.isSignInWithEmailLink(link)));
  }

  Future<void> sendSignInWithEmailLink({required String email}) {
    return failureCatcher<void>(() => firebaseAuth.sendSignInLinkToEmail(email: email, actionCodeSettings: actionCodeSettings!));
  }
}
