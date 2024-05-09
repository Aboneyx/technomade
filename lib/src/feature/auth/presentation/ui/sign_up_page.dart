import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/core/utils/validator_util.dart';
import 'package:technomade/src/feature/app/widgets/custom_overlay_widget.dart';
import 'package:technomade/src/feature/app/widgets/scroll_wrapper.dart';
import 'package:technomade/src/feature/auth/bloc/registration_cubit.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_text_field.dart';

@RoutePage()
class SignUpPage extends StatefulWidget implements AutoRouteWrapper {
  final bool isDriver;
  const SignUpPage({super.key, required this.isDriver});

  @override
  State<SignUpPage> createState() => _SignUpPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationCubit(repository: DI()),
      child: this,
    );
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late bool isDriver = widget.isDriver;

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Colors.black.withOpacity(0.5),
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) => const CustomOverlayWidget(),
      child: BlocConsumer<RegistrationCubit, RegistrationState>(
        listener: (context, state) {
          state.maybeWhen(
            loadingState: () {
              context.loaderOverlay.show();
            },
            errorState: (message) {
              context.loaderOverlay.hide();
              SnackBarUtil.showErrorTopShortToast(context, message);
            },
            loadedState: (token) {
              context.loaderOverlay.hide();
              SnackBarUtil.showTopShortToast(context, message: token);
              context.router.push(ConfirmationRoute(username: usernameController.text));
            },
            orElse: () {
              context.loaderOverlay.hide();
            },
          );
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: ScrollWrapper(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColors.grey,
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 31),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            const Text(
                              'Registration',
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.mainColor),
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              hintText: 'Username',
                              controller: usernameController,
                              validator: (value) => ValidatorUtil.defaultValidator(context, value),
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              hintText: 'First Name',
                              controller: firstNameController,
                              validator: (value) => ValidatorUtil.defaultValidator(context, value),
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              hintText: 'Last Name',
                              controller: lastNameController,
                              validator: (value) => ValidatorUtil.defaultValidator(context, value),
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              hintText: 'Password must be 6 characters',
                              obscureText: true,
                              controller: passwordController,
                              validator: (value) => ValidatorUtil.passwordValidator(context, value),
                            ),
                            const SizedBox(height: 8),
                            CustomTextField(
                              hintText: 'Password again',
                              obscureText: true,
                              controller: passwordConfirmController,
                              validator: (value) => ValidatorUtil.passwordValidator(
                                context,
                                value,
                                repeatPassword: passwordConfirmController.text,
                              ),
                            ),
                            const SizedBox(height: 8),
                            SwitchListTile(
                              value: isDriver,
                              title: Text(
                                isDriver ? "I am the driver" : "I'm a passenger",
                              ),
                              onChanged: (value) {
                                setState(() {
                                  isDriver = !isDriver;
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            CustomButton(
                              text: 'Register',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<RegistrationCubit>(context).registration(
                                    username: usernameController.text,
                                    password: passwordController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    role: isDriver ? 'DRIVER' : 'PASSENGER',
                                  );
                                }
                              },
                            ),
                          ],
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
