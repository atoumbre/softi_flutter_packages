class FirebaseSettings {
  // Common
  // final bool handleCodeInApp; // true;
  final String? url; // 'https://job-ci.firebaseapp.com/';
  final String? dynamicLinkPrefix; //'https://job-ci.page.link';

  // IOS
  final String? iOSBundleID; // 'com.winsoluce.job.mobile';
  final String? iOSMinimumVersion; // '21';
  final String? appStoreId;

  // Android
  final String? androidPackageName; // 'com.winsoluce.job.mobile';
  final String? androidMinimumVersion; // '21';
  final bool? androidInstallIfNotAvailable; // true;

  // Social Login
  final String? facebookClientId; //"500775533853632";
  final String? appleSignInCallbackUrl; //"500775533853632";
  final String? appleSignInClientId; //"500775533853632";

  const FirebaseSettings({
    this.url,
    this.dynamicLinkPrefix,
    // this.handleCodeInApp = true,
    this.iOSMinimumVersion,
    this.iOSBundleID,
    this.appStoreId,
    this.androidPackageName,
    this.androidInstallIfNotAvailable,
    this.androidMinimumVersion,
    this.facebookClientId,
    this.appleSignInCallbackUrl,
    this.appleSignInClientId,
  });
}

// class FirebaseSettings {
//   final bool handleCodeInApp = true;
//   final String iOSBundleID = 'com.winsoluce.job.mobile';
//   final String androidPackageName = 'com.winsoluce.job.mobile';
//   final String url = 'https://job-ci.firebaseapp.com/';
//   final bool androidInstallIfNotAvailable = true;
//   final String androidMinimumVersion = '21';
//   final String kDynamicLinkPrefix = 'https://job-ci.page.link';
//   final String facebookClientId = "500775533853632";
//   final String facebookRedirectUrl = "https://www.facebook.com/connect/login_success.html";
// }
