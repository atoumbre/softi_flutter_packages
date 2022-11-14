import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/services/resource/models/ResourceCollectionWithTransform.dart';
import 'package:softi_packages/packages/services/resource/models/filters.dart';
import 'package:softi_packages/packages/services/resource/models/query.dart';

mixin CollectionWithTransformControllerMixin<T extends IBaseResourceData, U extends Ext<T>> on IBaseViewController {
  @override
  Future<void> onClose() async => disposeCollection();

  //! Parameters
  ResourceCollectionWithTransform<T, U> get collection;
  QueryParameters get queryParameters => Filter().build();
  CollectionOptions get options => CollectionOptions();

  void handleListItemCreation(int index) {
    // when item is created we request more data when we reached the end of current page
    // print('${collection.data.value.length} - ${collection.hasMoreData()} - $index');
    if (collection.data.value.length == (index + 1) && collection.hasMoreData()) {
      collection.requestMoreData();
    }
  }

  Future<void> requestData() async {
    collection.requestData(
      queryParameters,
      options: options,
    );
  }

  void disposeCollection() {
    print('Dispose Collection Controller');
    collection.dispose();
  }
}
