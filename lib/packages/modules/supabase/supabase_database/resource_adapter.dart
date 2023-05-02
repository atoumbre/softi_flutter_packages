import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_firestore/firebase_deserializer.dart';
import 'package:softi_packages/packages/modules/firebase/firebase_firestore/firebase_resource.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource_adapter.dart';
import 'package:softi_packages/packages/services/resource/models/query.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseResourceAdapter<T extends IBaseResourceData>
    extends IResourceAdapter<T> {
  final supabase = Supabase.instance.client;

  @override
  Stream<QueryResult<T>> find(
    QueryParameters? queryParams, {
    QueryPagination? pagination,
    bool reactive = true,
  }) {
    var _query = _firestoreQueryBuilder(
      _getRef(resource as FirestoreResource<T>),
      params: queryParams,
      pagination: pagination,
    );

    var _querySnapshot = _query.snapshots();

    var _result = _querySnapshot.map<QueryResult<T>>(
      (snapshot) {
        var i = 0;
        var _docs = snapshot.docs;

        //! Filter possible here
        var data = _docs.map<T>((doc) {
          var res = fromFirestore<T>(resource as FirestoreResource<T>, doc);
          if (res == null) {
            print(res);
          }
          return res!;
        }).toList();

        var changes = snapshot.docChanges
            //! Filter possible here
            .map((DocumentChange docChange) => DataChange<T>(
                  data: fromFirestore<T>(
                      resource as FirestoreResource<T>, docChange.doc),
                  oldIndex: docChange.oldIndex,
                  newIndex: docChange.newIndex,
                  type: {
                    DocumentChangeType.added: DataChangeType.added,
                    DocumentChangeType.modified: DataChangeType.modified,
                    DocumentChangeType.removed: DataChangeType.removed,
                  }[docChange.type],
                ))
            .toList();

        return QueryResult<T>(
          data,
          changes,
          cursor: snapshot.docs.isNotEmpty ? snapshot.docs.last : null,
        );
      },
    );

    return reactive ? _result : Stream.fromFuture(_result.first);
  }

  // Check if record exsits
  @override
  Future<bool> exists(String recordId) async {
    var _result = await _getRef(resource as FirestoreResource<T>) //
        .doc(recordId)
        .snapshots()
        .first;

    return _result.exists;
  }

  // Stream documenent from db
  @override
  Stream<T?> get(String recordId, {bool reactive = true}) {
    var _result = _getRef(resource as FirestoreResource<T>) //
        .doc(recordId)
        .snapshots()
        .map<T?>((snapshot) =>
            fromFirestore<T>(resource as FirestoreResource<T>, snapshot));

    return (reactive) ? _result : Stream.fromFuture(_result.first);
  }

  @override
  Future<void> update(String id, Map<String, dynamic> values) async {
    var docRef = _getRef(resource as FirestoreResource<T>) //
        .doc(id);

    var _map = firestoreMap(values, true);

    await docRef.update(_map);
  }

  @override
  Future<T?> save(T doc) async {
    var id = doc.id();
    DocumentReference docRef;

    var _map = toFirestore(doc);

    //! Timestamp
    if (id == '') {
      //+ Creation
      // _map['createdAt'] = FieldValue.serverTimestamp();
      docRef = await _getRef(resource as FirestoreResource<T>).add(_map);
    } else {
      //+ Update
      docRef = _getRef(resource as FirestoreResource<T>).doc(id);
      await docRef.update(_map); //, SetOptions(merge: false));
    }

    var _doc = await docRef.snapshots().first;
    return fromFirestore<T>(resource as FirestoreResource<T>, _doc);
  }

  @override
  Future<void> delete(String documentId) async {
    await supabase.from('cities').delete().match({'id': documentId});
  }

  /// Internala fmethodes
  // Query _firestoreQueryBuilder(
  //   CollectionReference ref, {
  //   QueryParameters? params,
  //   QueryPagination? pagination,
  // }) {
  //   Query _query = ref;

  //   if (params?.filterList != null) {
  //     params!.filterList!.forEach((where) {
  //       if (where.value != null)
  //         switch (where.condition) {
  //           case QueryOperator.equal:
  //             _query = _query.where(where.field!, isEqualTo: where.value);
  //             break;
  //           case QueryOperator.notEqual:
  //             _query = _query.where(where.field!, isNotEqualTo: where.value);
  //             break;
  //           case QueryOperator.greaterThanOrEqualTo:
  //             _query = _query.where(where.field!,
  //                 isGreaterThanOrEqualTo: where.value);
  //             break;
  //           case QueryOperator.greaterThan:
  //             _query = _query.where(where.field!, isGreaterThan: where.value);
  //             break;
  //           case QueryOperator.lessThan:
  //             _query = _query.where(where.field!, isLessThan: where.value);
  //             break;
  //           case QueryOperator.lessThanOrEqualTo:
  //             _query =
  //                 _query.where(where.field!, isLessThanOrEqualTo: where.value);
  //             break;
  //           case QueryOperator.isIn:
  //             _query = _query.where(where.field!, whereIn: where.value);
  //             break;
  //           case QueryOperator.arrayContains:
  //             _query = _query.where(where.field!, arrayContains: where.value);
  //             break;
  //           case QueryOperator.arrayContainsAny:
  //             _query =
  //                 _query.where(where.field!, arrayContainsAny: where.value);
  //             break;
  //           default:
  //         }
  //     });
  //   }

  //   // Set orderBy
  //   if (params?.sortList != null) {
  //     params!.sortList.forEach((orderBy) {
  //       _query = _query.orderBy(orderBy.field!, descending: orderBy.desc);
  //     });
  //   }

  //   // Get the last Document
  //   if (pagination?.cursor != null) {
  //     _query = _query.startAfterDocument(pagination?.cursor);
  //   }

  //   // if (pagination?.endCursor != null) {
  //   //   _query = _query.endAtDocument(pagination?.endCursor);
  //   // }

  //   _query = _query.limit(pagination?.limit ?? 10);

  //   return _query;
  // }
}
