import 'package:json_annotation/json_annotation.dart';

/// Identity for DateTime (leave it to underliying db adapter)
class CustomDateTimeConverter implements JsonConverter<DateTime?, DateTime?> {
  const CustomDateTimeConverter();

  @override
  DateTime? fromJson(DateTime? json) => json;

  @override
  DateTime? toJson(DateTime? json) => json;
}
