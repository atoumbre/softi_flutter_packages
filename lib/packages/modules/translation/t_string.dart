import 'package:get/get.dart';
import 'package:json_annotation/json_annotation.dart';

class TString {
  const TString({
    this.input = '',
    this.output = const {},
    this.manual = const {},
  });

  // const TString.i(String key)
  //     : input = key,
  //       manual = const {},
  //       output = const {};

  // final String key;
  final String input;
  final Map<String, String> output;
  final Map<String, String> manual;

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

  String get tr {
    // print('language');
    // print(Get.locale!.languageCode);
    // print('contains');
    // print(Get.translations.containsKey(Get.locale!.languageCode));
    // print(Get.translations.keys);
    // Returns the key if locale is null.

    // if (_fullLocaleAndKey) {
    //   return Get.translations["${Get.locale!.languageCode}_${Get.locale!.countryCode}"]![this]!;
    // }

    var locale = Get.locale ?? Get.fallbackLocale ?? Get.deviceLocale;

    var langAndcountry = "${locale!.languageCode}_${Get.locale!.countryCode}";
    var lang = locale.languageCode;

    return manual[langAndcountry] ?? output[langAndcountry] ?? manual[lang] ?? output[lang] ?? input;
  }

  String trArgs({List<String> args = const [], Map<String, String> params = const {}}) {
    var trans = tr;

    if (params.isNotEmpty) {
      params.forEach((key, value) {
        trans = trans.replaceAll('@$key', value);
      });
    }

    if (args.isNotEmpty) {
      for (final arg in args) {
        trans = trans.replaceFirst(RegExp(r'%s'), arg.toString());
      }
    }
    return trans;
  }

  String trPlural(num i, [List<String> args = const [], Map<String, String> params = const {}]) {
    var trans = trArgs(args: args, params: {...params, 'count': i.toString()});
    var transList = trans.split('|');

    return i == 1 ? transList[0] : (transList.length == 1 ? transList[0] : transList[1]);
  }
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
