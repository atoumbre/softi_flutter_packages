typedef Deserializer<T> = T Function(Map<String, dynamic>);

enum ResourceRequestType { call, find, read, create, replace, update, delete }

abstract class IResource<T extends IResourceData> {
  String endpointResolver();
  T deserializer(Map<String, dynamic> serializedData);
}

abstract class IResourceData {
  String? id;
  String? path;
  Map<String, dynamic> toJson();
  String getId();
  String getPath();
  void setId(String newId);
  void setPath(String newPath);
  bool isValid();
}

mixin BaseResourceDataMixin on IResourceData {
  @override
  String getId() => id ?? '';
  @override
  String getPath() => path ?? '';
  @override
  void setId(String newId) => id = newId;
  @override
  void setPath(String newPath) => path = newPath;
  @override
  bool isValid() => (id ?? '') != '';
}
