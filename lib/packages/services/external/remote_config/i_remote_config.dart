import 'package:softi_packages/packages/core/services/BaseService.dart';

abstract class IRemoteConfigService extends IBaseService {
  // Map<String, dynamic> get getConfig;
  Future initialise([Map<String, dynamic>? defaultConfig]);
}
