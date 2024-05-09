import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:technomade/src/feature/app/bloc/app_bloc.dart';

class GlobalScope extends StatelessWidget {
  final Widget child;

  const GlobalScope({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppBloc(),
        ),
      ],
      child: child,
    );
  }
}
