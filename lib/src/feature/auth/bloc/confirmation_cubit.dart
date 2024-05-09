import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/auth/model/user_dto.dart';
import 'package:technomade/src/feature/auth/repository/auth_repository.dart';

part 'confirmation_cubit.freezed.dart';

class ConfirmationCubit extends Cubit<ConfirmationState> {
  final IAuthRepository _repository;

  ConfirmationCubit({required IAuthRepository repository})
      : _repository = repository,
        super(const ConfirmationState.initialState());

  Future<void> registrationConfirm({
    required String username,
    required String password,
    required String code,
  }) async {
    emit(const ConfirmationState.loadingState());

    final result = await _repository.registrationConfirm(
      username: username,
      password: password,
      code: code,
    );

    result.fold(
      (l) {
        emit(ConfirmationState.errorState(message: l));
      },
      (r) {
        emit(ConfirmationState.loadedState(user: r));
      },
    );
  }
}

@freezed
class ConfirmationState with _$ConfirmationState {
  const factory ConfirmationState.initialState() = _InitialPage;

  const factory ConfirmationState.loadingState() = _LoadingState;

  const factory ConfirmationState.loadedState({
    required UserDTO user,
  }) = _LoadedState;

  const factory ConfirmationState.errorState({
    required String message,
  }) = _ErrorState;
}
