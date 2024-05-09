// ignore_for_file: avoid_redundant_argument_values

// ignore: unused_import
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:technomade/src/core/enum/environment.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/feature/auth/datasource/auth_local_ds.dart';

class DioModule {
  final IAuthLocalDS _authLocalDS;

  // Dio dio = Dio(BaseOptions(baseUrl: SERVER_));
  Dio dio = Dio(
    BaseOptions(
      baseUrl: kBaseUrl,
      headers: {
        'accept': 'application/json',
        'Content-Language': 'ru', //default
      },
    ),
  );

  Dio get instance => dio;

  DioModule(this._authLocalDS) {
    dio.interceptors.addAll([
      _AuthDioInterceptor(_authLocalDS),
      // PrettyDioLogger(
      //   requestHeader: true,
      //   requestBody: true,
      //   responseBody: true,
      //   responseHeader: false,
      //   compact: false,
      // ),
      TalkerDioLogger(
        talker: DI<Talker>(),
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
          printResponseMessage: true,
        ),
      ),
    ]);
  }
}

class _AuthDioInterceptor extends Interceptor {
  // ignore: unused_field
  final IAuthLocalDS _authLocalDS;
  _AuthDioInterceptor(this._authLocalDS);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // final UserDTO? user = _authLocalDS.getUserFromCacheNull();
    // final String locale = _authLocalDS.getLocale();
    // if (user != null && user.token != null) {
    //   options.headers['Authorization'] = 'Bearer ${user.token}';
    // }
    // options.headers['Accept'] = "application/json";
    // options.headers['Content-Language'] = locale.replaceAll('kk', 'kz');
    super.onRequest(options, handler);
  }

  @override
  Future onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    return super.onError(err, handler);
  }
}
