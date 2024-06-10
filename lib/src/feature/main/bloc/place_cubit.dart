import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/model/place_dto.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'place_cubit.freezed.dart';

class PlaceCubit extends Cubit<PlaceState> {
  final IMainRepository _repository;

  PlaceCubit({required IMainRepository repository})
      : _repository = repository,
        super(const PlaceState.initialState());

  Future<void> getPlaces({
    required int routeId,
    required int start,
    required int finish,
  }) async {
    emit(const PlaceState.loadingState());

    final result = await _repository.getPlaces(
      routeId: routeId,
      start: start,
      finish: finish,
    );

    result.fold(
      (l) {
        emit(PlaceState.errorState(message: l));
      },
      (r) {
        emit(PlaceState.loadedState(places: r));
      },
    );
  }
}

@freezed
class PlaceState with _$PlaceState {
  const factory PlaceState.initialState() = _InitialPage;

  const factory PlaceState.loadingState() = _LoadingState;

  const factory PlaceState.loadedState({
    required List<PlaceDTO> places,
  }) = _LoadedState;

  const factory PlaceState.errorState({
    required String message,
  }) = _ErrorState;
}
