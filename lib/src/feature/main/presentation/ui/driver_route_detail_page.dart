import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/main/presentation/widgets/stop_card.dart';

@RoutePage()
class DriverRouteDetailPage extends StatefulWidget {
  const DriverRouteDetailPage({super.key});

  @override
  State<DriverRouteDetailPage> createState() => _DriverRouteDetailPageState();
}

class _DriverRouteDetailPageState extends State<DriverRouteDetailPage> {
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
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Rate config',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemBuilder: (context, index) => const StopCard(),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 8,
                ),
                itemCount: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(top: 8),
              child: Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 34,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      bgColor: Colors.white,
                      border: Border.all(color: AppColors.mainColor),
                      text: 'Monitoring',
                      textStyle: const TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.w600),
                      onTap: () {
                        context.router.push(const MonitoringDriverRoute());
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
                      text: 'Scan',
                      textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                      onTap: () {
                        context.router.push(const ScanTicketRoute());
                      },
                    ),
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
