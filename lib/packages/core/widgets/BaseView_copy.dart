import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';

abstract class IBaseView<T extends IBaseViewController> extends StatelessWidget {
  IBaseView(T? controller, {super.key, String? tag})
      : _controller = controller == null //
            ? Get.find<T>()
            : Get.put(controller, tag: tag);

  final T _controller;

  Widget builder(T controller);

  // T init() => Get.find<T>();
  // Widget? loadingBuilder(T controller) => null;
  // Widget errorBuilder(T controller) => Center(child: Text('An Error Occurs', style: TextStyle(color: Colors.red)));
  // String? get tag => null;
  // bool get autoRemove => true;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(_controller.controllerStatus);
      return builder(_controller);
    });
  }
}
