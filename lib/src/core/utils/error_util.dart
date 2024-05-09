// ignore_for_file: long-parameter-list,avoid-ignoring-return-values
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:technomade/src/core/services/locator_service.dart';

@sealed
class ErrorUtil {
  ErrorUtil._();

  static void logError(
    Object exception, {
    StackTrace? stackTrace,
    String? hint,
  }) {
    try {
      /// Не логируем ошибки в режиме дебага
      if (kDebugMode) {
        return;
      }
      if (exception is String) {
        return logMessage(
          exception,
          stackTrace: stackTrace,
          hint: hint,
          warning: true,
        );
      }
      DI<Talker>().error(exception, exception, stackTrace ?? StackTrace.current);
    } on Object catch (error, stackTrace) {
      DI<Talker>().error('Произошло исключение "$error" в ErrorUtil.logError', error, stackTrace);
    }
  }

  static void logMessage(
    String message, {
    StackTrace? stackTrace,
    String? hint,
    bool warning = false,
    List<String>? params,
  }) {
    try {
      DI<Talker>().error(message, message, stackTrace);
    } on Object catch (error, stackTrace) {
      DI<Talker>().error('Произошло исключение "$error" в ErrorUtil.logMessage', error, stackTrace);
    }
  }
}
