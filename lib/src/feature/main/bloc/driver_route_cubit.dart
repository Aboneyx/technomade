import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/presentation/main_presentation.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'driver_route_cubit.freezed.dart';

class DriverRouteCubit extends Cubit<DriverRouteState> {
  final IMainRepository _repository;

  DriverRouteCubit({required IMainRepository repository})
      : _repository = repository,
        super(const DriverRouteState.initialState());

  Future<void> getDriverRouteById({
    required int routeId,
  }) async {
    emit(const DriverRouteState.loadingState());

    final result = await _repository.getDriverRouteById(
      routeId: routeId,
    );

    result.fold(
      (l) {
        emit(DriverRouteState.errorState(message: l));
      },
      (r) {
        emit(DriverRouteState.loadedState(route: r));
      },
    );
  }
}

@freezed
class DriverRouteState with _$DriverRouteState {
  const factory DriverRouteState.initialState() = _InitialPage;

  const factory DriverRouteState.loadingState() = _LoadingState;

  const factory DriverRouteState.loadedState({
    required RouteDTO route,
  }) = _LoadedState;

  const factory DriverRouteState.errorState({
    required String message,
  }) = _ErrorState;
}
