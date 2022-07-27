import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:softi_packages/packages/app/interfaces/local_storage_interface.dart';

class LocalStore extends ILocalStore {
  final GetStorage _storage;
  final FlutterSecureStorage _secureStorage;

  LocalStore()
      : _storage = GetStorage(),
        _secureStorage = FlutterSecureStorage();

  @override
  Future<void> init([String container = 'GetStorage']) async {
    await GetStorage.init();
    return;
  }

  @override
  Future<String?> getKey(String key) async {
    return _storage.read(key);
  }

  @override
  Future<String?> getSecuredKey(String key) async {
    return _secureStorage.read(key: key);
  }

  @override
  Future<void> setKey(String key, value) async {
    return _storage.write(key, value);
  }

  @override
  Future<void> setSecuredKey(String key, value) async {
    return _secureStorage.write(key: key, value: value);
  }
}
