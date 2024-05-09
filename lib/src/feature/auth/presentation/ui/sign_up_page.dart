import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_text_field.dart';

@RoutePage()
class SignUpPage extends StatefulWidget {
  final bool isDriver;
  const SignUpPage({super.key, required this.isDriver});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              child: Column(
                children: [
                  const Text(
                    'Registration',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, color: AppColors.mainColor),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomTextField(
                    hintText: 'Phone number',
                    controller: phoneController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'must be  8 characters',
                    obscureText: true,
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomTextField(
                    hintText: 'Password again',
                    obscureText: true,
                    controller: passwordConfirmController,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomButton(
                    text: 'Register',
                    onTap: () {
                      context.router.push(ConfirmationRoute(phone: phoneController.text));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
