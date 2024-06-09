import 'package:fpdart/fpdart.dart';
import 'package:technomade/src/feature/main/datasource/main_remote_ds.dart';
import 'package:technomade/src/feature/main/model/payload/stops_payload.dart';
import 'package:technomade/src/feature/main/model/route_dto.dart';
import 'package:technomade/src/feature/main/model/station_dto.dart';

abstract class IMainRepository {
  /// Driver API part
  Future<Either<String, List<RouteDTO>>> getDriversMyRoute();

  Future<Either<String, RouteDTO>> getDriverRouteById({
    required int routeId,
  });

  Future<Either<String, String>> createRoute({
    required String description,
    required List<StopsPayload> stops,
  });

  Future<Either<String, String>> checkTicket({
    required String ticketUuid,
    required int routeId,
  });

  /// Passenger API part
  Future<Either<String, List<RouteDTO>>> searchPassengerRoute({
    required String from,
    required String to,
    String? date,
  });

  /// Common API
  Future<Either<String, List<StationDTO>>> getStationList();

  Future<Either<String, double>> calculateCost({
    required int routeId,
    required String startStop,
    required String finishStop,
  });
}

class MainRepositoryImpl implements IMainRepository {
  final IMainRemoteDS _remoteDS;

  MainRepositoryImpl({
    required IMainRemoteDS remoteDS,
  }) : _remoteDS = remoteDS;

  @override
  Future<Either<String, RouteDTO>> getDriverRouteById({
    required int routeId,
  }) async =>
      _remoteDS.getDriverRouteById(
        routeId: routeId,
      );

  @override
  Future<Either<String, List<RouteDTO>>> getDriversMyRoute() async => _remoteDS.getDriversMyRoute();

  @override
  Future<Either<String, List<StationDTO>>> getStationList() async => _remoteDS.getStationList();

  @override
  Future<Either<String, List<RouteDTO>>> searchPassengerRoute({
    required String from,
    required String to,
    String? date,
  }) async =>
      _remoteDS.searchPassengerRoute(from: from, to: to, date: date);

  @override
  Future<Either<String, double>> calculateCost({
    required int routeId,
    required String startStop,
    required String finishStop,
  }) async =>
      _remoteDS.calculateCost(routeId: routeId, startStop: startStop, finishStop: finishStop);

  @override
  Future<Either<String, String>> createRoute({
    required String description,
    required List<StopsPayload> stops,
  }) async =>
      _remoteDS.createRoute(
        description: description,
        stops: stops,
      );

  @override
  Future<Either<String, String>> checkTicket({
    required String ticketUuid,
    required int routeId,
  }) async =>
      _remoteDS.checkTicket(
        ticketUuid: ticketUuid,
        routeId: routeId,
      );
}
