import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';

mixin TranslationControllerMixin on IBaseController {
  Map<String, Map<String, String>> translations();

  void loadTranslations() {
    // ignore: no_leading_underscores_for_local_identifiers
    var _translations = translations();
    Get.appendTranslations(_translations);
  }
}
