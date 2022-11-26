abstract class TranslationParser {
  Map<String, dynamic> toJson();

  Map<String, dynamic> import(Map<String, dynamic> translationsMap, List<String> langList) {
    var initialMap_ = toJson();

    Map<String, String> inputs = Map<String, String>.from(translationsMap['input'] ?? {});
    Map<String, dynamic> outputs = Map<String, dynamic>.from(translationsMap['output'] ?? {});
    Map<String, dynamic> manuals = Map<String, dynamic>.from(translationsMap['manual'] ?? {});

    for (var inputEntry in inputs.entries) {
      if (initialMap_[inputEntry.key] != null) {
        String input = inputEntry.value;
        Map<String, String> output = {...initialMap_[inputEntry.key]['output']};
        Map<String, String> manual = {...initialMap_[inputEntry.key]['manual']};
        for (var lang in langList) {
          if (outputs[inputEntry.key]?[lang] != null) {
            output[lang] = outputs[inputEntry.key]![lang]!;
          }
          if (manuals[inputEntry.key]?[lang] != null) {
            manual[lang] = manuals[inputEntry.key]![lang]!;
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
        manuals[element.key] ??= <String, String>{};
        manuals[element.key]![manualEntry.key] = manualEntry.value;
      }
    }

    return {'input': inputs, 'manual': manuals};
  }

  // Map<String, dynamic> parse() {
  //   return this.import({...this.export()});
  // }
}
