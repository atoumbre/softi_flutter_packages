import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/services/app/local_storage/local_storage_interface.dart';

import 'package:softi_packages/packages/core/controllers/BaseController.dart';

mixin LocaleControllerMixin on IBaseController {
  ILocalStore get _store => Get.find();

  final _locale = Get.deviceLocale!.obs;

  Locale get locale => _locale.value;

  Future<void> _setLanguage(String languageCode) async {
    var l = Get.locale!.toString().split('_');
    var newLocale = Locale(languageCode, l.length > 1 ? l[1] : null);
    await Get.updateLocale(newLocale);

    _locale(newLocale);
  }

  Future<void> setLanguage(String languageCode, {save = true}) async {
    _setLanguage(languageCode);
    if (save) await _store.setKey('language', languageCode);
  }

  Future<void> getLanguage() async {
    var languageText = await _store.getKey('language');
    if (languageText == null) return;

    await _setLanguage(languageText);
  }
}

// class LocaleController extends IBaseController with LocaleControllerMixin {
//   static LocaleController get find => Get.find<LocaleController>();

//   @override
//   void onInit() {
//     super.onInit();
//     getLanguage();
//   }
// }
