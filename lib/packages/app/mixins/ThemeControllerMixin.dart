import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/app/interfaces/local_storage_interface.dart';
import 'package:softi_packages/packages/core/controllers/BaseController.dart';

mixin ThemeControllerMixin on IBaseController {
  ILocalStore get _store => Get.find();

  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;

  ThemeMode get themeMode => _themeMode.value;

  void _setThemeMode(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    _themeMode(themeMode);
  }

  Future<void> setThemeMode(ThemeMode newthemeMode, {save = true}) async {
    _setThemeMode(newthemeMode);
    if (save) {
      await _store.setKey('theme', newthemeMode.toString().split('.')[1]);
    }
  }

  Future<void> getThemeMode() async {
    var themeText = await _store.getKey('theme');
    if (themeText == null) return;
    ThemeMode themeMode;
    try {
      themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = Get.isDarkMode ? ThemeMode.dark : ThemeMode.light; //.system;
    }
    _setThemeMode(themeMode);
  }
}

// class ThemeController extends IBaseController with ThemeControllerMixin {
//   static ThemeController get find => Get.find<ThemeController>();

//   @override
//   void onInit() {
//     super.onInit();
//     getThemeMode();
//   }
// }
