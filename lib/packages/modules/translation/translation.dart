import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:softi_packages/packages/modules/translation/utils/date.dart';
import 'package:softi_packages/softi_packages.dart';

part 'translation.freezed.dart';
part 'translation.g.dart';

@freezed
class TTranslation extends IResourceData with BaseResourceDataMixin, _$TTranslation {
  TTranslation._();

  @CustomDateTimeConverter()
  @JsonSerializable(explicitToJson: true)
  factory TTranslation({
    Map<String, String>? input,
    Map<String, Map<String, String>>? output,
    Map<String, Map<String, String>>? manual,

    //! Timestamp
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _TTranslation;

  factory TTranslation.fromJson(Map<String, dynamic> json) => _$TTranslationFromJson(json);

  bool get isNotValid => !isValid();
}
