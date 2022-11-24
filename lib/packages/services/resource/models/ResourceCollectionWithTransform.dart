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
  bool isSelected;
  Ext(this.record, {this.isNew = false, this.isSelected = false});
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

  //  Cache Query params for next call
  late QueryParameters _params;
  late CollectionOptions _options;

  // Returned info
  final selectedItemId = ''.obs;
  final hasMoreData = true.obs..stream.listen((event) => print('Has more $event'));
  final data = Rx<List<U>>(<U>[]);
  final loading = false.obs;
  final initialized = false.obs;

  bool get isEmpty => !hasMoreData() && data().isEmpty;
  Map<String, U> get dataMap => Map.fromEntries(data().where((e) => e.record.id() != '').map((item) => MapEntry(item.record.id(), item)));
  U? get selectedItem => selectedItemId() != '' ? dataMap[selectedItemId()] : (dataMap.values.isEmpty ? null : dataMap.values.first);

  int getIndex(String id) => data.value.indexWhere((e) => e.record.id() != '');

  void requestData(QueryParameters params, {CollectionOptions options = const CollectionOptions()}) {
    _params = params;
    _options = options;

    requestMoreData(refresh: true);
  }

  void requestMoreData({bool refresh = false}) {
    if (!hasMoreData.value && !refresh) return;
    if (_loading) return;

    if (refresh) {
      reset();
    }

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
        // Update and add new records
        queryResult.changes //
            .where((element) => element.type != DataChangeType.removed)
            .forEach((e) {
          if (e.data != null) _addRecord(e.data!);
        });

        // Delete removed items
        var removedIds = queryResult.changes
            .where((element) => element.type == DataChangeType.removed) //
            .toList()
            .map((e) => e.data?.id() ?? '');

        data.value.removeWhere((record) => removedIds.contains(record.record.id()));

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
        return _transform(record); //..isEdited = false;
      } else {
        var _result = data.value[index];
        // if (_result.isEdited == true) return _result;
        _result.record = record;
        return _result; //..isEdited = false;
      }
    });
    return _transformedData;
  }

  void reset() async {
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

  // void reset() => _reset();

  /// Collection related Service call;

  int _addRecord(T record) {
    var index = data.value.indexWhere((element) => element.record.id() == record.id());
    if (index == -1) {
      data.value.insert(0, _transform(record));
      index = 0;
    } else {
      data.value[index].record = record;
    }

    return index;
  }

  Future<U?> save(U record, {bool refresh = false, bool local = false}) async {
    var _record = local ? record.record : await _adapter.save(record.record);

    if (_record == null) return null;
    var _result = record..record = _record;

    if (!_options.reactiveRecords && !_options.reactiveChanges) {
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

    if (!_options.reactive) {
      data.value.removeAt(_index);
      if (refresh) data.refresh();
    }
  }

  void selectRecords(List<String> ids, {required bool Function(U) critiria, refresh = true}) {
    var i = 0;
    data.value.forEach((element) {
      data.value[i].isSelected = critiria(element);
      i++;
    });
    if (refresh) data.refresh();
  }

  void selectItem({String? id, int? index, bool refresh = false, local = false}) {
    if (id == null && index == null) return;

    var _index = index ?? data.value.indexWhere((element) => element.record.id() == id);

    if (_index == -1) {
      selectedItemId.value = '';
    } else {
      selectedItemId.value = data.value[_index].record.id();
    }

    if (refresh) {
      selectedItemId.refresh();
    }
  }
}

class CollectionOptions {
  final int pageSize;
  final int maxRecordNumber;
  final bool reactiveRecords;
  final bool reactiveChanges;

  const CollectionOptions({
    this.reactiveRecords = false,
    this.reactiveChanges = true,
    this.pageSize = 10,
    this.maxRecordNumber = 100,
  });

  bool get reactive => reactiveRecords || reactiveChanges;
}
