import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/feature/app/bloc/app_bloc.dart';
import 'package:technomade/src/feature/auth/repository/auth_repository.dart';

class GlobalScope extends StatelessWidget {
  final Widget child;

  const GlobalScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(
            authRepository: DI<IAuthRepository>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
