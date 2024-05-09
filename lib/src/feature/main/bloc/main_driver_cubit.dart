import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/model/route_dto.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'main_driver_cubit.freezed.dart';

class MainDriverCubit extends Cubit<MainDriverState> {
  final IMainRepository _repository;

  MainDriverCubit({required IMainRepository repository})
      : _repository = repository,
        super(const MainDriverState.initialState());

  Future<void> getDriversMyRoute() async {
    emit(const MainDriverState.loadingState());

    final result = await _repository.getDriversMyRoute();

    result.fold(
      (l) {
        emit(MainDriverState.errorState(message: l));
      },
      (r) {
        emit(MainDriverState.loadedState(routes: r));
      },
    );
  }
}

@freezed
class MainDriverState with _$MainDriverState {
  const factory MainDriverState.initialState() = _InitialPage;

  const factory MainDriverState.loadingState() = _LoadingState;

  const factory MainDriverState.loadedState({
    required List<RouteDTO> routes,
  }) = _LoadedState;

  const factory MainDriverState.errorState({
    required String message,
  }) = _ErrorState;
}
