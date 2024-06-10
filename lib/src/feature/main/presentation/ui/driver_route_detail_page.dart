import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/extension/double_extension.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/main/model/route_dto.dart';
import 'package:technomade/src/feature/main/presentation/widgets/stop_card.dart';

@RoutePage()
class DriverRouteDetailPage extends StatefulWidget {
  final RouteDTO route;
  const DriverRouteDetailPage({super.key, required this.route});

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
        title: Text(
          widget.route.getFirstAndStationNames(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 8,
        centerTitle: false,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              sliver: SliverList.list(
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.route.description ?? '',
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Rate config',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            if (widget.route.routeStations != null)
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList.separated(
                  itemCount: widget.route.routeStations!.length,
                  itemBuilder: (context, index) {
                    final routeStation = widget.route.routeStations![index];

                    return Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.labelColorLightSecondary),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            routeStation.station?.name ?? 'no name',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Arrive time: '
                            '${routeStation.arrivalTime != null ? routeStation.arrivalTime!.formatStopCardTime() : '-'}',
                          ),
                          Text(
                            'Departure time: '
                            '${routeStation.departureTime != null ? routeStation.departureTime!.formatStopCardTime() : '-'}',
                          ),
                          if (routeStation.cost != null) ...[
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                routeStation.cost.thousandFormat(),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                ),
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(top: 8),
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                height: 40,
                padding: const EdgeInsets.symmetric(vertical: 8),
                bgColor: Colors.white,
                border: Border.all(color: AppColors.mainColor),
                text: 'Monitoring',
                textStyle: const TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.w600),
                onTap: () {
                  if (widget.route.id == null) {
                    SnackBarUtil.showErrorTopShortToast(context, 'Route Id is null!');
                    return;
                  }
                  context.router.push(
                    MonitoringDriverRoute(
                      route: widget.route,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomButton(
                height: 40,
                padding: const EdgeInsets.symmetric(vertical: 8),
                text: 'Scan',
                textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                onTap: () {
                  if (widget.route.id == null) {
                    SnackBarUtil.showErrorTopShortToast(context, 'Route Id is null!');
                    return;
                  }

                  context.router.push(
                    ScanTicketRoute(
                      routeId: widget.route.id!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
