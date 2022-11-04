import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';
import 'package:softi_packages/packages/core/services/BaseService.dart';
import 'package:uuid/uuid.dart';

enum ControllerStatus { idle, busy, error }

enum TaskStatus { idle, progress, done, error }

class TaskState {
  TaskStatus status = TaskStatus.idle;
  List<double> progressIndicators = [];
}

abstract class IBaseViewController extends IBaseController {
  final controllerStatus = ControllerStatus.idle.obs;
  final tasksStatus = <String, TaskState>{}.obs;

  // final lastResult = Rx<Result<ServiceFailure, dynamic>>(Success(null));
  // ControllerStatus get controllerStatus => _controllerStatus();

  void setTaskState(String tag, TaskState state) {
    tasksStatus[tag] = state;
  }

  void _resetTaskState() {
    tasksStatus({});
  }

  Future<List<Result<ServiceFailure, R>>> serviceMultiTaskHandler<R>(
    Iterable<Future<R> Function(String)> tasks, {
    Future<void> Function(R, String)? onSuccess,
    Future<void> Function(ServiceFailure, String)? onFailure,
  }) async {
    // Protect
    if (isBusy) {
      return [
        Error<ServiceFailure, R>(ServiceFailure(
          code: 'BUSY_CONTROLLER',
          service: '_INTERNAL_',
        ))
      ];
    }

    changeStatusToBusy();
    _resetTaskState();

    Iterable<Future<Result<ServiceFailure, R>>> _tasks = tasks.map((task) async {
      var taskId = Uuid().v4();

      try {
        var result = await task(taskId);

        if (onSuccess != null) await onSuccess(result, taskId);

        // changeStatusToIdle();
        return Success<ServiceFailure, R>(result);
      } on ServiceFailure catch (e) {
        if (onFailure != null) await onFailure(e, taskId);

        // changeStatusToError();
        return Error<ServiceFailure, R>(e);
      } catch (e) {
        return Error<ServiceFailure, R>(ServiceFailure(
          code: 'CONTROLLER_INTERNAL_ERROR',
          service: '_INTERNAL_',
          rawError: e,
        ));
      }

      // finally {
      //   // toggleIdle();
      // }
    });

    var results = await Future.wait(_tasks);

    changeStatusToIdle();

    return results;
    // try {
    //   var result = await Future.wait(tasks.map((task) => task()));

    //   if (onSuccess != null) await Future.wait(result.map((r) => onSuccess(r)));

    //   changeStatusToIdle();
    //   return Success<ServiceFailure, List<R>>(result);
    // } on ServiceFailure catch (e) {
    //   if (onFailure != null) await onFailure(e);

    //   changeStatusToError();
    //   return Error(e);
    // } catch (e) {
    //   changeStatusToError();
    //   rethrow;
    // } finally {
    //   // toggleIdle();
    // }
  }

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
    _resetTaskState();

    try {
      var result = await task();

      if (onSuccess != null) await onSuccess(result);

      // lastResult(Success(result));

      changeStatusToIdle();

      return Success(result);
    } on ServiceFailure catch (e) {
      if (onFailure != null) await onFailure(e);

      // lastResult(Error(e));

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
