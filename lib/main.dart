import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/widget/bloc_observer.dart';
import 'package:technomade/src/feature/app/presentation/app_router_builder.dart';
import 'package:technomade/src/feature/app/presentation/global_scope.dart';

Future<void> main() async {
  // ignore: unused_local_variable
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await initLocator();

  /// Все ошибки BLoC'ов перенаправляются в Observer
  Bloc.observer = AppBlocObserver();

  /// Добавляется чтобы избежать несколько одновременных ивентов
  Bloc.transformer = bloc_concurrency.sequential<Object?>();

  runApp(const MyApp());
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
