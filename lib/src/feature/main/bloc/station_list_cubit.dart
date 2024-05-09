import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/model/station_dto.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'station_list_cubit.freezed.dart';

class StationListCubit extends Cubit<StationListState> {
  final IMainRepository _repository;

  StationListCubit({required IMainRepository repository})
      : _repository = repository,
        super(const StationListState.initialState());

  List<StationDTO> _stations = [];

  Future<void> getStationList() async {
    emit(const StationListState.loadingState());

    final result = await _repository.getStationList();

    result.fold(
      (l) {
        emit(StationListState.errorState(message: l));
      },
      (r) {
        _stations += r;
        emit(StationListState.loadedState(stations: _stations));
      },
    );
  }
}

@freezed
class StationListState with _$StationListState {
  const factory StationListState.initialState() = _InitialPage;

  const factory StationListState.loadingState() = _LoadingState;

  const factory StationListState.loadedState({
    required List<StationDTO> stations,
  }) = _LoadedState;

  const factory StationListState.errorState({
    required String message,
  }) = _ErrorState;
}
