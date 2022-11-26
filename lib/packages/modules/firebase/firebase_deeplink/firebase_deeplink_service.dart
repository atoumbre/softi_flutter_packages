// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:softi_common/common.dart';
// import 'package:softi_firebase/src/auth/models/settings.dart';

// class FirebaseDeeplinkService extends IDynamicLinkService {
//   FirebaseDeeplinkService(this.settings);

//   final FirebaseSettings settings;
//   final FirebaseDynamicLinks deepLinkInstance = FirebaseDynamicLinks.instance;

//   final List<DeepLinkHandler> _deepLinkHandler = [];

//   @override
//   Future<void> handleDeeplinks() async {
//     // Get the initial dynamic link if the app is opened with a dynamic link
//     final data = await deepLinkInstance.getInitialLink();

//     // handle link that has been retrieved
//     _handleDeeplink(data);

//     // Register a link callback to fire if the app is opened up from the background
//     // using a dynamic link.
//     FirebaseDynamicLinks.instance.onLink.listen(
//       (PendingDynamicLinkData? dynamicLink) async {
//         // handle link that has been retrieved
//         _handleDeeplink(dynamicLink);
//       },
//       onError: (e) async {
//         print('DeepLink Failed: ${e.message}');
//       },
//     );
//   }

//   // DeepLink handler helper
//   void _handleDeeplink(PendingDynamicLinkData? data) async {
//     if (data == null) return;

//     var _data = DynamicLinkData(
//       link: data.link,
//       iosMinimumVersion: data.ios!.minimumVersion,
//       androidMinimumVersion: data.android?.minimumVersion,
//       androidClickTimestamp: data.android?.clickTimestamp,
//     );

//     // bool _stop = false;
//     // _deepLinkHandler.takeWhile((_) => _stop).forEach((element) {
//     _deepLinkHandler.forEach((element) {
//       element.handler(_data);
//       // _stop = element.stopAfter ?? false;
//     });
//   }

//   @override
//   void registerDeeplinkHandler(deepLinkHandler) {
//     _deepLinkHandler.add(deepLinkHandler);
//   }

//   @override
//   Future<String> createDeepLink(String queryString) async {
//     final parameters = DynamicLinkParameters(
//       uriPrefix: settings.dynamicLinkPrefix!,
//       link: Uri.parse('${settings.url}/?$queryString'),
//       navigationInfoParameters: NavigationInfoParameters(),

//       // dynamicLinkParametersOptions: DynamicLinkParametersOptions(
//       //   shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
//       // ),

//       // ANDROID
//       androidParameters: AndroidParameters(
//         packageName: settings.androidPackageName!,
//         minimumVersion: int.parse(settings.androidMinimumVersion!),
//       ),

//       // IOS
//       iosParameters: IOSParameters(
//         bundleId: settings.iOSBundleID!,
//         appStoreId: settings.appStoreId,
//         minimumVersion: settings.iOSMinimumVersion,
//       ),
//     );

//     final dynamicUrl = await FirebaseDynamicLinks.instance.buildShortLink(parameters);

//     return dynamicUrl.toString();
//   }
// }
