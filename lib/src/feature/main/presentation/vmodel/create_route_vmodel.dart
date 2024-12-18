import 'package:flutter/material.dart';
import 'package:technomade/src/feature/main/model/payload/stops_payload.dart';

class CreateRouteVmodel extends ChangeNotifier {
  List<StopsPayload> _stops = [];
  List<StopsPayload> get stops => _stops;
  set stops(List<StopsPayload> value) {
    _stops = value;
    notifyListeners();
  }

  bool get isEmptyState => _stops.isEmpty;

  void addStops(StopsPayload value) {
    _stops.add(value);
    notifyListeners();
  }

  void removeStops(StopsPayload value) {
    _stops.removeWhere((element) => element.station == value.station && value.station != null);

    if (_stops.isNotEmpty) {
      _stops.first = _stops.first.copyWith(
        cost: null,
        arrivalTime: null,
      );
    }
    notifyListeners();
  }

  String? _description;
  String? get description => _description;
  set description(String? value) {
    _description = value;
    notifyListeners();
  }

  void clearAll() {
    _stops = [];
    _description = null;
    notifyListeners();
  }

  bool checkingStops(String station) {
    for (int i = 0; i < _stops.length; i++) {
      if (_stops[i].station == station) {
        return false;
      }
    }

    return true;
  }
}
