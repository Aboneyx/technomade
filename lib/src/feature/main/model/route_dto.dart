// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/auth/model/user_dto.dart';
import 'package:technomade/src/feature/main/model/route_station_dto.dart';

part 'route_dto.freezed.dart';
part 'route_dto.g.dart';

@freezed
class RouteDTO with _$RouteDTO {
  const factory RouteDTO({
    int? id,
    String? routeState,
    UserDTO? driver,
    String? description,
    List<RouteStationDTO>? routeStations,
  }) = _RouteDTO;

  factory RouteDTO.fromJson(Map<String, dynamic> json) => _$RouteDTOFromJson(json);
}

extension RouteStationExtension on RouteDTO {
  // RouteStationDTO? getFirst

  String getFirstAndStationNames() {
    if (routeStations != null && routeStations!.isNotEmpty) {
      final String first =
          routeStations!.first.station?.name != null ? '${routeStations!.first.station?.name!} - ' : '';
      final String last = routeStations!.last.station?.name != null ? '${routeStations!.last.station?.name!}' : '';

      return '$first$last';
    } else {
      return '';
    }
  }
}
