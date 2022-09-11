abstract class TranslationParser {
  Map<String, dynamic> toJson();

  Map<String, dynamic> import(Map<String, dynamic> translationsMap) {
    var initialMap_ = toJson();

    Map<String, String> inputs = translationsMap['input'] ?? <String, String>{};
    Map<String, Map<String, String>> outputs = Map<String, Map<String, String>>.from(translationsMap['output'] ?? {});
    Map<String, Map<String, String>> manuals = Map<String, Map<String, String>>.from(translationsMap['manual'] ?? {});
    var langList = outputs.keys;

    for (var inputEntry in inputs.entries) {
      if (initialMap_[inputEntry.key] != null) {
        String input = inputEntry.value;
        Map<String, String> output = {...initialMap_[inputEntry.key]['output']};
        Map<String, String> manual = {...initialMap_[inputEntry.key]['manual']};
        for (var lang in langList) {
          if (outputs[lang]?[inputEntry.key] != null) {
            output[lang] = outputs[lang]![inputEntry.key]!;
          }
          if (manuals[lang]?[inputEntry.key] != null) {
            manual[lang] = manuals[lang]![inputEntry.key]!;
          }
        }
        initialMap_[inputEntry.key]['input'] = input;
        initialMap_[inputEntry.key]['output'] = output;
        initialMap_[inputEntry.key]['manual'] = manual;
      }
    }

    return initialMap_;
  }

  Map<String, Map<String, String>> translations() {
    var initialMap = toJson();

    var result = <String, Map<String, String>>{};

    for (var element in initialMap.entries) {
      Map<String, String> output = {...element.value['output']};
      Map<String, String> manual = {...element.value['manual']};

      for (var outputEntry in output.entries) {
        result[outputEntry.key] ??= <String, String>{};
        result[outputEntry.key]![element.key] = outputEntry.value;
      }
      for (var manualEntry in manual.entries) {
        result[manualEntry.key] ??= <String, String>{};
        result[manualEntry.key]![element.key] = manualEntry.value;
      }
    }

    return result;
  }

  Map<String, dynamic> export() {
    var initialMap = toJson();

    var inputs = <String, String>{};
    // var outputs = <String, Map<String, String>>{};
    var manuals = <String, Map<String, String>>{};

    for (var element in initialMap.entries) {
      String input = element.value['input'];
      // Map<String, String> output = {...element.value['output']};
      Map<String, String> manual = {...element.value['manual']};

      inputs[element.key] = input;

      // for (var outputEntry in output.entries) {
      //   outputs[outputEntry.key] ??= <String, String>{};
      //   outputs[outputEntry.key]![element.key] = outputEntry.value;
      // }

      for (var manualEntry in manual.entries) {
        manuals[manualEntry.key] ??= <String, String>{};
        manuals[manualEntry.key]![element.key] = manualEntry.value;
      }
    }

    return {'inputs': inputs, 'manuals': manuals};
  }
}
