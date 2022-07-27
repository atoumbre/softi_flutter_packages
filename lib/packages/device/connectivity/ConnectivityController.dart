import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';
import 'package:softi_packages/packages/device/connectivity/ConnectivityServiceInterface.dart';

mixin ConnectivityControllerMixin on IBaseController {
  IConnectivityService connectivityService = Get.find<IConnectivityService>();

  Rx<ConnectivityType> connectivityType = ConnectivityType.none.obs;

  void initConnectivityMonitoring() {
    connectivityType.bindStream(connectivityService.streamConectivity);
  }
}

class ConnectivityController extends IBaseController with ConnectivityControllerMixin {
  @override
  final IConnectivityService connectivityService;

  ConnectivityController(this.connectivityService);
}
