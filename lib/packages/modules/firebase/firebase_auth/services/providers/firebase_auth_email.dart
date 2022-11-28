import 'package:firebase_auth/firebase_auth.dart';
import 'package:softi_packages/packages/services/auth/models/auth_user.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_auth/services/firebase_auth_provider.dart';
import 'package:softi_packages/packages/services/auth/interfaces/i_auth_service.dart';

class FirebaseAuthEmalPassword extends IEmailAndPasswordAuthProvider with FirebaseAuthProvider {
  String get providerId => 'password';

  final FirebaseAuth firebaseAuth;

  FirebaseAuthEmalPassword(this.firebaseAuth);

  Future<AuthCredential> getCredentialForEmailPassword(String email, String password) async {
    return EmailAuthProvider.credential(email: email, password: password);
  }

  Future<AuthUser?> signInWithEmailAndPassword(String email, String password, {bool linkToUser = false}) {
    return failureCatcher<AuthUser?>(
      () async => signInWithCredential(await getCredentialForEmailPassword(email, password), linkToUser: linkToUser),
    );
  }

  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password) async {
    return failureCatcher<AuthUser?>(() async {
      final authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return FirebaseAuthProvider.userFromFirebase(authResult);
    });
  }

  Future<void> sendPasswordResetEmail(String email) {
    return failureCatcher<void>(() => firebaseAuth.sendPasswordResetEmail(email: email));
  }
}
