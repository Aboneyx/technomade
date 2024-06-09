import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/common/constants.dart';
import 'package:technomade/src/feature/main/model/route_dto.dart';
import 'package:timelines/timelines.dart';

class MainDriverRouteCard extends StatefulWidget {
  final bool showExpandablePart;
  final bool hasTimeline;
  final Function()? onTap;
  final RouteDTO? route;
  const MainDriverRouteCard({
    super.key,
    this.showExpandablePart = false,
    this.hasTimeline = true,
    this.onTap,
    this.route,
  });

  @override
  State<MainDriverRouteCard> createState() => _MainDriverRouteCardState();
}

class _MainDriverRouteCardState extends State<MainDriverRouteCard> {
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
                  if (widget.showExpandablePart && widget.hasTimeline)
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
              if (isExpanded && widget.showExpandablePart)
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
                          index == 0 || index == 2 ? IndicatorStyle.dot : IndicatorStyle.outlined,
                      oppositeContentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          '8:30',
                          style: (index == 0 || index == 2)
                              ? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                              : const TextStyle(),
                        ),
                      ),
                      contentsBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Almaty',
                          style: (index == 0 || index == 2)
                              ? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)
                              : const TextStyle(),
                        ),
                      ),
                      itemExtent: 40.0,
                      itemCount: 3,
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
            ],
          ),
        ),
      ),
    );
  }
}
