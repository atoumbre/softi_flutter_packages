import 'dart:ui';

import 'package:softi_packages/packages/core/controllers/IBaseControllerWithLifeCycle.dart';
import 'package:softi_packages/packages/core/services/SoppableService.dart';

class MultipleStoppableServiceController<T extends IStoppableService> extends IBaseControllerWithLifeCycle {
  final Iterable<T> services;

  MultipleStoppableServiceController(this.services);

  @override
  void onInit() async {
    super.onInit();
    await startServices();
  }

  Future<void> startServices() async {
    await Future.wait(services.map((e) => e.start()));
  }

  Future<void> stopServices() async {
    await Future.wait(services.map((e) => e.stop()));
  }

  @override
  void onClose() async {
    await stopServices();
    super.onClose();
  }

  @override
  void onStateChange(AppLifecycleState newState) async {
    switch (newState) {
      case AppLifecycleState.detached:
        await stopServices();
        break;

      case AppLifecycleState.inactive:
        await stopServices();
        break;

      case AppLifecycleState.paused:
        await stopServices();
        break;

      case AppLifecycleState.resumed:
        await startServices();
        break;
      default:
    }
  }
}
