import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technomade/src/core/network/dio_module.dart';
import 'package:technomade/src/feature/auth/datasource/auth_local_ds.dart';
import 'package:technomade/src/feature/auth/datasource/auth_remote_ds.dart';

// ignore: non_constant_identifier_names
final DI = GetIt.instance;

Future<void> initLocator() async {
  /// Datasource
  DI.registerLazySingleton<IAuthLocalDS>(
    () => AuthLocalDSImpl(sharedPreferences: DI()),
  );
  DI.registerLazySingleton<IAuthRemoteDS>(
    () => AuthRemoteDSImpl(DI()),
  );

  /// External
  final sharedPreferences = await SharedPreferences.getInstance();
  DI.registerLazySingleton(() => sharedPreferences);
  DI.registerLazySingleton(() => DioModule(DI()));
}
