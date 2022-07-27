import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
import 'package:softi_packages/packages/form/controllers/FormControllerMixin.dart';
import 'package:softi_packages/packages/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/resource/interfaces/i_resource_base.dart';

abstract class ResourceFormController<T extends IResourceData> extends IBaseViewController with FormControllerMixin<T> {
  final IResourceBase db;
  final T record;
  final bool refreshRecord;

  ResourceFormController(this.record, {required this.db, this.refreshRecord = true});

  T? _editingRecord;

  @override
  Future<void> onInit() async {
    super.onInit();

    if (refreshRecord && record.isValid()) {
      _editingRecord = (await db.api<T>().get(record.getId(), reactive: false).first);
    } else {
      _editingRecord = record;
    }

    await initForm(_editingRecord);
  }

  @override
  Future<void> onClose() async {}

  @override
  Future<Map<String, dynamic>> buildInitialValue(T? record) async => record?.toJson() ?? {};

  @override
  Future<T> beforSave(Map<String, dynamic> formData) async {
    var record = db.resource<T>().deserializer(transformer(formData));
    return await beforeResourceSave(record);
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
