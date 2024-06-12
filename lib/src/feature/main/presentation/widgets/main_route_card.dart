import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/common/constants.dart';
import 'package:technomade/src/core/extension/integer_extension.dart';
import 'package:technomade/src/feature/main/model/route_dto.dart';
import 'package:technomade/src/feature/main/model/route_station_dto.dart';
import 'package:timelines/timelines.dart';

class MainRouteCard extends StatefulWidget {
  final bool isPassenger;
  final bool hasTimeline;
  final Function()? onTap;
  final RouteDTO? route;
  final RouteStationDTO? fromStation;
  final RouteStationDTO? toStation;
  final num? ticketCost;
  const MainRouteCard({
    super.key,
    this.isPassenger = false,
    this.hasTimeline = true,
    this.onTap,
    this.route,
    this.fromStation,
    this.toStation,
    this.ticketCost,
  });

  @override
  State<MainRouteCard> createState() => _MainRouteCardState();
}

class _MainRouteCardState extends State<MainRouteCard> {
  bool isExpanded = false;
  DateTime? departureTime;
  DateTime? arrivalTime;

  @override
  void initState() {
    if (widget.route != null && widget.route!.routeStations != null && widget.route!.routeStations!.isNotEmpty) {
      departureTime = widget.route?.routeStations?.first.departureTime;
      arrivalTime = widget.route?.routeStations?.last.arrivalTime;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(width: 0.5)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.route != null &&
                      widget.route!.routeStations != null &&
                      widget.route!.routeStations!.isNotEmpty)
                    Expanded(
                      child: Text(
                        getRoutes(widget.route!.routeStations!.map((e) => e.station?.name ?? '').toList()),
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ),
                  if (!widget.isPassenger && widget.hasTimeline)
                    IconButton(
                      padding: EdgeInsets.zero,
                      splashRadius: 24,
                      constraints: const BoxConstraints(maxHeight: 24, maxWidth: 24),
                      onPressed: () {
                        isExpanded = !isExpanded;
                        setState(() {});
                      },
                      icon: RotatedBox(
                        quarterTurns: isExpanded ? 2 : 0,
                        child: SvgPicture.asset(
                          Assets.icons.chevronDown,
                          height: 24,
                          width: 24,
                        ),
                      ),
                    ),
                ],
              ),
              if (isExpanded && !widget.isPassenger && widget.route != null && widget.route!.routeStations != null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: FixedTimeline.tileBuilder(
                    theme: TimelineThemeData(
                      color: Colors.black,
                      // nodePosition: 0,
                    ),
                    builder: TimelineTileBuilder.connectedFromStyle(
                      firstConnectorStyle: ConnectorStyle.transparent,
                      lastConnectorStyle: ConnectorStyle.transparent,
                      connectorStyleBuilder: (context, index) {
                        return ConnectorStyle.solidLine;
                      },
                      indicatorStyleBuilder: (context, index) =>
                          widget.route!.routeStations![index].id == widget.fromStation?.id ||
                                  widget.route!.routeStations![index].id == widget.toStation?.id
                              ? IndicatorStyle.dot
                              : IndicatorStyle.outlined,
                      oppositeContentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          DateFormat('HH:mm')
                              .format(widget.route!.routeStations![index].departureTime ?? DateTime.now()),
                          style: (widget.route!.routeStations![index].id == widget.fromStation?.id ||
                                  widget.route!.routeStations![index].id == widget.toStation?.id)
                              ? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                              : const TextStyle(),
                        ),
                      ),
                      contentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.route!.routeStations![index].station?.name ?? '',
                          style: (widget.route!.routeStations![index].id == widget.fromStation?.id ||
                                  widget.route!.routeStations![index].id == widget.toStation?.id)
                              ? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                              : const TextStyle(),
                        ),
                      ),
                      itemExtent: 40.0,
                      itemCount: widget.route!.routeStations!.length,
                    ),
                  ),
                )
              else
                const SizedBox(
                  height: 8,
                ),
              if (departureTime != null && arrivalTime != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('HH:mm').format(departureTime!),
                        ),
                        Text(
                          DateFormat('dd MMMM').format(departureTime!),
                        ),
                      ],
                    ),
                    const Text('   -   '),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormat('HH:mm').format(arrivalTime!),
                        ),
                        Text(
                          DateFormat('dd MMMM').format(arrivalTime!),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Text('${arrivalTime!.difference(departureTime!).inHours} hours on the road'),
                  ],
                ),
              if (widget.ticketCost != null) ...[
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${widget.ticketCost!.toInt().thousandFormat()} ₸',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
