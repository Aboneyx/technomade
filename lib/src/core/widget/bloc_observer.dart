import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:l/l.dart';

extension on StringBuffer {
  /// Writes the type of the object in debug mode to make logs **readable** and
  /// write the object's [toString] in release mode to make logs
  /// **informative**.
  void writeInfo(Object? object) {
    Type? type;

    // ignore: prefer_asserts_with_message
    assert(
      () {
        type = object.runtimeType;

        return true;
      }(),
    );

    write(type ?? object);
  }
}

class AppBlocObserver extends BlocObserver {
  void _log(void Function(StringBuffer buffer) assemble) {
    final buffer = StringBuffer('AppBlocObserver | ');

    assemble(buffer);

    // l.vvvvvv(buffer.toString());
  }

  // @override
  // void onChange(BlocBase bloc, Change change) {
  //   super.onChange(bloc, change);
  //   _log(
  //     (buffer) => buffer
  //       ..write('Onchange ')
  //       ..writeInfo(bloc),
  //   );
  // }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    _log(
      (buffer) => buffer
        ..write('Created ')
        ..writeInfo(bloc),
    );
  }

  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);
    if (event != null) {
      _log(
        (buffer) => buffer
          ..write('Event ')
          ..writeInfo(event)
          ..write(' in ')
          ..writeInfo(bloc),
      );
    }
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);

    final Object? event = transition.event;

    if (event != null) {
      _log(
        (buffer) => buffer
          ..write('Transition in ')
          ..writeInfo(bloc)
          ..write(' with ')
          ..writeInfo(event)
          ..write(': ')
          ..writeInfo(transition.currentState)
          ..write(' -> ')
          ..writeInfo(transition.nextState),
      );
    }
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);

    _log(
      (buffer) => buffer
        ..write('Error ')
        ..writeInfo(error)
        ..write(' in ')
        ..writeInfo(bloc),
    );

    // l.e(error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    _log(
      (buffer) => buffer
        ..write('Closed ')
        ..writeInfo(bloc),
    );
  }
}
