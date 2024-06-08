// ignore_for_file: constant_identifier_names

const String kBaseUrl = 'https://zaula.up.railway.app';

mixin BackendEndpointCollection {
  /// AUTH
  static const String LOGIN = '/login';
  static const String REGISTRATION = '/registration';
  static const String REGISTRATION_RESEND = '/registration/resend';
  static const String REGISTRATION_CONFIRM = '/registration/confirm';

  /// DRIVER
  static const String DRIVER_ROUTES = '/driver/route';
  static const String DRIVER_ROUTE_CREATE = '/driver/route/create';

  /// PASSENGER

  static const String PASSENGER_SEARCH = '/search';

  /// COMMON
  static const String STATION_LIST = '/common/station/list';
  static const String COST_CALCULATE = '/book/cost';
}
