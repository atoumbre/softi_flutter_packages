import 'package:softi_packages/packages/core/controllers/BaseLifeCycleController.dart';
import 'package:softi_packages/packages/core/services/SoppableService.dart';

class MultipleStoppableServiceController extends IBaseLifeCycleController {
  final Iterable<IStoppableService> services;

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
  void onDetached() async => await stopServices();

  @override
  void onInactive() async => await stopServices();

  @override
  void onPaused() async => await stopServices();

  @override
  void onResumed() async => await startServices();
}
