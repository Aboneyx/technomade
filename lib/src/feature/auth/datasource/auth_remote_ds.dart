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
      final FormData formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      final dioResponse = await dio.post(
        BackendEndpointCollection.LOGIN,
        data: {
          'username': username,
          'password': password,
        },
        // data: formData,
        queryParameters: {
          'username': username,
          'password': password,
        },
      );

      final user = UserDTO.fromJson(dioResponse.data as Map<String, dynamic>);

      return Right(user);
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
}
