import 'package:softi_packages/packages/core/services/BaseService.dart';

abstract class IDynamicLinkService extends IBaseService {
  /// Resgister deeplink handler
  /// Many handlers can be registered, incomimg deepLink will be pass through
  /// all of them
  ///
  void registerDeeplinkHandler(DeepLinkHandler handler);

  /// Initiate handling of deepLinks
  void handleDeeplinks();

  /// Create DeepLink
  Future<String> createDeepLink(String queryString);
}

class DeepLinkHandler {
  DeepLinkHandler(this.handler, {this.stopAfter = false});

  final bool stopAfter;
  final Function(DynamicLinkData) handler;
}

class DynamicLinkData {
  DynamicLinkData({
    this.link,
    this.iosMinimumVersion,
    this.androidMinimumVersion,
    this.androidClickTimestamp,
  });

  final Uri? link;
  final int? androidMinimumVersion;
  final int? androidClickTimestamp;
  final String? iosMinimumVersion;
}
