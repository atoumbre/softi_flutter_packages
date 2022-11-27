import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
import 'package:softi_packages/packages/modules/form/controllers/FormControllerMixin.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource_base.dart';

abstract class ResourceFormController<T extends IBaseResourceData> extends IBaseViewController with FormControllerMixin<T> {
  final IResourceBase db;
  final T record;
  final bool refreshRecord;

  ResourceFormController(this.record, {required this.db, this.refreshRecord = true});

  T? _editingRecord;

  @override
  void onInit() {
    super.onInit();

    Future(() async {
      if (refreshRecord && record.isValid()) {
        _editingRecord = (await db.api<T>().get(record.id(), reactive: false).first);
      } else {
        _editingRecord = record;
      }

      await initForm(_editingRecord);
    });
  }

  @override
  Future<void> onClose() async {}

  @override
  Future<Map<String, dynamic>> buildInitialValue(T? record) async => record?.toJson() ?? {};

  @override
  Future<T> beforSave(Map<String, dynamic> formData) async {
    var record = db.resource<T>().deserializer(transformer(formData));
    return await beforeResourceSave(record..id(this.record.id()));
  }

  @override
  Future<void> afterSave(T record) async {
    var result = await db.api<T>().save(record);
    await afterResourceSave(result);
  }

//  Map<String, dynamic>.from(snapshot.value)
  Map<String, dynamic> transformer(Map<String, dynamic> json) => json;
  Future<T> beforeResourceSave(T record) async => record;
  Future<void> afterResourceSave(T? record);
}
