import 'dart:developer';

import 'package:bloc/bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_bloc.freezed.dart';

const _tag = 'AppBloc';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppState.loadingState()) {
    on<AppEvent>(
      (AppEvent event, Emitter<AppState> emit) async => event.map(
        checkAuth: (_CheckAuth event) async => _checkAuth(event, emit),
        refreshLocal: (_RefreshLocal event) async => _refreshLocal(event, emit),
        chageState: (_ChangeState event) async => _changeState(event, emit),
      ),
    );
  }

  Future<void> _checkAuth(
    _CheckAuth event,
    Emitter<AppState> emit,
  ) async {
    ///
    /// New code
    ///
    emit(const AppState.inAppState());
  }

  Future<void> _refreshLocal(
    _RefreshLocal event,
    Emitter<AppState> emit,
  ) async {
    await state.maybeWhen(
      inAppState: () async {
        emit(const AppState.loadingState());
        await Future.delayed(const Duration(milliseconds: 100));
        emit(const AppState.inAppState());
      },
      orElse: () async {
        emit(const AppState.loadingState());
        await Future.delayed(const Duration(milliseconds: 100));
        emit(const AppState.notAuthorizedState());
      },
    );
  }

  // Future<void> _sendDeviceToken(
  //   _SendDeviceToken event,
  //   Emitter<AppState> emit,
  // ) async {
  //   final result = await _authRepository.sendDeviceToken();

  //   result.when(
  //     success: (data) {
  //       log('_sendDeviceToken left: $data', name: _tag);
  //     },
  //     failure: (error) {
  //       log('_sendDeviceToken righy: $error', name: _tag);
  //     },
  //   );
  // }

  Future<void> _changeState(
    _ChangeState event,
    Emitter<AppState> emit,
  ) async =>
      emit(event.state);

  @override
  void onTransition(Transition<AppEvent, AppState> transition) {
    log(transition.toString(), name: _tag);
    super.onTransition(transition);
  }

  // @override
  // void onChange(Change<AppState> change) {
  //   print(change);
  //   super.onChange(change);
  // }
}

///
///
/// Event class
///
///
@freezed
class AppEvent with _$AppEvent {
  const factory AppEvent.checkAuth({
    required String version,
  }) = _CheckAuth;

  const factory AppEvent.refreshLocal() = _RefreshLocal;

  const factory AppEvent.chageState({
    required AppState state,
  }) = _ChangeState;
}

///
///
/// State class
///
///
@freezed
class AppState with _$AppState {
  const factory AppState.loadingState() = _LoadingState;

  const factory AppState.notAuthorizedState() = _NotAuthorizedState;

  const factory AppState.inAppState() = _InAppState;

  const factory AppState.errorState({
    required String message,
  }) = _ErrorState;
}
