import 'dart:async';

import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource_adapter.dart';
import 'package:softi_packages/packages/services/resource/models/query.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseResourceAdapter<T extends IBaseResourceData> extends IResourceAdapter<T> {
  final _supabase = Supabase.instance.client;

  @override
  Stream<QueryResult<T>> find(
    QueryParameters? queryParams, {
    QueryPagination? pagination,
    bool reactive = true,
  }) {
    var _querySnapshot = _supabase.from(resource.endpointResolver()).stream(primaryKey: ['id']);

    var _result = _querySnapshot.map<QueryResult<T>>(
      (snapshot) {
        var _docs = snapshot;

        var data = _docs.map<T>(resource.deserializer).toList();

        return QueryResult<T>(
          data,
          [],
          cursor: null,
        );
      },
    );

    return reactive ? _result : Stream.fromFuture(_result.first);
  }

  // Stream documenent from db
  @override
  Stream<T?> get(String recordId, {bool reactive = true}) {
    var _querySnapshot = _supabase.from(resource.endpointResolver()).stream(primaryKey: ['id']).eq('id', recordId);

    var _result = _querySnapshot.map<T?>((event) => event.length > 0 ? resource.deserializer(event[0]) : null);

    return (reactive) ? _result : Stream.fromFuture(_result.first);
  }

  @override
  Future<void> update(String id, Map<String, dynamic> values) async {
    await _supabase.from(resource.endpointResolver()).update(values).eq('id', id);
  }

  @override
  Future<T?> save(T doc) async {
    var id = doc.id();

    late dynamic result;

    //! Timestamp
    if (id == '') {
      result = await _supabase.from(resource.endpointResolver()).upsert(doc.toJson());
    } else {
      result = await _supabase.from(resource.endpointResolver()).upsert({...doc.toJson(), id: id});
    }

    return resource.deserializer(result);
  }

  @override
  Future<void> delete(String documentId) async {
    await _supabase.from(resource.endpointResolver()).delete().eq('id', documentId);
  }

  @override
  Future<bool> exists(String id) {
    // TODO: implement exists
    throw UnimplementedError();
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
