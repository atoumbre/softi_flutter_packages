// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:softi_packages/packages/modules/firebase/firebase_firestore/firebase_deserializer.dart';
// import 'package:softi_packages/packages/modules/firebase/firebase_firestore/firebase_resource.dart';
// import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
// import 'package:softi_packages/packages/services/resource/interfaces/i_resource_adapter.dart';
// import 'package:softi_packages/packages/services/resource/models/query.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class SupabaseResourceAdapter<T extends IBaseResourceData> extends IResourceAdapter<T> {
//   final _supabase = Supabase.instance.client;

//   @override
//   Stream<QueryResult<T>> find(
//     QueryParameters? queryParams, {
//     QueryPagination? pagination,
//     bool reactive = true,
//   }) {
//     var _querySnapshot = _supabase.from(resource.endpointResolver()).stream(primaryKey: ['id']);

//     var _result = _querySnapshot.map<QueryResult<T>>(
//       (snapshot) {
//         var _docs = snapshot;

//         //! Filter possible here
//         var data = _docs.map<T>(resource.deserializer).toList();

//         // var changes = snapshot.docChanges
//         //     //! Filter possible here
//         //     .map((DocumentChange docChange) => DataChange<T>(
//         //           data: fromFirestore<T>(resource as FirestoreResource<T>, docChange.doc),
//         //           oldIndex: docChange.oldIndex,
//         //           newIndex: docChange.newIndex,
//         //           type: {
//         //             DocumentChangeType.added: DataChangeType.added,
//         //             DocumentChangeType.modified: DataChangeType.modified,
//         //             DocumentChangeType.removed: DataChangeType.removed,
//         //           }[docChange.type],
//         //         ))
//         //     .toList();

//         return QueryResult<T>(
//           data,
//           [],
//           cursor: null,
//         );
//       },
//     );

//     return reactive ? _result : Stream.fromFuture(_result.first);
//   }

//   // Stream documenent from db
//   @override
//   Stream<T?> get(String recordId, {bool reactive = true}) {
//     var _querySnapshot = _supabase.from(resource.endpointResolver()).stream(primaryKey: ['id']).eq('id', recordId);

//     var _result = _querySnapshot.map<T?>((event) => event.length > 0 ? resource.deserializer(event[0]) : null);

//     return (reactive) ? _result : Stream.fromFuture(_result.first);
//   }

//   @override
//   Future<void> update(String id, Map<String, dynamic> values) async {
//     var _map = firestoreMap(values, true);

//     await docRef.update(_map);
//   }

//   @override
//   Future<T?> save(T doc) async {
//     var id = doc.id();
//     DocumentReference docRef;

//     var _map = toFirestore(doc);

//     //! Timestamp
//     if (id == '') {
//       //+ Creation
//       // _map['createdAt'] = FieldValue.serverTimestamp();
//       docRef = await _getRef(resource as FirestoreResource<T>).add(_map);
//     } else {
//       //+ Update
//       docRef = _getRef(resource as FirestoreResource<T>).doc(id);
//       await docRef.update(_map); //, SetOptions(merge: false));
//     }

//     var _doc = await docRef.snapshots().first;
//     return fromFirestore<T>(resource as FirestoreResource<T>, _doc);
//   }

//   @override
//   Future<void> delete(String documentId) async {
//     await supabase.from('cities').delete().match({'id': documentId});
//   }

//   @override
//   Future<bool> exists(String id) {
//     // TODO: implement exists
//     throw UnimplementedError();
//   }

//   /// Internala fmethodes
//   // Query _firestoreQueryBuilder(
//   //   CollectionReference ref, {
//   //   QueryParameters? params,
//   //   QueryPagination? pagination,
//   // }) {
//   //   Query _query = ref;

//   //   if (params?.filterList != null) {
//   //     params!.filterList!.forEach((where) {
//   //       if (where.value != null)
//   //         switch (where.condition) {
//   //           case QueryOperator.equal:
//   //             _query = _query.where(where.field!, isEqualTo: where.value);
//   //             break;
//   //           case QueryOperator.notEqual:
//   //             _query = _query.where(where.field!, isNotEqualTo: where.value);
//   //             break;
//   //           case QueryOperator.greaterThanOrEqualTo:
//   //             _query = _query.where(where.field!,
//   //                 isGreaterThanOrEqualTo: where.value);
//   //             break;
//   //           case QueryOperator.greaterThan:
//   //             _query = _query.where(where.field!, isGreaterThan: where.value);
//   //             break;
//   //           case QueryOperator.lessThan:
//   //             _query = _query.where(where.field!, isLessThan: where.value);
//   //             break;
//   //           case QueryOperator.lessThanOrEqualTo:
//   //             _query =
//   //                 _query.where(where.field!, isLessThanOrEqualTo: where.value);
//   //             break;
//   //           case QueryOperator.isIn:
//   //             _query = _query.where(where.field!, whereIn: where.value);
//   //             break;
//   //           case QueryOperator.arrayContains:
//   //             _query = _query.where(where.field!, arrayContains: where.value);
//   //             break;
//   //           case QueryOperator.arrayContainsAny:
//   //             _query =
//   //                 _query.where(where.field!, arrayContainsAny: where.value);
//   //             break;
//   //           default:
//   //         }
//   //     });
//   //   }

//   //   // Set orderBy
//   //   if (params?.sortList != null) {
//   //     params!.sortList.forEach((orderBy) {
//   //       _query = _query.orderBy(orderBy.field!, descending: orderBy.desc);
//   //     });
//   //   }

//   //   // Get the last Document
//   //   if (pagination?.cursor != null) {
//   //     _query = _query.startAfterDocument(pagination?.cursor);
//   //   }

//   //   // if (pagination?.endCursor != null) {
//   //   //   _query = _query.endAtDocument(pagination?.endCursor);
//   //   // }

//   //   _query = _query.limit(pagination?.limit ?? 10);

//   //   return _query;
//   // }
// }
