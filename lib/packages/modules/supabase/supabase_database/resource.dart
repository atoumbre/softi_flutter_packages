import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';

class SupabaseResource<T extends IBaseResourceData> extends IResource<T> {
  final Deserializer<T> fromJson;
  final String table;

  SupabaseResource({
    required this.fromJson,
    required this.table,
  });

  @override
  T deserializer(Map<String, dynamic> serializedData) {
    return fromJson(serializedData);
  }

  @override
  String endpointResolver() => table;
}
