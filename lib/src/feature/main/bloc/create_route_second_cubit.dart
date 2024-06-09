import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/model/payload/stops_payload.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'create_route_second_cubit.freezed.dart';

class CreateRouteSecondCubit extends Cubit<CreateRouteSecondState> {
  final IMainRepository _repository;

  CreateRouteSecondCubit({required IMainRepository repository})
      : _repository = repository,
        super(const CreateRouteSecondState.initialState());

  Future<void> createRoute({
    required String description,
    required List<StopsPayload> stops,
  }) async {
    emit(const CreateRouteSecondState.loadingState());

    final result = await _repository.createRoute(
      description: description,
      stops: stops,
    );

    result.fold(
      (l) {
        emit(CreateRouteSecondState.errorState(message: l));
      },
      (r) {
        emit(CreateRouteSecondState.loadedState(message: r));
      },
    );
  }
}

@freezed
class CreateRouteSecondState with _$CreateRouteSecondState {
  const factory CreateRouteSecondState.initialState() = _InitialPage;

  const factory CreateRouteSecondState.loadingState() = _LoadingState;

  const factory CreateRouteSecondState.loadedState({
    required String message,
  }) = _LoadedState;

  const factory CreateRouteSecondState.errorState({
    required String message,
  }) = _ErrorState;
}
