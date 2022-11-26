// part 'auth_user.freezed.dart';

class AuthUser {
  final String uid;

  // Is new ?
  bool isNew;

  // Profile infos : Editable by the user
  final String? displayName;
  final String? photoUrl;
  final String? email;
  final String? phoneNumber;

  // Account infos : Not editable from frontend
  final bool? isAnonymous;
  final bool? isEmailVerified;
  final DateTime? creationTime;
  final DateTime? lastSignInTime;

  // Provider Info
  final dynamic appleUserInfo;
  final dynamic googleUserInfo;
  final dynamic facebookUserInfo;

  final dynamic token;

  AuthUser({
    required this.uid,
    this.isNew = false,
    this.displayName,
    this.photoUrl,
    this.email,
    this.phoneNumber,
    this.isAnonymous,
    this.isEmailVerified,
    this.creationTime,
    this.lastSignInTime,
    this.appleUserInfo,
    this.googleUserInfo,
    this.facebookUserInfo,
    this.token,
  });

  // const factory AuthUser({
  //   final String? uid,

  //   // Is new ?
  //   final bool? isNew,

  //   // Profile infos : Editable by the user
  //   final String? displayName,
  //   final String? photoUrl,
  //   final String? email,
  //   final String? phoneNumber,

  //   // Account infos : Not editable from frontend
  //   final bool? isAnonymous,
  //   final bool? isEmailVerified,
  //   final DateTime? creationTime,
  //   final DateTime? lastSignInTime,
  //   final String? providerId,
  //   //
  // })
  //
  //
  void setIsNew(bool val) {
    isNew = val;
  }
}
