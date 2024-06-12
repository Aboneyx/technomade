import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/main/model/route_station_dto.dart';
import 'package:technomade/src/feature/main/presentation/main_presentation.dart';
import 'package:technomade/src/feature/main/presentation/widgets/book_stop_card.dart';
import 'package:timelines/timelines.dart';

@RoutePage()
class MonitoringPassengerPage extends StatelessWidget implements AutoRouteWrapper {
  final RouteDTO route;
  final DriverRouteCubit driverRouteCubit;
  const MonitoringPassengerPage({
    super.key,
    required this.route,
    required this.driverRouteCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverRouteCubit, DriverRouteState>(
      builder: (context, state) {
        return state.maybeWhen(
          loadedState: (route) => __ScreenState(
            route: route,
          ),
          orElse: () => __ScreenState(
            route: route,
          ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider.value(
      value: driverRouteCubit,
      child: this,
    );
  }
}

class __ScreenState extends StatefulWidget {
  final RouteDTO route;

  const __ScreenState({required this.route});

  @override
  State<__ScreenState> createState() => ___ScreenStateState();
}

class ___ScreenStateState extends State<__ScreenState> {
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  int getCurrentStationIndex(List<RouteStationDTO> routeStations) {
    int index = 0;
    if (routeStations.first.state == 'NOTPASSED') {
      index = 0;
    } else {
      final RouteStationDTO? firstNotPassedStation =
          routeStations.firstWhereOrNull((element) => element.state == 'NOTPASSED');
      if (firstNotPassedStation != null) {
        index = routeStations.indexOf(firstNotPassedStation);
      }
    }

    return index;
  }

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
        child: SmartRefresher(
          controller: refreshController,
          scrollController: scrollController,
          onRefresh: () {
            if (widget.route.id != null) {
              BlocProvider.of<DriverRouteCubit>(context).getDriverRouteById(routeId: widget.route.id!);
            }

            refreshController.refreshCompleted();
          },
          child: ListView(
            children: [
              const SizedBox(height: 16),
              if (widget.route.routeState == 'NON_ACTIVE')
                const Center(
                  child: Text(
                    'The route has been completed',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                )
              else if ((widget.route.routeStations ?? []).lastWhereOrNull((element) => element.state == 'PASSED') !=
                  null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Now we've passed "
                    "${(widget.route.routeStations ?? []).lastWhereOrNull((element) => element.state == 'PASSED')?.station?.name},"
                    " we're going to the next station.",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              if (widget.route.routeStations != null)
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
                        final routeStation = widget.route.routeStations![index];
                        if (routeStation.state == 'STAY' || routeStation.state == 'stay') {
                          return DotIndicator(
                            color: AppColors.mainColor,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: SvgPicture.asset(Assets.icons.icBus),
                            ),
                          );
                        } else if (routeStation.state == 'PASSED' || routeStation.state == 'passed') {
                          return const DotIndicator(
                            color: AppColors.mainColor,
                          );
                        } else {
                          return const DotIndicator();
                        }
                      },
                      connectorBuilder: (_, index, ___) {
                        final routeStation = widget.route.routeStations![index];

                        final color = routeStation.state == 'PASSED' ||
                                routeStation.state == 'passed' ||
                                routeStation.state == 'STAY' ||
                                routeStation.state == 'stay'
                            ? AppColors.mainColor
                            : null;

                        return SolidLineConnector(
                          color: color,
                        );
                      },
                      contentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8).copyWith(right: 0),
                        child: BookStopCard(
                          station: widget.route.routeStations![index],
                        ),
                      ),
                      // itemExtent: 116.0,
                      itemCount: widget.route.routeStations!.length,
                    ),
                  ),
                ),
              // const Spacer(),
              // Padding(
              //   padding: const EdgeInsets.all(16.0).copyWith(top: 8),
              //   child: CustomButton(
              //     height: 34,
              //     padding: const EdgeInsets.symmetric(vertical: 8),
              //     text: 'Next',
              //     textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
              //     onTap: () {},
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
