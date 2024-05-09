// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'station_dto.freezed.dart';
part 'station_dto.g.dart';

@freezed
class StationDTO with _$StationDTO {
  const factory StationDTO({
    int? id,
    String? name,
  }) = _StationDTO;

  factory StationDTO.fromJson(Map<String, dynamic> json) => _$StationDTOFromJson(json);
}
