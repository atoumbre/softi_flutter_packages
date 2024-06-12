import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';
import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';

abstract class IBaseViewControllerWithLifeCycle extends IBaseViewController
    with WidgetsBindingObserver, LifeCycleMixin {
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

abstract class IBaseControllerWithLifeCycle extends IBaseController
    with WidgetsBindingObserver, LifeCycleMixin {
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
    appLifecycleState(state);
    print('AppState $appLifecycleState');

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
      case AppLifecycleState.hidden:
        onStateChange(AppLifecycleState.hidden);
        break;
    }
  }

  void onStateChange(AppLifecycleState newState);

  Future<void> waitForState(AppLifecycleState state) {
    var completer = Completer();
    StreamSubscription? _sub;

    _sub = appLifecycleState.listen((event) {
      if (state == event) {
        _sub?.cancel();
        completer.complete();
      } else {
        print(event);
      }
    });

    return completer.future;
  }
}
