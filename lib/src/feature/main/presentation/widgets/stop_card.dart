import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:technomade/gen/assets.gen.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/main/model/payload/stops_payload.dart';

class StopCard extends StatelessWidget {
  final Function()? onDeleteTap;
  final StopsPayload? stopsPayload;
  const StopCard({super.key, this.onDeleteTap, this.stopsPayload});

  @override
  Widget build(BuildContext context) {
    if (stopsPayload != null) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.labelColorLightSecondary),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  stopsPayload!.station ?? 'no name',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                if (onDeleteTap != null)
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    // constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
                    onPressed: onDeleteTap,
                    icon: SvgPicture.asset(Assets.icons.deleteForeverOutline),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Arrive time: '
                        '${stopsPayload!.arrivalTime != null ? stopsPayload!.arrivalTime!.formatStopCardTime() : '-'}',
                      ),
                      Text(
                        'Departure time: '
                        '${stopsPayload!.departureTime != null ? stopsPayload!.departureTime!.formatStopCardTime() : '-'}',
                      ),
                    ],
                  ),
                ),
                if (stopsPayload!.cost != null) ...[
                  const SizedBox(width: 10),
                  Text(
                    stopsPayload!.cost.toString(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ],
            ),
          ],
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.labelColorLightSecondary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kaskelen',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                if (onDeleteTap != null)
                  IconButton(
                    padding: EdgeInsets.zero,
                    splashRadius: 20,
                    constraints: const BoxConstraints(maxHeight: 20, maxWidth: 20),
                    onPressed: onDeleteTap,
                    icon: SvgPicture.asset(Assets.icons.deleteForeverOutline),
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Arrive time : 12:30'),
                    Text('Departure time: 23:00'),
                  ],
                ),
                Text(
                  '1750',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime? {
  String formatStopCardTime() {
    if (this == null) {
      return '';
    }

    return '${DateFormat('dd.MM.yyyy').format(this!)} at ${DateFormat('HH:mm').format(this!)}';
  }
}
