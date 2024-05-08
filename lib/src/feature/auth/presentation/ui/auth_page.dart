import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_text_field.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isDriver = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  const CustomTextField(
                    hintText: 'Phone number',
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomTextField(
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const CustomButton(text: 'Log in'),
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
    );
  }
}
