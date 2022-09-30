import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
import 'package:softi_packages/packages/core/services/BaseService.dart';

abstract class ILoadingService extends IBaseService {
  Future<void> dismiss();

  Future<void> showStatus({String? status});

  Future<void> showProgress({String? status, required double progress});

  Future<void> showInfo(String status, {Duration? duration, bool? dismissOnTap});

  Future<void> showError(String status, {Duration? duration, bool? dismissOnTap});

  Future<void> showSuccess(String status, {Duration? duration, bool? dismissOnTap});

  Future<void> showToast(String status, {Duration? duration, bool? dismissOnTap});
}

class LoadingServiceExeption extends ServiceFailure {
  LoadingServiceExeption({
    required String code,
    String? message,
  }) : super(
          service: 'Loading',
          code: code,
          message: message,
        );
}

mixin LoadingControllerMixin on IBaseViewController {
  ILoadingService get loadingService => Get.find();

  // RxBool autoLoadingIndicator = true.obs;

  late dynamic worker;

  @override
  void onInit() {
    super.onInit();

    ever(controllerStatus, (ControllerStatus status) {
      // if (!autoLoadingIndicator()) return;
      switch (status) {
        case ControllerStatus.busy:
          loadingService.showStatus();
          break;
        case ControllerStatus.error:
          loadingService.showError('Une erreur est survenue');
          break;
        case ControllerStatus.idle:
          loadingService.dismiss();
          break;
        default:
      }
    });
  }
}
