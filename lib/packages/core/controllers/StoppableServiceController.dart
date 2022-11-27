import 'package:flutter/scheduler.dart';
import 'package:softi_packages/packages/core/controllers/IBaseControllerWithLifeCycle.dart';
import 'package:softi_packages/packages/core/services/SoppableService.dart';

class StoppableServiceController<T extends IStoppableService> extends IBaseControllerWithLifeCycle {
  final T service;

  StoppableServiceController(this.service);

  @override
  void onInit() async {
    super.onInit();
    await service.start();
  }

  @override
  void onClose() async {
    super.onClose();
    await service.stop();
  }

  @override
  void onStateChange(AppLifecycleState newState) async {
    switch (newState) {
      case AppLifecycleState.detached:
        await service.stop();
        break;

      case AppLifecycleState.inactive:
        await service.stop();
        break;

      case AppLifecycleState.paused:
        await service.stop();
        break;

      case AppLifecycleState.resumed:
        await service.start();
        break;
      default:
    }
  }
}
