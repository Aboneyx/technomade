import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:technomade/src/core/resources/resources.dart';
import 'package:technomade/src/feature/main/model/route_station_dto.dart';

class BookStopCard extends StatelessWidget {
  final RouteStationDTO station;
  final bool isSelected;
  final Function()? onTap;
  const BookStopCard({super.key, required this.station, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: isSelected ? Colors.green : null,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isSelected ? Colors.green : AppColors.labelColorLightSecondary),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(8),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${station.station?.name}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 4,
                ),
                if (station.arrivalTime != null)
                  Text('Arrive time : ${DateFormat('dd.MM.yyyy - HH:mm').format(station.arrivalTime!)}'),
                if (station.departureTime != null)
                  Text('Departure time : ${DateFormat('dd.MM.yyyy - HH:mm').format(station.departureTime!)}'),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  (station.cost ?? 0).toStringAsFixed(0),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
