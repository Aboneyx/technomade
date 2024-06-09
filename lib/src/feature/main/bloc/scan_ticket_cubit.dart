import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/repository/main_repository.dart';

part 'scan_ticket_cubit.freezed.dart';

class ScanTicketCubit extends Cubit<ScanTicketState> {
  final IMainRepository _repository;

  ScanTicketCubit({required IMainRepository repository})
      : _repository = repository,
        super(const ScanTicketState.initialState());

  Future<void> checkTicket({
    required String ticketUuid,
    required int routeId,
  }) async {
    emit(const ScanTicketState.loadingState());

    final result = await _repository.checkTicket(
      ticketUuid: ticketUuid,
      routeId: routeId,
    );

    result.fold(
      (l) {
        emit(ScanTicketState.errorState(message: l));
      },
      (r) {
        emit(ScanTicketState.loadedState(message: r));
      },
    );
  }
}

@freezed
class ScanTicketState with _$ScanTicketState {
  const factory ScanTicketState.initialState() = _InitialPage;

  const factory ScanTicketState.loadingState() = _LoadingState;

  const factory ScanTicketState.loadedState({
    required String message,
  }) = _LoadedState;

  const factory ScanTicketState.errorState({
    required String message,
  }) = _ErrorState;
}
