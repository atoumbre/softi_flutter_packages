import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';

mixin IndexControllerMixin on IBaseController {
  final index = 0.obs;
  final maxIndex = 1000.obs;
  final minIndex = 0.obs;

  void setValue(int newIndex) {
    index(newIndex);
  }

  void setIndexBounds({int min = 0, int max = 1000}) {
    minIndex(min);
    maxIndex(max);
  }

  void increment() {
    if (index.value < maxIndex()) index.value++;
  }

  void decrement() {
    if (index.value > minIndex()) index.value--;
  }
}
