// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/main/model/station_dto.dart';

part 'route_station_dto.freezed.dart';
part 'route_station_dto.g.dart';

@freezed
class RouteStationDTO with _$RouteStationDTO {
  const factory RouteStationDTO({
    int? id,
    StationDTO? station,
    DateTime? arrivalTime,
    DateTime? departureTime,
    double? cost,
    String? state,
    int? orderInList,
  }) = _RouteStationDTO;

  factory RouteStationDTO.fromJson(Map<String, dynamic> json) => _$RouteStationDTOFromJson(json);
}
