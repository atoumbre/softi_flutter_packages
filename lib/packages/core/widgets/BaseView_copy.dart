import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';

abstract class IBaseView<T extends IBaseViewController> extends StatelessWidget {
  IBaseView(T? controller, {super.key, String? tag, bool? permanent})
      : _controller = controller == null //
            ? Get.find<T>(tag: tag)
            : Get.put(controller, tag: tag, permanent: permanent ?? false);

  final T _controller;

  Widget builder(T controller);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      print(_controller.controllerStatus);
      return builder(_controller);
    });

    //   return GetX<T>(
    //     init: controller ?? Get.find<T>(tag: tag),
    //     tag: tag,
    //     autoRemove: !(permanent ?? false),
    //     builder: (controller) {
    //       print(controller.controllerStatus);
    //       // if (controller.controllerStatus() == ControllerStatus.error) {
    //       //   return errorBuilder(controller);
    //       // }

    //       // if (controller.controllerStatus() == ControllerStatus.busy) {
    //       //   return loadingBuilder(controller) ?? builder(controller);
    //       // }

    //       return builder(controller);
    //     },
    //   );
  }
}
