import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/main/bloc/calculate_cost_cubit.dart';
import 'package:technomade/src/feature/main/bloc/driver_route_cubit.dart';
import 'package:technomade/src/feature/main/presentation/main_presentation.dart';
import 'package:technomade/src/feature/main/presentation/widgets/main_route_card.dart';
import 'package:technomade/src/feature/main/presentation/widgets/person_info_widget.dart';

@RoutePage()
class PassengerTicketDetailPage extends StatefulWidget implements AutoRouteWrapper {
  final TicketDTO ticket;
  const PassengerTicketDetailPage({super.key, required this.ticket});

  @override
  State<PassengerTicketDetailPage> createState() => _PassengerTicketDetailPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DriverRouteCubit(repository: DI()),
        ),
        BlocProvider(
          create: (context) => CalculateCostCubit(repository: DI()),
        ),
      ],
      child: this,
    );
  }
}

class _PassengerTicketDetailPageState extends State<PassengerTicketDetailPage> {
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    if (widget.ticket.forRoute != null && widget.ticket.forRoute!.id != null) {
      BlocProvider.of<DriverRouteCubit>(context).getDriverRouteById(routeId: widget.ticket.forRoute!.id!);
      BlocProvider.of<CalculateCostCubit>(context).calculateCost(
        routeId: widget.ticket.forRoute!.id!,
        startStop: widget.ticket.fromStop?.station?.name ?? '',
        finishStop: widget.ticket.toStop?.station?.name ?? '',
      );
    }

    super.initState();
  }

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
          '${widget.ticket.fromStop?.station?.name} - ${widget.ticket.toStop?.station?.name}',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 8,
        centerTitle: false,
      ),
      body: BlocConsumer<DriverRouteCubit, DriverRouteState>(
        listener: (context, state) {
          state.maybeWhen(
            errorState: (message) {
              SnackBarUtil.showErrorTopShortToast(context, message);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: state.maybeWhen(
                    loadedState: (route) => SmartRefresher(
                      controller: refreshController,
                      scrollController: scrollController,
                      onRefresh: () {
                        if (widget.ticket.forRoute != null && widget.ticket.forRoute!.id != null) {
                          BlocProvider.of<DriverRouteCubit>(context)
                              .getDriverRouteById(routeId: widget.ticket.forRoute!.id!);
                          BlocProvider.of<CalculateCostCubit>(context).calculateCost(
                            routeId: widget.ticket.forRoute!.id!,
                            startStop: widget.ticket.fromStop?.station?.name ?? '',
                            finishStop: widget.ticket.toStop?.station?.name ?? '',
                          );
                        }

                        refreshController.refreshCompleted();
                      },
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          const SizedBox(
                            height: 24,
                          ),
                          PersonInfoWidget(
                            driver: route.driver,
                          ),
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
                            height: 8,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.mainColor),
                            ),
                            child: Text('${route.description}'),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Text(
                            'Full route',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          BlocConsumer<CalculateCostCubit, CalculateCostState>(
                            listener: (context, stateCost) {
                              stateCost.maybeWhen(
                                errorState: (message) {
                                  SnackBarUtil.showErrorTopShortToast(context, message);
                                },
                                orElse: () {},
                              );
                            },
                            builder: (context, stateCost) {
                              return MainRouteCard(
                                route: route,
                                fromStation: widget.ticket.fromStop,
                                toStation: widget.ticket.toStop,
                                ticketCost: stateCost.whenOrNull(
                                  loadedState: (cost) => cost,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      ),
                    ),
                    orElse: () => const Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16).copyWith(top: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          height: 40,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          bgColor: Colors.white,
                          border: Border.all(color: AppColors.mainColor),
                          text: 'Routes',
                          textStyle: const TextStyle(color: AppColors.mainColor, fontWeight: FontWeight.w600),
                          onTap: () {
                            state.whenOrNull(
                              loadedState: (route) {
                                context.router.push(
                                  MonitoringPassengerRoute(
                                    route: route,
                                    driverRouteCubit: BlocProvider.of<DriverRouteCubit>(context),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CustomButton(
                          height: 40,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          text: 'Show QR',
                          textStyle: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
                          onTap: () {
                            context.router.push(ShowQrRoute(ticket: widget.ticket));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
