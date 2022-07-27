import 'package:firebase_auth/firebase_auth.dart';
import 'package:softi_packages/packages/auth/models/auth_user.dart';
import 'package:softi_packages/packages/firebase/firebase_auth/services/firebase_auth_provider.dart';

class FirebaseAuthEmalPassword extends FirebaseAuthProvider {
  FirebaseAuthEmalPassword(FirebaseAuth firebaseAuth) : super(firebaseAuth);

  Future<AuthCredential> getCredentialForEmailPassword(String email, String password) async {
    return EmailAuthProvider.credential(email: email, password: password);
  }

  Future<AuthUser?> signInWithEmailAndPassword(String email, String password) async {
    return signInWithCredential(await getCredentialForEmailPassword(email, password));
  }

  Future<AuthUser?> createUserWithEmailAndPassword(String email, String password) async {
    final authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return FirebaseAuthProvider.userFromFirebase(authResult);
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
