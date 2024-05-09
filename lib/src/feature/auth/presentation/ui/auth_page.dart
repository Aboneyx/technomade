import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/core/utils/validator_util.dart';
import 'package:technomade/src/feature/app/bloc/app_bloc.dart';
import 'package:technomade/src/feature/app/widgets/custom_overlay_widget.dart';
import 'package:technomade/src/feature/auth/bloc/login_cubit.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_text_field.dart';

@RoutePage()
class AuthPage extends StatefulWidget implements AutoRouteWrapper {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(repository: DI()),
      child: this,
    );
  }
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isDriver = false;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Colors.black.withOpacity(0.5),
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) => const CustomOverlayWidget(),
      child: BlocConsumer<LoginCubit, LoginState>(
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
            body: SafeArea(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColors.grey,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 31),
                      child: Column(
                        children: [
                          if (isDriver)
                            const SizedBox(
                              height: 30,
                            )
                          else
                            const Text(
                              'Sign in via passenger',
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.mainColor),
                            ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomTextField(
                            hintText: 'Username',
                            validator: (v) => ValidatorUtil.defaultValidator(context, v),
                            controller: usernameController,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomTextField(
                            hintText: 'Password',
                            obscureText: true,
                            validator: (v) => ValidatorUtil.defaultValidator(context, v),
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomButton(
                            text: 'Log in',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                BlocProvider.of<LoginCubit>(context).login(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          CustomButton(
                            text: 'Register',
                            onTap: () {
                              context.router.push(SignUpRoute(isDriver: isDriver));
                            },
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () {
                        isDriver = !isDriver;
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          isDriver ? 'are you a passenger?' : 'are you a driver?',
                          style: const TextStyle(fontSize: 15, color: AppColors.mainColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
