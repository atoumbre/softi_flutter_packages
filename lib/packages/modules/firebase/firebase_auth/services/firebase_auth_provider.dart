import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/services/auth/models/auth_user.dart';

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
    final authResult =
        linkToUser ? await firebaseAuth.currentUser!.linkWithCredential(credential) : await firebaseAuth.signInWithCredential(credential);
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

  static Future<AuthUser?> userFromFirebase(UserCredential userCredential) async {
    var user = userCredential.user;

    var authUser = await authUserFromUser(user);

    authUser?.setIsNew(
      userCredential.additionalUserInfo?.isNewUser ?? false,
    );

    return authUser;
  }

  static Future<AuthUser?> authUserFromUser(User? user) async {
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
      appleUserInfo: user.providerData.firstWhereOrNull((element) => element.providerId == 'apple.com'),
      googleUserInfo:
          user.providerData.firstWhereOrNull((element) => element.providerId == 'google.com'), //, orElse: () => UserInfo.fromJson({})),
      facebookUserInfo:
          user.providerData.firstWhereOrNull((element) => element.providerId == 'facebook.com'), // orElse: () => UserInfo.fromJson({})),
      token: await user.getIdTokenResult(),
    );

    return _authUser;
  }
}
