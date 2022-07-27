import 'dart:async';

import 'package:get/get_state_manager/get_state_manager.dart';

abstract class IBaseService extends GetxService {
  // @protected
  Future<T> failureCatcher<T>(Future<T> Function() task) async {
    try {
      var result = await task();
      return result;
    } catch (e) {
      var formatedFailer = errorHandler(e);
      if (formatedFailer != null) {
        throw formatedFailer;
      } else {
        rethrow;
      }
    }
  }

  ServiceFailure? errorHandler(dynamic error) {
    return null;
    // return ServiceFailure(
    //   service: runtimeType.toString(),
    //   code: '_SERVICE_EXCEPTION_',
    //   message: 'Unhandled service exeption',
    //   rawError: error,
    // );
  }

  Future<dynamic> init() async {}
  Future<dynamic> dispose() async {}
}

class ServiceFailure implements Exception {
  final String service;
  final String code;
  final String? message;
  final dynamic rawError;

  ServiceFailure({
    required this.service,
    required this.code,
    this.message,
    this.rawError,
  });
}
