import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
import 'package:softi_packages/packages/resource/controllers/RecordControllerMixin.dart';
import 'package:softi_packages/packages/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/resource/models/ResourceRecord.dart';

class RecordController<T extends IResourceData> extends IBaseViewController with RecordControllerMixin<T> {
  @override
  final String id;

  @override
  final bool reactive;

  @override
  final ResourceRecord<T> resourceRecord;

  RecordController(
    this.resourceRecord, {
    this.id = '',
    this.reactive = true,
  });
}
