import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';

class FirestoreResource<T extends IResourceData> extends IResource<T> {
  final Deserializer<T> fromJson;
  final String Function() endpoint;

  FirestoreResource({
    required this.fromJson,
    required this.endpoint,
  });

  @override
  T deserializer(Map<String, dynamic> serializedData) {
    return fromJson(serializedData);
  }

  @override
  String endpointResolver() => endpoint();
}
