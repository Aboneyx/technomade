// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_dto.freezed.dart';
part 'place_dto.g.dart';

@freezed
class PlaceDTO with _$PlaceDTO {
  const factory PlaceDTO({
    required int place,
    String? placeState,
  }) = _PlaceDTO;

  factory PlaceDTO.fromJson(Map<String, dynamic> json) => _$PlaceDTOFromJson(json);
}
