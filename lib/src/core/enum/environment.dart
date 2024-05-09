// ignore_for_file: constant_identifier_names

const String kBaseUrl = 'https://zaula.up.railway.app';

mixin BackendEndpointCollection {
  static const String LOGIN = '/login';
  static const String REGISTRATION = '/registration';
  static const String REGISTRATION_RESEND = '/registration/resend';
  static const String REGISTRATION_CONFIRM = '/registration/confirm';
}
