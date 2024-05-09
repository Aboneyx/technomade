// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'stops_payload.freezed.dart';
part 'stops_payload.g.dart';

@freezed
class StopsPayload with _$StopsPayload {
  const factory StopsPayload({
    String? station,
    String? arrivalTime,
    String? departureTime,
    int? cost,
  }) = _StopsPayload;

  factory StopsPayload.fromJson(Map<String, dynamic> json) => _$StopsPayloadFromJson(json);
}

/*
    {
      "station": "Almaty",
      "arrivalTime": "",
      "departureTime": "2024-04-17T07:13:44.685Z",
      "cost": 4000
    },
*/
