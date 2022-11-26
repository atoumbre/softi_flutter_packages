// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'translation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TTranslation _$TTranslationFromJson(Map<String, dynamic> json) {
  return _TTranslation.fromJson(json);
}

/// @nodoc
mixin _$TTranslation {
  Map<String, String>? get input => throw _privateConstructorUsedError;
  Map<String, Map<String, String>>? get output =>
      throw _privateConstructorUsedError;
  Map<String, Map<String, String>>? get manual =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TTranslationCopyWith<TTranslation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TTranslationCopyWith<$Res> {
  factory $TTranslationCopyWith(
          TTranslation value, $Res Function(TTranslation) then) =
      _$TTranslationCopyWithImpl<$Res>;
  $Res call(
      {Map<String, String>? input,
      Map<String, Map<String, String>>? output,
      Map<String, Map<String, String>>? manual});
}

/// @nodoc
class _$TTranslationCopyWithImpl<$Res> implements $TTranslationCopyWith<$Res> {
  _$TTranslationCopyWithImpl(this._value, this._then);

  final TTranslation _value;
  // ignore: unused_field
  final $Res Function(TTranslation) _then;

  @override
  $Res call({
    Object? input = freezed,
    Object? output = freezed,
    Object? manual = freezed,
  }) {
    return _then(_value.copyWith(
      input: input == freezed
          ? _value.input
          : input // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      output: output == freezed
          ? _value.output
          : output // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>?,
      manual: manual == freezed
          ? _value.manual
          : manual // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>?,
    ));
  }
}

/// @nodoc
abstract class _$$_TTranslationCopyWith<$Res>
    implements $TTranslationCopyWith<$Res> {
  factory _$$_TTranslationCopyWith(
          _$_TTranslation value, $Res Function(_$_TTranslation) then) =
      __$$_TTranslationCopyWithImpl<$Res>;
  @override
  $Res call(
      {Map<String, String>? input,
      Map<String, Map<String, String>>? output,
      Map<String, Map<String, String>>? manual});
}

/// @nodoc
class __$$_TTranslationCopyWithImpl<$Res>
    extends _$TTranslationCopyWithImpl<$Res>
    implements _$$_TTranslationCopyWith<$Res> {
  __$$_TTranslationCopyWithImpl(
      _$_TTranslation _value, $Res Function(_$_TTranslation) _then)
      : super(_value, (v) => _then(v as _$_TTranslation));

  @override
  _$_TTranslation get _value => super._value as _$_TTranslation;

  @override
  $Res call({
    Object? input = freezed,
    Object? output = freezed,
    Object? manual = freezed,
  }) {
    return _then(_$_TTranslation(
      input: input == freezed
          ? _value._input
          : input // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      output: output == freezed
          ? _value._output
          : output // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>?,
      manual: manual == freezed
          ? _value._manual
          : manual // ignore: cast_nullable_to_non_nullable
              as Map<String, Map<String, String>>?,
    ));
  }
}

/// @nodoc

@CustomDateTimeConverter()
@JsonSerializable(explicitToJson: true)
class _$_TTranslation extends _TTranslation {
  _$_TTranslation(
      {final Map<String, String>? input,
      final Map<String, Map<String, String>>? output,
      final Map<String, Map<String, String>>? manual})
      : _input = input,
        _output = output,
        _manual = manual,
        super._();

  factory _$_TTranslation.fromJson(Map<String, dynamic> json) =>
      _$$_TTranslationFromJson(json);

  final Map<String, String>? _input;
  @override
  Map<String, String>? get input {
    final value = _input;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, Map<String, String>>? _output;
  @override
  Map<String, Map<String, String>>? get output {
    final value = _output;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, Map<String, String>>? _manual;
  @override
  Map<String, Map<String, String>>? get manual {
    final value = _manual;
    if (value == null) return null;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'TTranslation(input: $input, output: $output, manual: $manual)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TTranslation &&
            const DeepCollectionEquality().equals(other._input, _input) &&
            const DeepCollectionEquality().equals(other._output, _output) &&
            const DeepCollectionEquality().equals(other._manual, _manual));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_input),
      const DeepCollectionEquality().hash(_output),
      const DeepCollectionEquality().hash(_manual));

  @JsonKey(ignore: true)
  @override
  _$$_TTranslationCopyWith<_$_TTranslation> get copyWith =>
      __$$_TTranslationCopyWithImpl<_$_TTranslation>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TTranslationToJson(
      this,
    );
  }
}

abstract class _TTranslation extends TTranslation {
  factory _TTranslation(
      {final Map<String, String>? input,
      final Map<String, Map<String, String>>? output,
      final Map<String, Map<String, String>>? manual}) = _$_TTranslation;
  _TTranslation._() : super._();

  factory _TTranslation.fromJson(Map<String, dynamic> json) =
      _$_TTranslation.fromJson;

  @override
  Map<String, String>? get input;
  @override
  Map<String, Map<String, String>>? get output;
  @override
  Map<String, Map<String, String>>? get manual;
  @override
  @JsonKey(ignore: true)
  _$$_TTranslationCopyWith<_$_TTranslation> get copyWith =>
      throw _privateConstructorUsedError;
}
