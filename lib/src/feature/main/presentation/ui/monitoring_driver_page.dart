import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/main/presentation/widgets/stop_card.dart';
import 'package:timelines/timelines.dart';

@RoutePage()
class MonitoringDriverPage extends StatefulWidget {
  const MonitoringDriverPage({super.key});

  @override
  State<MonitoringDriverPage> createState() => _MonitoringDriverPageState();
}

class _MonitoringDriverPageState extends State<MonitoringDriverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: IconButton(
            padding: EdgeInsets.zero,
            splashRadius: 24,
            constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
            onPressed: () {
              context.router.maybePop();
            },
            icon: SvgPicture.asset(Assets.icons.arrowLeftDropCircleOutline),
          ),
        ),
        leadingWidth: 48,
        title: const Text(
          'Back',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 8,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Routes',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FixedTimeline.tileBuilder(
                theme: TimelineThemeData(
                  nodePosition: 0,
                  color: const Color(0xff989898),
                  indicatorTheme: const IndicatorThemeData(
                    // position: 0,
                    size: 16.0,
                  ),
                  connectorTheme: const ConnectorThemeData(
                    thickness: 4,
                  ),
                ),
                builder: TimelineTileBuilder.connected(
                  connectionDirection: ConnectionDirection.before,
                  indicatorBuilder: (_, index) {
                    if (index == 0) {
                      return DotIndicator(
                        color: AppColors.mainColor,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(Assets.icons.icBus),
                        ),
                      );
                    } else {
                      return const DotIndicator();
                    }
                  },
                  connectorBuilder: (_, index, ___) => SolidLineConnector(
                    color: index == 0 ? const Color(0xff66c97f) : null,
                  ),
                  contentsBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8).copyWith(right: 0),
                    child: const StopCard(),
                  ),
                  itemExtent: 116.0,
                  itemCount: 3,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(top: 8),
              child: CustomButton(
                height: 34,
                padding: const EdgeInsets.symmetric(vertical: 8),
                text: 'Next',
                textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
