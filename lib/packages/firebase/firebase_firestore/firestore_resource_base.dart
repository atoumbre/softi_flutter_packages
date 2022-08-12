import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softi_packages/packages/firebase/firebase_firestore/firestore_resource_adapter.dart';
import 'package:softi_packages/packages/external/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/external/resource/interfaces/i_resource_adapter.dart';
import 'package:softi_packages/packages/external/resource/interfaces/i_resource_base.dart';

class FirestoreResourceBase extends IResourceBase {
  final IResource<T> Function<T extends IResourceData>() _resourceResolver;
  final FirebaseFirestore _firebaseFirestore;
  FirestoreResourceBase(
    this._resourceResolver,
    this._firebaseFirestore,
  );

  @override
  IResourceAdapter<T> adapter<T extends IResourceData>(IResource<IResourceData> res) {
    return FirestoreResourceAdapter<T>(_firebaseFirestore)..setResource(res as IResource<T>);
  }

  @override
  IResource<T> resourceResolver<T extends IResourceData>() => _resourceResolver<T>();
}
