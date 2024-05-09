import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:technomade/src/core/enum/environment.dart';
import 'package:technomade/src/core/network/network_helper.dart';
import 'package:technomade/src/core/utils/error_util.dart';
import 'package:technomade/src/feature/main/model/route_dto.dart';
import 'package:technomade/src/feature/main/model/station_dto.dart';

abstract class IMainRemoteDS {
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

class MainRemoteDSImpl with NetworkHelper implements IMainRemoteDS {
  final Dio dio;

  MainRemoteDSImpl(this.dio);

  @override
  Future<Either<String, List<RouteDTO>>> getDriversMyRoute() async {
    try {
      final dioResponse = await dio.get(
        BackendEndpointCollection.DRIVER_ROUTES,
      );

      final listReponse = dioResponse.data as List;

      final List<RouteDTO> routes = listReponse.map((e) => RouteDTO.fromJson(e as Map<String, dynamic>)).toList();

      return Right(routes);
    } on DioException catch (e, stackTrace) {
      final parseError = pasreDioException(e);

      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: '${BackendEndpointCollection.LOGIN} => $parseError',
      );

      return Left(parseError);
    } on Object catch (e, stackTrace) {
      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: 'Object error => $e',
      );

      return Left('Object Error: $e');
    }
  }

  @override
  Future<Either<String, List<StationDTO>>> getStationList() async {
    try {
      final dioResponse = await dio.get(
        BackendEndpointCollection.STATION_LIST,
      );

      final listReponse = dioResponse.data as List;

      final List<StationDTO> stations = listReponse.map((e) => StationDTO.fromJson(e as Map<String, dynamic>)).toList();

      return Right(stations);
    } on DioException catch (e, stackTrace) {
      final parseError = pasreDioException(e);

      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: '${BackendEndpointCollection.LOGIN} => $parseError',
      );

      return Left(parseError);
    } on Object catch (e, stackTrace) {
      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: 'Object error => $e',
      );

      return Left('Object Error: $e');
    }
  }

  @override
  Future<Either<String, RouteDTO>> getDriverRouteById({
    required int routeId,
  }) async {
    try {
      final dioResponse = await dio.get(
        BackendEndpointCollection.DRIVER_ROUTES,
        queryParameters: {
          'routeId': routeId,
        },
      );

      final mapResponse = dioResponse.data as Map<String, dynamic>;

      return Right(RouteDTO.fromJson(mapResponse));
    } on DioException catch (e, stackTrace) {
      final parseError = pasreDioException(e);

      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: '${BackendEndpointCollection.LOGIN} => $parseError',
      );

      return Left(parseError);
    } on Object catch (e, stackTrace) {
      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: 'Object error => $e',
      );

      return Left('Object Error: $e');
    }
  }

  @override
  Future<Either<String, List<RouteDTO>>> searchPassengerRoute({
    required String from,
    required String to,
    String? date,
  }) async {
    try {
      final dioResponse = await dio.get(
        BackendEndpointCollection.PASSENGER_SEARCH,
        queryParameters: {
          'startStop': from,
          'finishStop': to,
          if (date != null) 'date': date,
        },
      );

      final listReponse = dioResponse.data as List;

      final List<RouteDTO> routes = listReponse.map((e) => RouteDTO.fromJson(e as Map<String, dynamic>)).toList();

      return Right(routes);
    } on DioException catch (e, stackTrace) {
      final parseError = pasreDioException(e);

      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: '${BackendEndpointCollection.LOGIN} => $parseError',
      );

      return Left(parseError);
    } on Object catch (e, stackTrace) {
      ErrorUtil.logError(
        e,
        stackTrace: stackTrace,
        hint: 'Object error => $e',
      );

      return Left('Object Error: $e');
    }
  }
}
