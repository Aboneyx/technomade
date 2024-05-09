import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/main/presentation/widgets/main_route_card.dart';
import 'package:technomade/src/feature/main/presentation/widgets/person_info_widget.dart';

@RoutePage()
class PassengerTicketDetailPage extends StatefulWidget {
  const PassengerTicketDetailPage({super.key});

  @override
  State<PassengerTicketDetailPage> createState() => _PassengerTicketDetailPageState();
}

class _PassengerTicketDetailPageState extends State<PassengerTicketDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            padding: EdgeInsets.zero,
            // splashRadius: 24,
            // constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
            onPressed: () {
              context.router.maybePop();
            },
            icon: SvgPicture.asset(Assets.icons.arrowLeftDropCircleOutline),
          ),
        ),
        leadingWidth: 60,
        title: const Text(
          'Almaty - Shymkent',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 8,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              const PersonInfoWidget(),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Type',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.mainColor),
                ),
                child: const Text('First floor bus'),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Full rourte',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 12,
              ),
              const MainRouteCard(),
              const Spacer(),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16).copyWith(top: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        height: 34,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        bgColor: Colors.white,
                        border: Border.all(color: AppColors.mainColor),
                        text: 'Rotes',
                        textStyle: const TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.w600),
                        onTap: () {
                          context.router.push(const MonitoringPassengerRoute());
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: CustomButton(
                        height: 34,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        text: 'Show qr',
                        textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                        onTap: () {
                          context.router.push(const ShowQrRoute());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
