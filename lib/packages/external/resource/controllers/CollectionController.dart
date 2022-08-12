import 'package:softi_packages/packages/core/controllers/BaseViewController.dart';
import 'package:softi_packages/packages/external/resource/controllers/CollectionControllerMixin.dart';
import 'package:softi_packages/packages/external/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/external/resource/models/ResourceCollection.dart';
import 'package:softi_packages/packages/external/resource/models/ResourceCollectionWithTransform.dart';
import 'package:softi_packages/packages/external/resource/models/filters.dart';
import 'package:softi_packages/packages/external/resource/models/query.dart';

class CollectionController<T extends IResourceData> extends IBaseViewController with CollectionControllerMixin<T> {
  @override
  final ResourceCollection<T> collection;

  @override
  final QueryParameters queryParameters;

  @override
  final CollectionOptions options;

  CollectionController(
    this.collection, {
    Filter? filter,
    CollectionOptions? options,
  })  : queryParameters = (filter ?? Filter()).build(),
        options = options ?? const CollectionOptions();
}
