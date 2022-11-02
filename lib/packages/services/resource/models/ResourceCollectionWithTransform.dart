import 'dart:async';
import 'dart:math';

import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource_adapter.dart';
import 'package:softi_packages/packages/services/resource/models/query.dart';

class Ext<T extends IBaseResourceData> {
  T record;
  bool isNew;
  Ext(this.record, {this.isNew = false});
}

class ResourceCollectionWithTransform<T extends IBaseResourceData, U extends Ext<T>> {
  final IResourceAdapter<T> _adapter;
  final U Function(T) _transform;
  ResourceCollectionWithTransform(IResourceAdapter<T> adapter, U Function(T) transform)
      : _adapter = adapter,
        _transform = transform;

  // Pagination variables
  final List<StreamSubscription> _subscriptions = [];
  final List<int> _eventCounts = [];
  final List<List<T>> _dataPages = [];
  int _pageCount = 0;
  int _queryRecordCount = 0;
  dynamic _lastCursor;
  QueryPagination? _pagination;

  // State tracking variables
  bool _loading = false;
  bool _firstRun = true;

  //  Cache Query params for next call
  late QueryParameters _params;
  late CollectionOptions _options;

  // Returned info
  final hasMoreData = true.obs..stream.listen((event) => print('Has more $event'));
  final data = Rx<List<U>>(<U>[]);
  final loading = false.obs;
  final initialized = false.obs;
  bool get isEmpty => !hasMoreData() && data().isEmpty;

  void requestData(
    QueryParameters params, {
    CollectionOptions options = const CollectionOptions(),
  }) {
    // reset on each call of requestData, use requestMoreData for more data
    if (!_firstRun) _reset();
    _firstRun = false;

    // Save params for next call
    _params = params;
    _options = options;

    // request data
    _requestData();
  }

  Future<void> requestMoreData({refresh = false}) async {
    if (refresh) _reset();
    _requestData();
  }

  void _requestData() {
    if (!hasMoreData.value) return;
    if (_loading) return;

    _loading = true;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loading(_loading);
    });

    _pageCount++;

    //* Update pagination params and Create next query pagination
    var _queryPageSize = (_options.maxRecordNumber == double.infinity) //
        ? _options.pageSize
        : min(_options.maxRecordNumber - _queryRecordCount, _options.pageSize);

    _queryRecordCount += _queryPageSize;

    print('Page Count $_pageCount, Page Size $_queryPageSize');
    _pagination = QueryPagination(
      limit: _queryPageSize,
      cursor: _pageCount == 1 ? null : _lastCursor,
    );

    _eventCounts.add(0);

    var _pageIndex = _pageCount - 1;
    var _sub = _adapter.find(_params, pagination: _pagination, reactive: _options.reactive) //
        .listen(
      (r) {
        _handler(r, _pageIndex);
        _loading = false;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          initialized(true);
          loading(false);
        });
      },
      onError: (_) {
        _loading = false;
        SchedulerBinding.instance.addPostFrameCallback((_) {
          loading(false);
          initialized(true);
        });
      },
      cancelOnError: false,
    );

    _subscriptions.add(_sub);
  }

  /// Snapshot handler
  void _handler(QueryResult<T> queryResult, int pageIndex) {
    _eventCounts[pageIndex]++;

    // If first event, init page data and update cursor
    if (_eventCounts[pageIndex] == 1 && pageIndex == (_eventCounts.length - 1)) {
      _lastCursor = queryResult.cursor;
      _dataPages.add([]);
    }

    if (_options.reactiveRecords) {
      var _res = _getTransformedData(pageIndex, queryResult);
      data.value.assignAll(_res);
      data.refresh();
    } else {
      if (_eventCounts[pageIndex] == 1) {
        var _res = _getTransformedData(pageIndex, queryResult);
        data.value.assignAll(_res);
        data.refresh();
      }
    }

    // print(data.length);
    //
    if (_options.reactiveChanges) {
      if (_eventCounts[pageIndex] > 1) {
        queryResult.data.forEach((e) => _addRecord(e));
        data.refresh();
      }
    }

    // Check if we have more data
    hasMoreData(
      data.value.length >= _queryRecordCount && _queryRecordCount < _options.maxRecordNumber,
    );

    if (!_options.reactive && !hasMoreData.value) {
      _subscriptions.forEach((element) => element.cancel());
    }
  }

  Iterable<U> _getTransformedData(int pageIndex, QueryResult<T> queryResult) {
    _dataPages[pageIndex] = queryResult.data;
    var _data = _dataPages //
        .reduce((value, element) {
      return [...value, ...element];
    });

    var _transformedData = _data.map((record) {
      var index = data.value.indexWhere((element) => element.record.id() == record.id());
      if (index == -1) {
        return _transform(record);
      } else {
        var _result = data.value[index];
        _result.record = record;
        return _result;
      }
    });
    return _transformedData;
  }

  void _reset() async {
    _subscriptions.forEach((element) async => await element.cancel());
    _subscriptions.clear();
    _eventCounts.clear();
    _dataPages.clear();

    _pageCount = 0;
    _queryRecordCount = 0;
    _lastCursor = null;

    hasMoreData(true);
    data([]);
    // changes([]);
  }

  void dispose() {
    _subscriptions.forEach((element) => element.cancel());
    loading.close();
    data.close();
    // changes.close();
    hasMoreData.close();
  }

  void reset() => _reset();

  /// Collection related Service call;

  void _addRecord(T record) {
    var index = data.value.indexWhere((element) => element.record.id() == record.id());
    if (index == -1) {
      data.value.insert(0, _transform(record));
    } else {
      data.value[index].record = record;
    }
  }

  Future<U?> save(U record, {bool refresh = false, bool local = false}) async {
    var _record = local ? record.record : await _adapter.save(record.record);

    if (_record == null) return null;
    var _result = record..record = _record;

    if (!_options.reactiveRecords) {
      _addRecord(_record);
      if (refresh) data.refresh();
    }

    return _result;
  }

  Future<void> delete({String? id, int? index, bool refresh = false, local = false}) async {
    if (id == null && index == null) return;

    var _index = index ?? data.value.indexWhere((element) => element.record.id() == id);

    if (_index == -1) return;

    var _id = id ?? data.value[_index].record.id();

    if (!local) await _adapter.delete(_id);

    if (!_options.reactiveRecords) {
      data.value.removeAt(_index);
      if (refresh) data.refresh();
    }
  }

  void handleListItemCreation(int index) {
    // when item is created we request more data when we reached the end of current page
    // print('${collection.data.value.length} - ${collection.hasMoreData()} - $index');

    if (data.value.length == (index + 1) && hasMoreData.value) {
      requestMoreData();
    }
  }
}

class CollectionOptions {
  final int pageSize;
  final int maxRecordNumber;
  final bool reactiveRecords;
  final bool reactiveChanges;

  const CollectionOptions({
    this.reactiveRecords = true,
    this.reactiveChanges = true,
    this.pageSize = 10,
    this.maxRecordNumber = 100,
  });

  bool get reactive => reactiveRecords || reactiveChanges;
}
