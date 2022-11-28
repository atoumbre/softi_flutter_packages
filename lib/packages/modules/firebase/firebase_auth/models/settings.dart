import 'package:firebase_auth/firebase_auth.dart';

class FirebaseSettings {
  final String? dynamicLinkPrefix;
  final String? appleSignInCallbackUrl;
  final String? appleSignInClientId;
  final ActionCodeSettings? actionCodeSettings;
  FirebaseSettings({
    this.dynamicLinkPrefix,
    this.actionCodeSettings,
    this.appleSignInCallbackUrl,
    this.appleSignInClientId,
  });
}
