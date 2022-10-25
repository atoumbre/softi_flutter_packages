import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource_adapter.dart';

class ResourceRecord<T extends IBaseResourceData> {
  final IResourceAdapter<T> adapter;
  ResourceRecord(this.adapter); // : data = adapter.resource.deserializer({}).obs;

  final Rxn<T> data = Rxn<T>();
  final RxInt fetchCount = 0.obs;
  late StreamSubscription<T?> _sub;
  late String _id;

  bool _initialized = false;

  String get id => data()?.id() ?? '';

  void init(
    String recordId, {
    bool reactive = true,
    T? autoCreate,
  }) {
    reset(true);

    _id = recordId;

    _sub = adapter.get(recordId, reactive: reactive).listen((event) async {
      T? _newValue = event;
      if (event == null && autoCreate != null) {
        _newValue = await adapter.save(autoCreate);
      }

      fetchCount.value++;
      data.value = _newValue;
      data.refresh();
      fetchCount.refresh();
    });

    _initialized = true;
  }

  Future<T?> save() async {
    if (data.value == null) return null;
    return adapter.save(data.value!);
  }

  Future<void> update(Map<String, dynamic> values) async {
    return adapter.update(_id, values);
  }

  void reset([silent = false]) {
    if (_initialized) _sub.cancel();
    _initialized = false;
    _id = '';
    data.value = null;
    fetchCount.value = 0;
    if (!silent) {
      data.refresh();
      fetchCount.refresh();
    }
  }

  void dispose() {
    reset();
    data.close();
    fetchCount.close;
  }

  T? call([T? newData]) {
    if (newData != null) data(newData);
    return data.value;
  }
}
