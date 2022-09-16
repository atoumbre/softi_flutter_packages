// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'translation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TTranslation _$$_TTranslationFromJson(Map<String, dynamic> json) =>
    _$_TTranslation(
      input: (json['input'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      output: (json['output'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
      ),
      manual: (json['manual'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
      ),
      createdAt: const CustomDateTimeConverter()
          .fromJson(json['createdAt'] as DateTime?),
      updatedAt: const CustomDateTimeConverter()
          .fromJson(json['updatedAt'] as DateTime?),
    )
      ..id = json['id'] as String?
      ..path = json['path'] as String?;

Map<String, dynamic> _$$_TTranslationToJson(_$_TTranslation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'path': instance.path,
      'input': instance.input,
      'output': instance.output,
      'manual': instance.manual,
      'createdAt': const CustomDateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const CustomDateTimeConverter().toJson(instance.updatedAt),
    };
