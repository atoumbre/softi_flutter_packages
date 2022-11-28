typedef Deserializer<T> = T Function(Map<String, dynamic>);

// enum ResourceRequestType { call, find, read, create, replace, update, delete }

abstract class IResource<T extends IBaseResourceData> {
  String endpointResolver();
  T deserializer(Map<String, dynamic> serializedData);
}

abstract class IBaseResourceData {
  String _id = '';
  String _path = '';
  DateTime? _createdAt;
  DateTime? _updatedAt;

  Map<String, dynamic> toJson();

  DateTime? createdAt([DateTime? dateTime]);
  DateTime? updatedAt([DateTime? dateTime]);
  String id([String? newId]);
  String path([String? newPath]);

  bool isValid();
}

mixin BaseResourceDataMixin on IBaseResourceData {
  @override
  String id([String? newId]) {
    if (newId != null) _id = newId;
    return _id;
  }

  @override
  String path([String? newPath]) {
    if (newPath != null) _path = newPath;
    return _path;
  }

  @override
  DateTime? createdAt([DateTime? dateTime]) {
    if (dateTime != null) _createdAt = dateTime;
    return _createdAt;
  }

  @override
  DateTime? updatedAt([DateTime? dateTime]) {
    if (dateTime != null) _updatedAt = dateTime;
    return _updatedAt;
  }

  @override
  bool isValid() => _id != '';
}

extension SetId on IBaseResourceData {
  dynamic setId<T extends BaseResourceDataMixin>(BaseResourceDataMixin? a) {
    if (a == null) return this;

    return this
      ..id(a.id())
      ..createdAt(a.createdAt())
      ..updatedAt(a.updatedAt());
  }
}
