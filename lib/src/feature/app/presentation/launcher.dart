// ignore: unused_import
import 'dart:developer';

import 'package:auto_route/auto_route.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/app/bloc/app_bloc.dart';
import 'package:technomade/src/feature/app/presentation/base.dart';
import 'package:technomade/src/feature/app/widgets/custom_loading_widget.dart';
import 'package:technomade/src/feature/auth/presentation/ui/onboarding_page.dart';
import 'package:technomade/src/feature/main/presentation/main_presentation.dart';
import 'package:technomade/src/feature/main/presentation/ui/main_driver_page.dart';

// ignore: unused_element
const _tag = 'Launcher';

@RoutePage(name: 'LauncherRoute')
class Launcher extends StatefulWidget {
  final int? initialTabIndex;
  const Launcher({super.key, this.initialTabIndex});

  @override
  State<Launcher> createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> with WidgetsBindingObserver {
  @override
  void initState() {
    FToast().init(context);
    BlocProvider.of<AppBloc>(context).add(
      const AppEvent.checkAuth(
        // version: context.packageInfo.version,
        version: '1.0.0',
      ),
    );
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log('MyApp state = $state');
    if (state == AppLifecycleState.inactive) {
      // app transitioning to other state.
    } else if (state == AppLifecycleState.paused) {
      // app is on the background.
    } else if (state == AppLifecycleState.detached) {
      // flutter engine is running but detached from views
    } else if (state == AppLifecycleState.resumed) {
      // app is visible and running.
      // runApp(App()); // run your App class again
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {
        state.whenOrNull(
          inAppState: () {},
          errorState: (message) {
            SnackBarUtil.showErrorTopShortToast(context, 'AppBloc => $message');
          },
        );
      },
      builder: (context, state) {
        return state.maybeWhen(
          loadingState: () => const _Scaffold(
            child: CustomLoadingWidget(),
          ),
          inAppState: () => const Base(),
          orElse: () => const MainDriverPage(),
        );
      },
    ); // OnBoardingPage();
  }
}

class _Scaffold extends StatelessWidget {
  final Widget child;
  const _Scaffold({
    required this.child,
    // super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: child),
    );
  }
}
