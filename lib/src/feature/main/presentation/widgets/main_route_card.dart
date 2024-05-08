import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:timelines/timelines.dart';

class MainRouteCard extends StatefulWidget {
  const MainRouteCard({
    super.key,
  });

  @override
  State<MainRouteCard> createState() => _MainRouteCardState();
}

class _MainRouteCardState extends State<MainRouteCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(width: 0.5)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          isExpanded = !isExpanded;
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Almaty - Shymkent',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  RotatedBox(
                    quarterTurns: isExpanded ? 2 : 0,
                    child: SvgPicture.asset(Assets.icons.chevronDown),
                  ),
                ],
              ),
              if (isExpanded)
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
              const Row(
                children: [
                  Text('8:30-18:30'),
                  SizedBox(
                    width: 8,
                  ),
                  Text('10 hours on the road'),
                ],
              ),
              const Text('12 martch - 13 martch'),
              const SizedBox(
                height: 8,
              ),
              const Text(
                '10 000 ₸',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
