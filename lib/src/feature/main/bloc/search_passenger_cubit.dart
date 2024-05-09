import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/model/route_dto.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'search_passenger_cubit.freezed.dart';

class SearchPassengerCubit extends Cubit<SearchPassengerState> {
  final IMainRepository _repository;

  SearchPassengerCubit({required IMainRepository repository})
      : _repository = repository,
        super(const SearchPassengerState.initialState());

  Future<void> searchPassenger({
    required String from,
    required String to,
    String? date,
  }) async {
    emit(const SearchPassengerState.loadingState());

    final result = await _repository.searchPassengerRoute(from: from, to: to, date: date);

    result.fold(
      (l) {
        emit(SearchPassengerState.errorState(message: l));
      },
      (r) {
        emit(SearchPassengerState.loadedState(routes: r));
      },
    );
  }
}

@freezed
class SearchPassengerState with _$SearchPassengerState {
  const factory SearchPassengerState.initialState() = _InitialPage;

  const factory SearchPassengerState.loadingState() = _LoadingState;

  const factory SearchPassengerState.loadedState({
    required List<RouteDTO> routes,
  }) = _LoadedState;

  const factory SearchPassengerState.errorState({
    required String message,
  }) = _ErrorState;
}
