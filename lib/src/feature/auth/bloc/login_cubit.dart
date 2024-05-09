import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/auth/model/user_dto.dart';
import 'package:technomade/src/feature/auth/repository/auth_repository.dart';

part 'login_cubit.freezed.dart';

class LoginCubit extends Cubit<LoginState> {
  final IAuthRepository _repository;

  LoginCubit({required IAuthRepository repository})
      : _repository = repository,
        super(const LoginState.initialState());

  Future<void> login({
    required String username,
    required String password,
  }) async {
    emit(const LoginState.loadingState());

    final result = await _repository.login(
      username: username,
      password: password,
    );

    result.fold(
      (l) {
        emit(LoginState.errorState(message: l));
      },
      (r) {
        emit(LoginState.loadedState(user: r));
      },
    );
  }
}

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initialState() = _InitialPage;

  const factory LoginState.loadingState() = _LoadingState;

  const factory LoginState.loadedState({required UserDTO user}) = _LoadedState;

  const factory LoginState.errorState({
    required String message,
  }) = _ErrorState;
}
