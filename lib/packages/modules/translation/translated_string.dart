import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

class TString {
  final String input;
  final Map<String, String> output;
  final Map<String, String> manual;

  /// Default contructor
  const TString({
    this.input = '',
    this.output = const <String, String>{},
    this.manual = const <String, String>{},
  });

  /// Manual translation contructor
  const TString.t(String key, [manual = const <String, String>{}])
      : input = key,
        manual = manual,
        output = const <String, String>{};

  String get tr {
    var locale = Get.locale ?? Get.fallbackLocale ?? Get.deviceLocale;
    var lang = locale!.languageCode;
    var langAndcountry = '${lang}${Get.locale!.countryCode != null ? '_${Get.locale!.countryCode}' : ''}';

    return manual[langAndcountry] ?? manual[lang] ?? output[langAndcountry] ?? output[lang] ?? input;
  }

  String trans({count = 1, List<String> args = const [], Map<String, String> params = const {}}) {
    var transList = tr.split('|');
    var trans = count == 1 ? transList[0] : (transList.length == 1 ? transList[0] : transList[1]);

    // PLURAL
    trans = trans.replaceFirst(RegExp(r'%p'), count.toString());

    // ARGUMENTS
    if (args.isNotEmpty) {
      for (final arg in args) {
        trans = trans.replaceFirst(RegExp(r'%s'), arg.toString());
      }
    }

    // PARAMS
    if (params.isNotEmpty) {
      params.forEach((key, value) {
        trans = trans.replaceAll('@$key', value);
      });
    }

    return trans;
  }

  /// ENCODE - DECODE
  TString copyWith({
    String? input,
    Map<String, String>? output = const {},
    Map<String, String>? manual = const {},
  }) {
    return TString(
      input: input ?? this.input,
      output: output ?? this.output,
      manual: manual ?? this.manual,
    );
  }

  static TString fromJson(Map<String, dynamic> json) {
    return TString(
      input: json['input'] ?? '',
      output: json['output'] ?? {},
      manual: json['manual'] ?? {},
    );
  }

  Map<String, dynamic> toJson(TString object) {
    return {
      'input': object.input,
      'output': object.output,
      'manual': object.manual,
    };
  }

  // String trArgs({List<String> args = const [], Map<String, String> params = const {}}) {
  //   var trans = tr;

  //   if (params.isNotEmpty) {
  //     params.forEach((key, value) {
  //       trans = trans.replaceAll('@$key', value);
  //     });
  //   }

  //   if (args.isNotEmpty) {
  //     for (final arg in args) {
  //       trans = trans.replaceFirst(RegExp(r'%s'), arg.toString());
  //     }
  //   }
  //   return trans;
  // }

  // String trPlural(num i, [List<String> args = const [], Map<String, String> params = const {}]) {
  //   var trans = trArgs(args: args, params: {...params, 'count': i.toString()});
  //   var transList = trans.split('|');

  //   return i == 1 ? transList[0] : (transList.length == 1 ? transList[0] : transList[1]);
  // }

}

class TStringConverter implements JsonConverter<TString, Map<String, dynamic>> {
  const TStringConverter();

  @override
  TString fromJson(Map<String, dynamic> json) {
    return TString.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(TString object) {
    return object.toJson(object);
  }
}
