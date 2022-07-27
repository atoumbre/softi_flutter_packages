import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';

abstract class IBaseLifeCycleController extends IBaseController with WidgetsBindingObserver {
  final appLifecycleState = Rx<AppLifecycleState>(AppLifecycleState.resumed);

  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @mustCallSuper
  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print('AppLifecycleState.resumed');
        onResumed();
        break;
      case AppLifecycleState.inactive:
        print('AppLifecycleState.inactive');
        onInactive();
        break;
      case AppLifecycleState.paused:
        print('AppLifecycleState.paused');
        onPaused();
        break;
      case AppLifecycleState.detached:
        print('AppLifecycleState.detached');
        onDetached();
        break;
    }

    appLifecycleState(state);
  }

  void onResumed();
  void onPaused();
  void onInactive();
  void onDetached();
}
