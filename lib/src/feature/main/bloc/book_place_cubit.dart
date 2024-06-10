import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'book_place_cubit.freezed.dart';

class BookPlaceCubit extends Cubit<BookPlaceState> {
  final IMainRepository _repository;

  BookPlaceCubit({required IMainRepository repository})
      : _repository = repository,
        super(const BookPlaceState.initialState());

  Future<void> bookPlace({
    required int routeId,
    required int start,
    required int finish,
    required int place,
  }) async {
    emit(const BookPlaceState.loadingState());

    final result = await _repository.bookPlace(routeId: routeId, start: start, finish: finish, place: place);

    result.fold(
      (l) {
        emit(BookPlaceState.errorState(message: l));
      },
      (r) {
        emit(BookPlaceState.loadedState(message: r));
      },
    );
  }
}

@freezed
class BookPlaceState with _$BookPlaceState {
  const factory BookPlaceState.initialState() = _InitialPage;

  const factory BookPlaceState.loadingState() = _LoadingState;

  const factory BookPlaceState.loadedState({
    required String message,
  }) = _LoadedState;

  const factory BookPlaceState.errorState({
    required String message,
  }) = _ErrorState;
}
