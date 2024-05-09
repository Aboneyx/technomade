import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_bloc_logger/talker_bloc_logger_observer.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/feature/app/presentation/app_router_builder.dart';
import 'package:technomade/src/feature/app/presentation/global_scope.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      // ignore: unused_local_variable
      final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

      final talker = TalkerFlutter.init(
        settings: TalkerSettings(
          colors: {
            TalkerLogType.verbose: AnsiPen()..yellow(),
          },
        ),
      );
      DI.registerSingleton<Talker>(talker);
      await initLocator();

      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      /// Все ошибки BLoC'ов перенаправляются в Observer
      Bloc.observer = TalkerBlocObserver(
        talker: talker,
      );
      // Bloc.observer = AppBlocObserver();

      /// Добавляется чтобы избежать несколько одновременных ивентов
      Bloc.transformer = bloc_concurrency.sequential<Object?>();

      runApp(const MyApp());
    },
    (error, stack) {
      DI<Talker>().handle(error, stack, 'Uncaught app exception');
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppRouterBuilder(
      createRouter: (context) => AppRouter(),
      builder: (context, parser, routerDelegate) => GlobalScope(
        child: MaterialApp.router(
          routeInformationParser: parser,
          routerDelegate: routerDelegate,
          theme: AppTheme.light,
          themeMode: ThemeMode.light,
          builder: (context, child) => MediaQuery.withClampedTextScaling(
            minScaleFactor: 1,
            maxScaleFactor: 1,
            child: child!,
          ),
        ),
      ),
    );
  }
}
