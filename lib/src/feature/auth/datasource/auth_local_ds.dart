import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/feature/auth/model/user_dto.dart';

abstract class IAuthLocalDS {
  Future<void> saveUserToCache({
    required UserDTO user,
  });

  UserDTO? getUserFromCache();

  Future<void> removeUserFromCache();
}

// ignore: constant_identifier_names
const USER_FROM_CACHE = 'USER';

class AuthLocalDSImpl extends IAuthLocalDS {
  final SharedPreferences sharedPreferences;

  AuthLocalDSImpl({required this.sharedPreferences});

  @override
  UserDTO? getUserFromCache() {
    try {
      final str = sharedPreferences.getString(USER_FROM_CACHE);
      DI<Talker>().debug('#getUserFromCache str $str');

      if (str != null) {
        return UserDTO.fromJson(
          jsonDecode(str) as Map<String, dynamic>,
        );
      }

      return null;
    } catch (e) {
      DI<Talker>().error('#getUserFromCache $e');
      return null;
    }
  }

  @override
  Future<void> removeUserFromCache() async {
    try {
      final res = await sharedPreferences.remove(USER_FROM_CACHE);
      DI<Talker>().debug('#removeUserFromCache res $res');
    } catch (e) {
      DI<Talker>().error('#removeUserFromCache $e');
    }
  }

  @override
  Future<void> saveUserToCache({required UserDTO user}) async {
    try {
      final res = await sharedPreferences.setString(USER_FROM_CACHE, jsonEncode(user.toJson()));
      DI<Talker>().debug('#saveUserToCache res $res');
    } catch (e) {
      DI<Talker>().error('#saveUserToCache $e');
    }
  }
}
