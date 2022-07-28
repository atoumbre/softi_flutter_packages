import 'package:firebase_auth/firebase_auth.dart';
import 'package:softi_packages/packages/auth/models/auth_user.dart';

abstract class FirebaseAuthProvider {
  FirebaseAuth get firebaseAuth;
  String get providerId;

  // FirebaseAuthProvider(this.firebaseAuth);

  Future<AuthUser?> signInWithCredential(
    AuthCredential credential, {
    String? displayName,
    String? photoURL,
    required bool linkToUser,
  }) async {
    final authResult = linkToUser ? await firebaseAuth.currentUser!.linkWithCredential(credential) : await firebaseAuth.signInWithCredential(credential);
    if (linkToUser) firebaseAuth.currentUser!.reload();
    // final firebaseUser = authResult.user;

    if (displayName != null) {
      await authResult.user!.updateDisplayName(displayName);
    }
    if (photoURL != null) {
      await authResult.user!.updatePhotoURL(photoURL);
    }

    return userFromFirebase(authResult);
  }

  Future<AuthUser?> unlink() async {
    var _r = FirebaseAuthProvider.authUserFromUser(await firebaseAuth.currentUser?.unlink(providerId));
    firebaseAuth.currentUser!.reload();
    return _r;
  }

  Stream<UserInfo?> get providerData {
    return firebaseAuth.authStateChanges().map((event) {
      try {
        return event!.providerData.firstWhere((element) => element.providerId == providerId);
      } catch (e) {
        return null;
      }
    });
  }

  static AuthUser? userFromFirebase(UserCredential userCredential) {
    var user = userCredential.user;

    var authUser = authUserFromUser(user);

    authUser?.setIsNew(
      userCredential.additionalUserInfo?.isNewUser ?? false,
    );

    return authUser;
  }

  static AuthUser? authUserFromUser(User? user) {
    if (user == null) {
      return null;
    }

    user.uid;
    user.displayName;
    user.email;
    user.emailVerified;
    user.isAnonymous;
    user.metadata.lastSignInTime;
    user.metadata.creationTime;
    user.phoneNumber;
    user.photoURL;
    user.providerData;
    user.refreshToken;

    // user.
    var _authUser = AuthUser(
      uid: user.uid,
      // info
      displayName: user.displayName,
      photoUrl: user.photoURL,
      email: user.email,
      phoneNumber: user.phoneNumber,
      // account
      // providerId: user.providerData,
      isAnonymous: user.isAnonymous,
      isEmailVerified: user.emailVerified,
      creationTime: user.metadata.creationTime,
      lastSignInTime: user.metadata.lastSignInTime,
      appleUserInfo: user.providerData.firstWhere((element) => element.providerId == 'apple.com', orElse: () => UserInfo({})),
      googleUserInfo: user.providerData.firstWhere((element) => element.providerId == 'google.com', orElse: () => UserInfo({})),
      facebookUserInfo: user.providerData.firstWhere((element) => element.providerId == 'facebook.com', orElse: () => UserInfo({})),
    );

    return _authUser;
  }
}
