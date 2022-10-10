import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_firestore/firestore_resource_adapter.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource_adapter.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource_base.dart';

class FirestoreResourceBase extends IResourceBase {
  final IResource<T> Function<T extends IBaseResourceData>() _resourceResolver;
  final FirebaseFirestore _firebaseFirestore;
  FirestoreResourceBase(
    this._resourceResolver,
    this._firebaseFirestore,
  );

  @override
  IResourceAdapter<T> adapter<T extends IBaseResourceData>(IResource<IBaseResourceData> res) {
    return FirestoreResourceAdapter<T>(_firebaseFirestore)..setResource(res as IResource<T>);
  }

  @override
  IResource<T> resourceResolver<T extends IBaseResourceData>() => _resourceResolver<T>();
}
