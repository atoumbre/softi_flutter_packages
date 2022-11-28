import 'package:json_annotation/json_annotation.dart';
import 'package:softi_packages/softi_packages.dart';

/// Identity for DateTime (leave it to underliying db adapter)
class CustomRemoteAssetTimeConverter implements JsonConverter<RemoteAsset?, Map<String, dynamic>?> {
  const CustomRemoteAssetTimeConverter();

  @override
  RemoteAsset? fromJson(Map<String, dynamic>? json) => RemoteAsset.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(RemoteAsset? instance) => instance?.toJson() ?? {};
}
