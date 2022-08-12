import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/app/local_storage/local_storage_interface.dart';

import 'package:softi_packages/packages/core/controllers/BaseController.dart';

mixin LocaleControllerMixin on IBaseController {
  ILocalStore get _store => Get.find();

  final _locale = const Locale('fr').obs;

  Locale get locale => _locale.value;

  Future<void> _setLanguage(Locale language) async {
    await Get.updateLocale(language);

    _locale(language);
  }

  Future<void> setLanguage(Locale language, {save = true}) async {
    _setLanguage(language);
    if (save) await _store.setKey('language', language.toString());
  }

  Future<void> getLanguage() async {
    var languageText = await _store.getKey('language');
    if (languageText == null) return;

    var split = languageText.toString().split('_');
    var lang = split.isNotEmpty ? split[0] : '';
    var country = split.length > 1 ? split[1] : '';

    await _setLanguage(Locale(lang, country));
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
