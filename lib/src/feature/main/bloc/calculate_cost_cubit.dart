import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'calculate_cost_cubit.freezed.dart';

class CalculateCostCubit extends Cubit<CalculateCostState> {
  final IMainRepository _repository;

  CalculateCostCubit({required IMainRepository repository})
      : _repository = repository,
        super(const CalculateCostState.initialState());

  Future<void> calculateCost({
    required int routeId,
    required String startStop,
    required String finishStop,
  }) async {
    emit(const CalculateCostState.loadingState());

    final result = await _repository.calculateCost(
      routeId: routeId,
      startStop: startStop,
      finishStop: finishStop,
    );

    result.fold(
      (l) {
        emit(CalculateCostState.errorState(message: l));
      },
      (r) {
        emit(CalculateCostState.loadedState(cost: r));
      },
    );
  }
}

@freezed
class CalculateCostState with _$CalculateCostState {
  const factory CalculateCostState.initialState() = _InitialPage;

  const factory CalculateCostState.loadingState() = _LoadingState;

  const factory CalculateCostState.loadedState({
    required num? cost,
  }) = _LoadedState;

  const factory CalculateCostState.errorState({
    required String message,
  }) = _ErrorState;
}
