import 'package:softi_packages/packages/core/services/BaseService.dart';

abstract class IStoppableService extends IBaseService {
  bool _serviceIsActive = false;
  bool _serviceIsEnabled = false;

  Future<dynamic> startCallback();
  Future<dynamic> stopCallback();

  bool get isActive => _serviceIsActive;
  bool get isEnabled => _serviceIsEnabled;

  Future<void> enable({bool startLate = false}) async {
    _serviceIsEnabled = true;
    if (!startLate) {
      return start();
    }
  }

  Future<void> disable() {
    _serviceIsEnabled = false;
    return stop();
  }

  Future<void> stop() async {
    if (!_serviceIsEnabled) return;
    if (!_serviceIsActive) return;

    await stopCallback();
    _serviceIsActive = false;
  }

  Future<void> start() async {
    if (!_serviceIsEnabled) return;
    if (_serviceIsActive) return;

    _serviceIsActive = true;
    await startCallback();
  }
}
