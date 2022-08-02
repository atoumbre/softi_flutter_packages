import 'package:softi_packages/packages/resource/models/query.dart';

// abstract class IFilter {
//   QueryParameters build();
// }

class _FilterBuilder {
  List<QueryFilter> _params = [];
  List<QuerySort> _orders = [];

  //+ Filters
  _FilterBuilder addFilter(QueryFilter queryFilter) {
    _params.add(queryFilter);
    return this;
  }

  //+ Order by
  _FilterBuilder addOrderBy(QuerySort queryOrder) {
    _orders.add(queryOrder);
    return this;
  }

  //+ Build query Params
  QueryParameters build() {
    return QueryParameters(sortList: _orders, filterList: _params);
  }

  //+ Build query Params
  void reset() {
    _orders = [];
    _params = [];
  }
}

// implements IFilter
class Filter with BaseFilterMixin {
  Filter([_FilterBuilder? filterBuilder]) : _filterBuilder = filterBuilder ?? _FilterBuilder();

  @override
  final _FilterBuilder _filterBuilder;
}

class FieldFilter with FieldFilterMixin {
  FieldFilter(String field, _FilterBuilder? filterBuilder)
      : _field = field,
        _filterBuilder = filterBuilder;

  @override
  final _FilterBuilder? _filterBuilder;

  @override
  final String _field;
}

// implements IFilter
class FieldFilterExtended with BaseFilterMixin, FieldFilterMixin implements Filter {
  FieldFilterExtended([String? field, _FilterBuilder? filterBuilder])
      : _filterBuilder = filterBuilder ?? _FilterBuilder(),
        _field = field;

  @override
  final _FilterBuilder _filterBuilder;

  @override
  final String? _field;
}

/// FILTERS MIXINS

mixin BaseFilterMixin {
  _FilterBuilder? _filterBuilder;

  FieldFilter $field(String field) => FieldFilter(field, _filterBuilder);

  FieldFilterExtended $orderBy(String field, {bool desc = false}) => $field(field).$sort(desc: desc);
  FieldFilterExtended $filter$eq(String field, value) => $field(field).$eq(value);
  FieldFilterExtended $filter$notEq(String field, value) => $field(field).$notEq(value);
  FieldFilterExtended $filter$gt(String field, value) => $field(field).$gt(value);
  FieldFilterExtended $filter$gte(String field, value) => $field(field).$gte(value);
  FieldFilterExtended $filter$lt(String field, value) => $field(field).$lt(value);
  FieldFilterExtended $filter$lte(String field, value) => $field(field).$lte(value);
  FieldFilterExtended $filter$in(String field, value) => $field(field).$in(value);
  FieldFilterExtended $filter$contains(String field, value) => $field(field).$contains(value);
  FieldFilterExtended $filter$containsAny(String field, value) => $field(field).$containsAny(value);

  QueryParameters build() => _filterBuilder!.build();
  void reset() => _filterBuilder!.reset();
}

mixin FieldFilterMixin {
  _FilterBuilder? _filterBuilder;
  String? _field;

  FieldFilterExtended $sort({bool desc = false}) {
    _filterBuilder!.addOrderBy(QuerySort(_field, desc: desc));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $in(List<dynamic> valueList) {
    _filterBuilder!.addFilter(QueryFilter(field: _field, condition: QueryOperator.isIn, value: valueList));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $eq(dynamic value) {
    _filterBuilder!.addFilter(QueryFilter(field: _field, condition: QueryOperator.equal, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $notEq(dynamic value) {
    _filterBuilder!.addFilter(QueryFilter(field: _field, condition: QueryOperator.notEqual, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $gte(dynamic value) {
    _filterBuilder!.addFilter(QueryFilter(field: _field, condition: QueryOperator.greaterThanOrEqualTo, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $gt(dynamic value) {
    _filterBuilder!.addFilter(QueryFilter(field: _field, condition: QueryOperator.greaterThan, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $lt(dynamic value) {
    _filterBuilder!.addFilter(QueryFilter(field: _field, condition: QueryOperator.lessThan, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $lte(dynamic value) {
    _filterBuilder!.addFilter(QueryFilter(field: _field, condition: QueryOperator.lessThanOrEqualTo, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $contains(value) {
    _filterBuilder!.addFilter(QueryFilter(field: _field, condition: QueryOperator.arrayContains, value: value));
    return FieldFilterExtended(_field, _filterBuilder);
  }

  FieldFilterExtended $containsAny(List<dynamic> valueList) {
    _filterBuilder!.addFilter(QueryFilter(field: _field, condition: QueryOperator.arrayContainsAny, value: valueList));
    return FieldFilterExtended(_field, _filterBuilder);
  }
}
