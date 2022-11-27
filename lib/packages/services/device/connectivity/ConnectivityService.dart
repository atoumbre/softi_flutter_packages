import 'package:connectivity/connectivity.dart';
import 'package:softi_packages/packages/services/device/connectivity/ConnectivityServiceInterface.dart';

var _map = {
  ConnectivityResult.mobile: ConnectivityType.mobile,
  ConnectivityResult.none: ConnectivityType.none,
  ConnectivityResult.wifi: ConnectivityType.wifi,
};

class ConnectivityService extends IConnectivityService {
  @override
  Future<ConnectivityType> get conectivity {
    return Connectivity().checkConnectivity().then((result) => _map[result]!);
  }

  @override
  Stream<ConnectivityType> get streamConectivity {
    return Connectivity().onConnectivityChanged.map((result) {
      print(result);
      return _map[result]!;
    });
  }
}
