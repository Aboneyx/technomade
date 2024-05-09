import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/auth/repository/auth_repository.dart';

part 'registration_cubit.freezed.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final IAuthRepository _repository;

  RegistrationCubit({required IAuthRepository repository})
      : _repository = repository,
        super(const RegistrationState.initialState());

  Future<void> registration({
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required String role,
  }) async {
    emit(const RegistrationState.loadingState());

    final result = await _repository.registration(
      username: username,
      password: password,
      lastName: lastName,
      firstName: firstName,
      role: role,
    );

    result.fold(
      (l) {
        emit(RegistrationState.errorState(message: l));
      },
      (r) {
        emit(RegistrationState.loadedState(token: r));
      },
    );
  }
}

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState.initialState() = _InitialPage;

  const factory RegistrationState.loadingState() = _LoadingState;

  const factory RegistrationState.loadedState({
    required String token,
  }) = _LoadedState;

  const factory RegistrationState.errorState({
    required String message,
  }) = _ErrorState;
}
