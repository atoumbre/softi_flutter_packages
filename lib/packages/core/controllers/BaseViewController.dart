import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';
import 'package:softi_packages/packages/core/services/BaseService.dart';

enum ControllerStatus { idle, busy, error }

abstract class IBaseViewController extends IBaseController {
  final controllerStatus = ControllerStatus.idle.obs;
  final lastResult = Rx<Result<ServiceFailure, dynamic>>(Success(null));

  // ControllerStatus get controllerStatus => _controllerStatus();

  Future<Result<ServiceFailure, R>> serviceTaskHandler<R>(
    Future<R> Function() task, {
    Future<void> Function(R)? onSuccess,
    Future<void> Function(ServiceFailure)? onFailure,
  }) async {
    // Protect
    if (isBusy) {
      return Error(ServiceFailure(
        code: 'BUSY_CONTROLLER',
        service: '_INTERNAL_',
      ));
    }

    changeStatusToBusy();

    try {
      var result = await task();

      if (onSuccess != null) await onSuccess(result);

      lastResult(Success(result));

      changeStatusToIdle();

      return Success(result);
    } on ServiceFailure catch (e) {
      if (onFailure != null) await onFailure(e);

      lastResult(Error(e));

      changeStatusToError();

      return Error(e);
    } catch (e) {
      changeStatusToError();

      rethrow;
    } finally {
      // toggleIdle();
    }
  }

  void changeStatus(ControllerStatus newStatus) {
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    controllerStatus(newStatus);
    // });
    if (ControllerStatus.error == newStatus) Future.delayed(Duration(seconds: 2)).then((_) => controllerStatus(ControllerStatus.idle));
  }

  void changeStatusToIdle() {
    changeStatus(ControllerStatus.idle);
  }

  void changeStatusToError() {
    changeStatus(ControllerStatus.error);
  }

  void changeStatusToBusy() {
    changeStatus(ControllerStatus.busy);
  }

  bool get isIdle => controllerStatus() == ControllerStatus.idle;
  bool get isErrored => controllerStatus() == ControllerStatus.error;
  bool get isBusy => controllerStatus() == ControllerStatus.busy;
}
