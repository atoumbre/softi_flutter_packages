import 'package:softi_packages/packages/core/services/BaseService.dart';

abstract class ILocalStore extends IBaseService {
  Future<String?> getKey(String key);
  Future<String?> getSecuredKey(String key);
  Future<void> setKey(String key, dynamic value);
  Future<void> setSecuredKey(String key, dynamic value);
}
