import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:pinput/pinput.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/app/bloc/app_bloc.dart';
import 'package:technomade/src/feature/app/widgets/custom_overlay_widget.dart';
import 'package:technomade/src/feature/auth/bloc/confirmation_cubit.dart';

@RoutePage()
class ConfirmationPage extends StatefulWidget implements AutoRouteWrapper {
  final String username;
  final String password;

  const ConfirmationPage({
    super.key,
    required this.username,
    required this.password,
  });

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => ConfirmationCubit(repository: DI()),
      child: this,
    );
  }
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Colors.black.withOpacity(0.5),
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) => const CustomOverlayWidget(),
      child: BlocConsumer<ConfirmationCubit, ConfirmationState>(
        listener: (context, state) {
          state.maybeWhen(
            loadingState: () {
              context.loaderOverlay.show();
            },
            errorState: (message) {
              context.loaderOverlay.hide();
              SnackBarUtil.showErrorTopShortToast(context, message);
            },
            loadedState: (user) {
              context.loaderOverlay.hide();
              BlocProvider.of<AppBloc>(context).add(
                AppEvent.chageState(state: AppState.inAppState(user: user)),
              );
              context.router.popUntil((route) => route.settings.name == LauncherRoute.name);
            },
            orElse: () {
              context.loaderOverlay.hide();
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Confirmation code',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.mainColor),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'We’ve sent an SMS with an activation code to your username ${widget.username}',
                    style: const TextStyle(fontSize: 16, color: AppColors.mainColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: AppColors.grey),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Pinput(
                        autofocus: true,
                        separatorBuilder: (index) => const SizedBox(
                          width: 24,
                        ),
                        defaultPinTheme: const PinTheme(
                          width: 28,
                          height: 28,
                          textStyle: TextStyle(
                            fontSize: 22,
                            color: Color.fromRGBO(30, 60, 87, 1),
                          ),
                          decoration: BoxDecoration(),
                        ),
                        cursor: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 28,
                              height: 3,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(30, 60, 87, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                        preFilledWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 28,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ],
                        ),
                        onCompleted: (value) {
                          BlocProvider.of<ConfirmationCubit>(context).registrationConfirm(
                            username: widget.username,
                            password: widget.password,
                            code: value,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
