import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/common/constants.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/core/router/app_router.dart';
import 'package:technomade/src/core/services/locator_service.dart';
import 'package:technomade/src/core/utils/snackbar_util.dart';
import 'package:technomade/src/feature/auth/presentation/widgets/custom_button.dart';
import 'package:technomade/src/feature/main/bloc/calculate_cost_cubit.dart';
import 'package:technomade/src/feature/main/model/route_dto.dart';
import 'package:technomade/src/feature/main/model/route_station_dto.dart';
import 'package:technomade/src/feature/main/presentation/widgets/book_stop_card.dart';
import 'package:technomade/src/feature/main/presentation/widgets/person_info_widget.dart';
import 'package:timelines/timelines.dart';

@RoutePage()
class SearchResultDetailPage extends StatefulWidget implements AutoRouteWrapper {
  final RouteDTO route;
  const SearchResultDetailPage({super.key, required this.route});

  @override
  State<SearchResultDetailPage> createState() => _SearchResultDetailPageState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculateCostCubit(repository: DI()),
      child: this,
    );
  }
}

class _SearchResultDetailPageState extends State<SearchResultDetailPage> {
  RouteStationDTO? startStation;
  RouteStationDTO? finishStation;
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
        title: Text(
          getRoutes((widget.route.routeStations ?? []).map((e) => e.station?.name ?? '').toList()),
          // 'Almaty - Turkestan',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        titleSpacing: 8,
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 152),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PersonInfoWidget(
                  driver: widget.route.driver,
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
                  height: 24,
                ),
                if (widget.route.description != null)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.mainColor),
                    ),
                    child: Text(widget.route.description!),
                  ),
              ],
            ),
            if (widget.route.routeStations != null && (widget.route.routeStations!).isNotEmpty) ...[
              const SizedBox(
                height: 16,
              ),
              const Text('Choose start and stop stations from full route below'),
              const SizedBox(
                height: 16,
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
                      return DotIndicator(
                        color: startStation == widget.route.routeStations![index] ||
                                finishStation == widget.route.routeStations![index]
                            ? Colors.green
                            : null,
                      );
                    },
                    connectorBuilder: (_, index, ___) => SolidLineConnector(
                      color: index == 0 ? const Color(0xff66c97f) : null,
                    ),
                    contentsBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8).copyWith(right: 0),
                      child: BookStopCard(
                        isSelected: startStation == widget.route.routeStations![index] ||
                            finishStation == widget.route.routeStations![index],
                        onTap: () {
                          if (startStation == widget.route.routeStations![index]) {
                            startStation = null;
                            setState(() {});
                            return;
                          }
                          if (finishStation == widget.route.routeStations![index]) {
                            finishStation = null;
                            setState(() {});
                            return;
                          }
                          if (startStation != null) {
                            finishStation = widget.route.routeStations![index];
                            if (widget.route.id != null) {
                              BlocProvider.of<CalculateCostCubit>(context).calculateCost(
                                routeId: widget.route.id!,
                                startStop: startStation!.station?.name ?? '',
                                finishStop: finishStation?.station?.name ?? '',
                              );
                            }
                          } else {
                            startStation = widget.route.routeStations![index];
                          }
                          setState(() {});
                        },
                        station: widget.route.routeStations![index],
                      ),
                    ),
                    // itemExtent: 116.0,
                    itemCount: widget.route.routeStations!.length,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
      bottomSheet: BlocConsumer<CalculateCostCubit, CalculateCostState>(
        listener: (context, state) {
          state.maybeWhen(
            errorState: (message) {
              SnackBarUtil.showErrorTopShortToast(context, message);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(
                thickness: 1,
                height: 0,
                color: Colors.black,
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      state.maybeWhen(
                        loadedState: (cost) => '${cost.toStringAsFixed(0)} ₸',
                        orElse: () => ' - ',
                      ),
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  height: 36,
                  text: 'Book',
                  onTap: startStation != null && finishStation != null
                      ? () {
                          state.whenOrNull(
                            loadedState: (cost) {
                              context.router.push(
                                BookSeatRoute(
                                  price: cost,
                                  route: widget.route,
                                  startStation: startStation,
                                  finishStation: finishStation,
                                ),
                              );
                            },
                          );
                        }
                      : null,
                  textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewPadding.bottom,
              ),
            ],
          );
        },
      ),
    );
  }
}
