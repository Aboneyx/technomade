import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/feature/app/bloc/app_bloc.dart';

@RoutePage()
class ConfirmationPage extends StatefulWidget {
  final String phone;
  const ConfirmationPage({super.key, required this.phone});

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              height: 20,
            ),
            Text(
              'We’ve sent an SMS with an activation code to your phone ${widget.phone}',
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
                    // BlocProvider.of<AppBloc>(context).add(const AppEvent.chageState(state: AppState.inAppState()));
                    context.router.popUntil((route) => route.settings.name == LauncherRoute.name);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
