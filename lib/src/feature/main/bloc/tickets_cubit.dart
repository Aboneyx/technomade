import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/model/ticket_dto.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'tickets_cubit.freezed.dart';

class TicketsCubit extends Cubit<TicketsState> {
  final IMainRepository _repository;

  TicketsCubit({required IMainRepository repository})
      : _repository = repository,
        super(const TicketsState.initialState());

  List<TicketDTO> _stations = [];

  Future<void> getTickets({
    bool hasLoading = true,
  }) async {
    if (hasLoading) {
      emit(const TicketsState.loadingState());
    }

    final result = await _repository.getTickets();

    result.fold(
      (l) {
        emit(TicketsState.errorState(message: l));
      },
      (r) {
        _stations = r;
        emit(TicketsState.loadedState(tickets: _stations));
      },
    );
  }
}

@freezed
class TicketsState with _$TicketsState {
  const factory TicketsState.initialState() = _InitialPage;

  const factory TicketsState.loadingState() = _LoadingState;

  const factory TicketsState.loadedState({
    required List<TicketDTO> tickets,
  }) = _LoadedState;

  const factory TicketsState.errorState({
    required String message,
  }) = _ErrorState;
}
