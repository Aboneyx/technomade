import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/extension/double_extension.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/app/widgets/custom_loading_widget.dart';
import 'package:technomade/src/feature/app/widgets/custom_overlay_widget.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/main/bloc/driver_route_change_cubit.dart';
import 'package:technomade/src/feature/main/bloc/driver_route_cubit.dart';
import 'package:technomade/src/feature/main/model/route_dto.dart';
import 'package:technomade/src/feature/main/presentation/widgets/stop_card.dart';
import 'package:timelines/timelines.dart';

@RoutePage()
class MonitoringDriverPage extends StatefulWidget implements AutoRouteWrapper {
  final RouteDTO route;
  const MonitoringDriverPage({super.key, required this.route});

  @override
  State<MonitoringDriverPage> createState() => _MonitoringDriverPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DriverRouteCubit(repository: DI()),
        ),
        BlocProvider(
          create: (context) => DriverRouteChangeCubit(
            repository: DI(),
          ),
        ),
      ],
      child: this,
    );
  }
}

class _MonitoringDriverPageState extends State<MonitoringDriverPage> {
  @override
  void initState() {
    if (widget.route.id != null) {
      BlocProvider.of<DriverRouteCubit>(context).getDriverRouteById(routeId: widget.route.id!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Colors.black.withOpacity(0.5),
      useDefaultLoading: false,
      overlayWidgetBuilder: (progress) => const CustomOverlayWidget(),
      child: BlocConsumer<DriverRouteCubit, DriverRouteState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
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
              child: CustomScrollView(
                slivers: [
                  SliverList.list(
                    children: [
                      const SizedBox(height: 16),
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
                      const SizedBox(height: 8),
                      state.maybeWhen(
                        loadedState: (route) {
                          if (route.routeStations == null) {
                            return const SizedBox(
                              height: 500,
                              child: Text('Route Stations not Found'),
                            );
                          }

                          final routeStations = route.routeStations!;

                          return Padding(
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
                                  final routeStation = routeStations[index];

                                  if (routeStation.state == 'STAY' || routeStation.state == 'stay') {
                                    return DotIndicator(
                                      color: AppColors.mainColor,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: SvgPicture.asset(Assets.icons.icBus),
                                      ),
                                    );
                                  } else if (routeStation.state == 'PASSED' || routeStation.state == 'PASSED') {
                                    return const DotIndicator(
                                      color: AppColors.mainColor,
                                    );
                                  } else {
                                    return const DotIndicator();
                                  }
                                },
                                connectorBuilder: (_, index, ___) {
                                  final routeStation = routeStations[index];

                                  final color = routeStation.state == 'PASSED' ||
                                          routeStation.state == 'PASSED' ||
                                          routeStation.state == 'STAY' ||
                                          routeStation.state == 'stay'
                                      ? AppColors.mainColor
                                      : null;

                                  return SolidLineConnector(
                                    color: color,
                                  );
                                },
                                contentsBuilder: (context, index) {
                                  final routeStation = routeStations[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8).copyWith(right: 0),
                                    child: Container(
                                      width: double.infinity,
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
                                    ),
                                  );
                                }, // itemExtent: 116.0,
                                itemCount: routeStations.length,
                              ),
                            ),
                          );
                        },
                        orElse: () => const SizedBox(
                          height: 500,
                          child: CustomLoadingWidget(),
                        ),
                      ),
                    ],
                  ),
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 70,
                    ),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: BlocListener<DriverRouteChangeCubit, DriverRouteChangeState>(
              listener: (context, driverState) {
                driverState.maybeWhen(
                  loadingState: () {
                    context.loaderOverlay.show();
                  },
                  errorState: (message) {
                    context.loaderOverlay.hide();
                    SnackBarUtil.showErrorTopShortToast(context, message);
                  },
                  loadedState: (message) {
                    context.loaderOverlay.hide();
                    SnackBarUtil.showTopShortToast(context, message: message);
                  },
                  orElse: () {
                    context.loaderOverlay.hide();
                  },
                );

                if (widget.route.id != null) {
                  BlocProvider.of<DriverRouteCubit>(context).getDriverRouteById(routeId: widget.route.id!);
                }
              },
              child: Container(
                width: double.infinity,
                height: 56,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: state.maybeWhen(
                  loadedState: (route) {
                    if (route.routeState == 'AVAILABLE') {
                      return CustomButton(
                        height: 40,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        text: 'Start',
                        textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                        onTap: () {
                          BlocProvider.of<DriverRouteChangeCubit>(context).launchRoute(routeId: widget.route.id!);
                        },
                      );
                    }

                    if (route.routeState == 'ACTIVE') {
                      return CustomButton(
                        height: 40,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        text: 'Next',
                        textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                        onTap: () {
                          BlocProvider.of<DriverRouteChangeCubit>(context).changeRouteState(routeId: widget.route.id!);
                        },
                      );
                    }

                    if (route.routeState == 'NON_ACTIVE') {
                      return const Center(child: Text('The route has been completed'));
                    }
                    return const Text('Something is wrong');
                  },
                  orElse: () => const SizedBox(
                    height: 40,
                    child: CustomLoadingWidget(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
