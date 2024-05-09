import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/auth/repository/auth_repository.dart';

part 'station_list_cubit.freezed.dart';

class StationListCubit extends Cubit<StationListState> {
  final IAuthRepository _repository;

  StationListCubit({required IAuthRepository repository})
      : _repository = repository,
        super(const StationListState.initialState());

  Future<void> registration({
    required String firstName,
    required String lastName,
    required String username,
    required String password,
    required String role,
  }) async {
    emit(const StationListState.loadingState());

    final result = await _repository.registration(
      username: username,
      password: password,
      lastName: lastName,
      firstName: firstName,
      role: role,
    );

    result.fold(
      (l) {
        emit(StationListState.errorState(message: l));
      },
      (r) {
        emit(StationListState.loadedState(token: r));
      },
    );
  }
}

@freezed
class StationListState with _$StationListState {
  const factory StationListState.initialState() = _InitialPage;

  const factory StationListState.loadingState() = _LoadingState;

  const factory StationListState.loadedState({
    required String token,
  }) = _LoadedState;

  const factory StationListState.errorState({
    required String message,
  }) = _ErrorState;
}
