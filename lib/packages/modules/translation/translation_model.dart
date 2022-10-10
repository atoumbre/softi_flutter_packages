import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:softi_packages/packages/common/convertors/date.dart';
import 'package:softi_packages/packages/services/resource/interfaces/i_resource.dart';

part 'translation_model.freezed.dart';
part 'translation_model.g.dart';

@freezed
class TTranslation extends IBaseResourceData with BaseResourceDataMixin, _$TTranslation {
  TTranslation._();

  @CustomDateTimeConverter()
  @JsonSerializable(explicitToJson: true)
  factory TTranslation({
    Map<String, String>? input,
    Map<String, Map<String, String>>? output,
    Map<String, Map<String, String>>? manual,

    //! Timestamp
    // DateTime? createdAt,
    // DateTime? updatedAt,
  }) = _TTranslation;

  factory TTranslation.fromJson(Map<String, dynamic> json) => _$TTranslationFromJson(json);

  bool get isNotValid => !isValid();
}
