// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:technomade/src/feature/auth/model/user_dto.dart';
import 'package:technomade/src/feature/main/model/route_station_dto.dart';
import 'package:technomade/src/feature/main/presentation/main_presentation.dart';

part 'ticket_dto.freezed.dart';
part 'ticket_dto.g.dart';

@freezed
class TicketDTO with _$TicketDTO {
  const factory TicketDTO({
    int? id,
    UserDTO? ticketOwner,
    int? place,
    String? uuid,
    String? ticketState,
    RouteDTO? forRoute,
    RouteStationDTO? fromStop,
    RouteStationDTO? toStop,
  }) = _TicketDTO;

  factory TicketDTO.fromJson(Map<String, dynamic> json) => _$TicketDTOFromJson(json);
}
