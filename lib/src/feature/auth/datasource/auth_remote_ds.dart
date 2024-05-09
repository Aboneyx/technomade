import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:technomade/src/core/enum/environment.dart';
import 'package:technomade/src/core/network/network_helper.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/error_util.dart';
import 'package:technomade/src/feature/auth/model/user_dto.dart';

abstract class IAuthRemoteDS {
  Future<Either<String, UserDTO>> login({
    required String username,
    required String password,
  });

  @Deprecated('example api')
  Future<Either<String, String>> getBasicAuthInfo({
    required String username,
    required String password,
  });

  Future<Either<String, String>> registration({
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required String role,
  });

  Future<Either<String, String>> resendConfirmationCode({
    required String username,
  });
}

class AuthRemoteDSImpl with NetworkHelper implements IAuthRemoteDS {
  final Dio dio;

  AuthRemoteDSImpl(this.dio);

  @override
  Future<Either<String, UserDTO>> login({
    required String username,
    required String password,
  }) async {
    try {
      final String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';

      final dioResponse = await dio.get(
        '',
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),

        // BackendEndpointCollection.LOGIN,
        // // data: {
        // //   'username': username,
        // //   'password': password,
        // // },
        // // queryParameters: {
        // //   'username': username,
        // //   'password': password,
        // // },
      );

      final user = UserDTO.fromJson(dioResponse.data as Map<String, dynamic>);

      return Right(user.copyWith(basicAuth: basicAuth));
    } on DioException catch (e, stackTrace) {
      DI<Talker>().log(e.response);
      DI<Talker>().log(e.response?.headers);
      DI<Talker>().log(e.response?.redirects);
      final parseError = pasreDioException(e);

      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: '${BackendEndpointCollection.LOGIN} => $parseError',
      );

      return Left(parseError);
    } on Object catch (e, stackTrace) {
      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: 'Object error => $e',
      );

      return Left('Object Error: $e');
    }
  }

  @override
  Future<Either<String, String>> getBasicAuthInfo({
    required String username,
    required String password,
  }) async {
    try {
      final String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';

      final dioResponse = await dio.get(
        '',
        options: Options(
          headers: {
            'Authorization': basicAuth,
          },
        ),
      );

      return Right(dioResponse.data.toString());
    } on DioException catch (e, stackTrace) {
      DI<Talker>().log(e.response);
      DI<Talker>().log(e.response?.headers);
      DI<Talker>().log(e.response?.redirects);
      final parseError = pasreDioException(e);

      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: '${BackendEndpointCollection.LOGIN} => $parseError',
      );

      return Left(parseError);
    } on Object catch (e, stackTrace) {
      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: 'Object error => $e',
      );

      return Left('Object Error: $e');
    }
  }

  @override
  Future<Either<String, String>> registration({
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required String role,
  }) async {
    try {
      // final String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';

      final dioResponse = await dio.post(
        BackendEndpointCollection.REGISTRATION,
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "password": password,
          "username": username,
          "role": role,
        },
      );

      final responseAsMap = dioResponse.data as Map<String, dynamic>;

      final token = responseAsMap['token'] as String?;

      if (token != null) {
        return Right(token);
      } else {
        return const Left('Token is null');
      }
    } on DioException catch (e, stackTrace) {
      DI<Talker>().log(e.response);
      DI<Talker>().log(e.response?.headers);
      DI<Talker>().log(e.response?.redirects);
      final parseError = pasreDioException(e);

      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: '${BackendEndpointCollection.LOGIN} => $parseError',
      );

      return Left(parseError);
    } on Object catch (e, stackTrace) {
      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: 'Object error => $e',
      );

      return Left('Object Error: $e');
    }
  }

  @override
  Future<Either<String, String>> resendConfirmationCode({
    required String username,
  }) async {
    try {
      // final String basicAuth = 'Basic ${base64.encode(utf8.encode('$username:$password'))}';

      final dioResponse = await dio.post(
        BackendEndpointCollection.REGISTRATION_RESEND,
        data: {
          "username": username,
        },
      );

      final responseAsMap = dioResponse.data as Map<String, dynamic>;

      final token = responseAsMap['token'] as String?;

      if (token != null) {
        return Right(token);
      } else {
        return const Left('Token is null');
      }
    } on DioException catch (e, stackTrace) {
      final parseError = pasreDioException(e);

      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: '${BackendEndpointCollection.LOGIN} => $parseError',
      );

      return Left(parseError);
    } on Object catch (e, stackTrace) {
      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: 'Object error => $e',
      );

      return Left('Object Error: $e');
    }
  }
}
