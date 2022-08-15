import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
import 'package:softi_packages/packages/form/helpers/helpers.dart';

mixin FormControllerMixin<T> on IBaseViewController {
  final formKey = GlobalKey<FormBuilderState>().obs;

  RxMap<String, dynamic> initialValue = <String, dynamic>{}.obs;

  // TO OVERRIDE
  Future<T> beforSave(Map<String, dynamic> formData); // _db.deserializer<T>(formData);
  Future<void> afterSave(T record);
  Future<Map<String, dynamic>> buildInitialValue(T? record); // => record.toJson();

  // Methods
  Future<void> initForm(T? editingRecord) async {
    initialValue(await buildInitialValue(editingRecord));
    formKey(GlobalKey<FormBuilderState>());
    print(initialValue());
  }

  void saveState() {
    formKey().currentState!.save();
  }

  Future<void> save() async {
    changeStatusToBusy();

    try {
      formKey().currentState!.save();

      if (formKey().currentState!.validate()) {
        /// Update record with changes from Form
        var _formResult = SoftiHelpers.mergeMap(
          [initialValue(), formKey().currentState!.value],
          acceptNull: true,
          recursive: false,
        );

        /// Fire onSubmit for additional changes
        var _record = await beforSave(_formResult);

        /// Fire onSave with fresh data for side effect (save data, navigate back ...)
        await afterSave(_record);
      } else {
        print('${T.toString()} Form : validation failed');

        // return false;
      }
    } catch (e) {
      rethrow;
    } finally {
      changeStatusToIdle();
    }
  }

  // UTILITIES
  int valueToInt(String value) => int.parse(value);

  double valueToDouble(String value) => double.parse(value);

  dynamic getFieldValue(String field) {
    var result;
    // if (formKey.currentState?.fields == null) {
    //   result = initialValue[field];
    // } else
    if (formKey().currentState?.fields[field] == null) {
      result = initialValue()[field];
    } else {
      result = formKey().currentState!.fields[field]!.value;
    }
    print('$field: $result');
    return result;
  }
}
