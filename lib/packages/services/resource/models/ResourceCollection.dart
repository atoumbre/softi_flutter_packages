import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource_adapter.dart';
import 'package:softi_packages/packages/services/resource/models/ResourceCollectionWithTransform.dart';

class ResourceCollection<T extends IBaseResourceData> extends ResourceCollectionWithTransform<T, Ext<T>> {
  ResourceCollection(
    IResourceAdapter<T> adapter,
  ) : super(adapter, (record) => Ext<T>(record));
}
