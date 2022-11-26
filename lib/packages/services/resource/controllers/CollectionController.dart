import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
import 'package:softi_packages/packages/services/resource/controllers/CollectionWithTransformControllerMixin.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/services/resource/models/ResourceCollection.dart';
import 'package:softi_packages/packages/services/resource/models/ResourceCollectionWithTransform.dart';
import 'package:softi_packages/packages/services/resource/models/query.dart';

class CollectionController<T extends IBaseResourceData> extends IBaseViewController with CollectionWithTransformControllerMixin<T, Ext<T>> {
  @override
  void onInit() {
    super.onInit();
    requestData();
  }

  @override
  final ResourceCollection<T> collection;

  QueryParameters get queryParameters; // => Filter().build();

  CollectionOptions get options; // => CollectionOptions();

  CollectionController(this.collection);
}
