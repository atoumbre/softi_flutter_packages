import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
import 'package:softi_packages/packages/form/controllers/FormControllerMixin.dart';

abstract class FormController<T> extends IBaseViewController with FormControllerMixin<T> {
  FormController(editingRecord) {
    initForm(editingRecord);
  }
}
