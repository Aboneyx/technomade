import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'driver_route_change_cubit.freezed.dart';

class DriverRouteChangeCubit extends Cubit<DriverRouteChangeState> {
  final IMainRepository _repository;

  DriverRouteChangeCubit({required IMainRepository repository})
      : _repository = repository,
        super(const DriverRouteChangeState.initialState());

  Future<void> launchRoute({
    required int routeId,
  }) async {
    emit(const DriverRouteChangeState.loadingState());

    final result = await _repository.launchRoute(
      routeId: routeId,
    );

    result.fold(
      (l) {
        emit(DriverRouteChangeState.errorState(message: l));
      },
      (r) {
        emit(DriverRouteChangeState.loadedState(message: r));
      },
    );
  }

  Future<void> changeRouteState({
    required int routeId,
  }) async {
    emit(const DriverRouteChangeState.loadingState());

    final result = await _repository.changeRouteState(
      routeId: routeId,
    );

    result.fold(
      (l) {
        emit(DriverRouteChangeState.errorState(message: l));
      },
      (r) {
        emit(DriverRouteChangeState.loadedState(message: r));
      },
    );
  }
}

@freezed
class DriverRouteChangeState with _$DriverRouteChangeState {
  const factory DriverRouteChangeState.initialState() = _InitialPage;

  const factory DriverRouteChangeState.loadingState() = _LoadingState;

  const factory DriverRouteChangeState.loadedState({
    required String message,
  }) = _LoadedState;

  const factory DriverRouteChangeState.errorState({
    required String message,
  }) = _ErrorState;
}
