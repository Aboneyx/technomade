import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:technomade/src/core/services/locator_service.dart';

mixin NetworkHelper {
  String pasreDioException(DioException dioException) {
    switch (dioException.response?.statusCode) {
      case HttpStatus.unauthorized:
        return 'Not authorized. Please log in again!';
      case HttpStatus.notFound:
        return 'The content you are looking for has not been found!';
      case HttpStatus.requestEntityTooLarge:
        return 'Request Entity Too Large';
      case HttpStatus.internalServerError:
        return 'Something is wrong with our servers, the problem will be solved soon!';
      default:
        try {
          final responseData = dioException.response?.data;
          if (responseData == null) {
            return 'Unknown error[1]: responseData is null';
          } else if (responseData is Map) {
            return ((dioException.response?.data as Map<String, dynamic>)['message'] as String?) ??
                'Unknown error[2]: responseData is null';
          } else {
            return 'Unknown error[3]: $responseData';
          }
        } catch (e) {
          DI<Talker>().error(e);
          if (kDebugMode) print(e);
          if (kDebugMode) print(dioException.response?.statusCode);
          if (kDebugMode) print(dioException.type.name);
          if (kDebugMode) print(dioException.response?.data);
          return dioException.response?.statusCode != null
              ? 'HTTP (${dioException.response?.statusCode}) ${dioException.type.name} -  ${dioException.response?.data} : $e'
              : 'NetworkException: ${dioException.type.name}';
          // rethrow;
        }
    }
  }
}
