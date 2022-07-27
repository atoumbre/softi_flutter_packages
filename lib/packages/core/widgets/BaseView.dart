import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';

abstract class IBaseView<T extends IBaseViewController> extends StatelessWidget {
  const IBaseView({
    Key? key,
  }) : super(key: key);

  T init();
  Widget builder(T controller);
  // Widget? loadingBuilder(T controller) => null;
  // Widget errorBuilder(T controller) => Center(child: Text('An Error Occurs', style: TextStyle(color: Colors.red)));

  String? get tag => null;

  bool get autoRemove => true;

  @override
  Widget build(BuildContext context) {
    return GetX<T>(
      init: init(),
      tag: tag,
      autoRemove: autoRemove,
      builder: (controller) {
        print(controller.controllerStatus);
        // if (controller.controllerStatus() == ControllerStatus.error) {
        //   return errorBuilder(controller);
        // }

        // if (controller.controllerStatus() == ControllerStatus.busy) {
        //   return loadingBuilder(controller) ?? builder(controller);
        // }

        return builder(controller);
      },
    );
  }
}
