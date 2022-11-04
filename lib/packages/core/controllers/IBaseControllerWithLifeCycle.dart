import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';
import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';

abstract class IBaseViewControllerWithLifeCycle extends IBaseViewController with WidgetsBindingObserver, LifeCycleMixin {
  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
    ambiguate(WidgetsBinding.instance)?.addObserver(this);
  }

  @mustCallSuper
  @override
  void onClose() {
    ambiguate(WidgetsBinding.instance)?.removeObserver(this);
    super.onClose();
  }
}

abstract class IBaseControllerWithLifeCycle extends IBaseController with WidgetsBindingObserver, LifeCycleMixin {
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
}

mixin LifeCycleMixin on WidgetsBindingObserver {
  final appLifecycleState = Rx<AppLifecycleState>(AppLifecycleState.resumed);

  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onStateChange(AppLifecycleState.resumed);
        break;
      case AppLifecycleState.inactive:
        onStateChange(AppLifecycleState.inactive);
        break;
      case AppLifecycleState.paused:
        onStateChange(AppLifecycleState.paused);
        break;
      case AppLifecycleState.detached:
        onStateChange(AppLifecycleState.detached);
        break;
    }
  }

  void onStateChange(AppLifecycleState newState);
  // void onPaused();
  // void onInactive();
  // void onDetached();

  Future<void> waitForState([AppLifecycleState state = AppLifecycleState.resumed]) {
    var completer = Completer();
    StreamSubscription? _sub;

    _sub = appLifecycleState.listenAndPump((event) {
      if (state == event) {
        _sub?.cancel();
        completer.complete();
      } else {
        print(state);
      }
    });

    return completer.future;
  }
}
