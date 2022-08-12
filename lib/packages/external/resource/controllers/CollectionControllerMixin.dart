import 'package:get/get.dart';
import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
import 'package:softi_packages/packages/external/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/external/resource/interfaces/i_resource_adapter.dart';
import 'package:softi_packages/packages/external/resource/models/ResourceCollection.dart';
import 'package:softi_packages/packages/external/resource/models/ResourceCollectionWithTransform.dart';
import 'package:softi_packages/packages/external/resource/models/filters.dart';
import 'package:softi_packages/packages/external/resource/models/query.dart';

mixin CollectionControllerMixin<T extends IResourceData> on IBaseViewController {
  @override
  Future<void> onReady() async {
    super.onReady();
    initCollection();
  }

  @override
  Future<void> onClose() async => disposeCollection();

  //! Parameters
  ResourceCollection<T> get collection;
  QueryParameters get queryParameters => Filter().build();
  CollectionOptions get options => CollectionOptions();

  //! Getters
  List<Ext<T>> get recordList => collection.data();
  int get recordCount => collection.data().length;
  Rx<List<DataChange<T>>> get changesList => collection.changes;
  RxBool get hasMoreData => collection.hasMoreData;
  RxBool get isResourceLoading => collection.loading;

  void handleListItemCreation(int index, [int itemCount = 0]) {
    // when item is created we request more data when we reached the end of current page
    if (collection.data().length == (index + 1) && collection.hasMoreData()) {
      // await serviceTaskHandler(task: () {
      collection.requestMoreData();
      // });
    }
  }

  Future<void> requestData() async {
    // await serviceTaskHandler(() async {
    collection.requestData(
      queryParameters,
      options: options,
    );
    // });
  }

  void initCollection() {
    requestData();
  }

  void disposeCollection() {
    print('Dispose Collection Controller');
    collection.dispose();
  }
}
