import 'package:fpdart/fpdart.dart';
import 'package:technomade/src/feature/main/datasource/main_remote_ds.dart';
import 'package:technomade/src/feature/main/model/route_dto.dart';
import 'package:technomade/src/feature/main/model/station_dto.dart';

abstract class IMainRepository {
  /// Driver API part
  Future<Either<String, List<RouteDTO>>> getDriversMyRoute();

  Future<Either<String, RouteDTO>> getDriverRouteById({
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
}
