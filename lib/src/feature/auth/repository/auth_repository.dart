import 'package:fpdart/fpdart.dart';
import 'package:technomade/src/feature/auth/datasource/auth_local_ds.dart';
import 'package:technomade/src/feature/auth/datasource/auth_remote_ds.dart';
import 'package:technomade/src/feature/auth/model/user_dto.dart';

abstract class IAuthRepository {
  ///
  /// Local
  ///
  UserDTO? getUserFromCache();

  Future<void> clearUserFromCache();

  ///
  /// Remote
  ///
  Future<Either<String, UserDTO>> login({
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

  Future<Either<String, UserDTO>> registrationConfirm({
    required String username,
    required String password,
    required String code,
  });
}

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthLocalDS _localDS;
  final IAuthRemoteDS _remoteDS;

  AuthRepositoryImpl({
    required IAuthLocalDS localDS,
    required IAuthRemoteDS remoteDS,
  })  : _localDS = localDS,
        _remoteDS = remoteDS;

  @override
  Future<Either<String, UserDTO>> login({
    required String username,
    required String password,
  }) async {
    final res = await _remoteDS.login(
      username: username.toLowerCase(),
      password: password,
    );

    return res.fold(
      (l) => Left(l),
      (r) async {
        await _localDS.saveUserToCache(user: r);

        return Right(r);
      },
    );
  }

  @override
  UserDTO? getUserFromCache() => _localDS.getUserFromCache();

  @override
  Future<void> clearUserFromCache() async => _localDS.removeUserFromCache();

  @override
  Future<Either<String, String>> registration({
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required String role,
  }) async =>
      _remoteDS.registration(
        firstName: firstName,
        lastName: lastName,
        username: username.toLowerCase(),
        password: password,
        role: role,
      );

  @override
  Future<Either<String, UserDTO>> registrationConfirm({
    required String username,
    required String password,
    required String code,
  }) async {
    final res = await _remoteDS.registrationConfirm(
      username: username.toLowerCase(),
      password: password,
      code: code,
    );

    return res.fold(
      (l) => Left(l),
      (r) async {
        await _localDS.saveUserToCache(user: r);

        return Right(r);
      },
    );
  }
}
