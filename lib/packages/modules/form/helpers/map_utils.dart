void _copyValues<K, V>(Map<K, V> from, Map<K, V?>? to, bool recursive, bool acceptNull) {
  for (var key in from.keys) {
    if (from[key] is Map<K, V> && recursive) {
      if (!(to![key] is Map<K, V>)) {
        to[key] = <K, V>{} as V;
      }
      _copyValues(from[key] as Map, to[key] as Map?, recursive, acceptNull);
    } else {
      if (from[key] != null || acceptNull) to![key] = from[key];
    }
  }
}

/// Merges the values of the given maps together.
///
/// `recursive` is set to `true` by default. If set to `true`,
/// then nested maps will also be merged. Otherwise, nested maps
/// will overwrite others.
///
/// `acceptNull` is set to `false` by default. If set to `false`,
/// then if the value on a map is `null`, it will be ignored, and
/// that `null` will not be copied.
Map<K, V> mergeMap<K, V>(Iterable<Map<K, V>?> maps, {bool recursive = true, bool acceptNull = false}) {
  var result = <K, V>{};
  maps.forEach((Map<K, V>? map) {
    if (map != null) _copyValues(map, result, recursive, acceptNull);
  });
  return result;
}

/// Flatten a nested Map into a single level map
///
/// If no [delimiter] is specified, will separate depth levels by `.`.
///
/// If you don't want to flatten arrays (with 0, 1,... indexes),
/// use [safe] mode.
///
/// To avoid circular reference issues or huge calculations,
/// you can specify the [maxDepth] the function will traverse.
Map<String, dynamic> flatten(
  Map<String, dynamic> target, {
  String delimiter = '.',
  bool safe = false,
  int? maxDepth,
}) {
  final result = <String, dynamic>{};

  void step(
    Map<String, dynamic> obj, [
    String? previousKey,
    int currentDepth = 1,
  ]) {
    obj.forEach((key, value) {
      final newKey = previousKey != null ? '$previousKey$delimiter$key' : key;

      if (maxDepth != null && currentDepth >= maxDepth) {
        result[newKey] = value;
        return;
      }
      if (value is Map<String, dynamic>) {
        return step(value, newKey, currentDepth + 1);
      }
      if (value is List && !safe) {
        return step(
          _listToMap(value),
          newKey,
          currentDepth + 1,
        );
      }
      result[newKey] = value;
    });
  }

  step(target);

  return result;
}

Map<String, T> _listToMap<T>(List<T> list) => list.asMap().map((key, value) => MapEntry(key.toString(), value));
