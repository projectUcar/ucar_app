import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env{
  @EnviedField(varName: 'AUTH_BASE_URL', obfuscate: true)
  static final String authBaseUrl = _Env.authBaseUrl;

  @EnviedField(varName: 'LOG_IN_ENDPOINT', obfuscate: true)
  static final String logInEndpoint = _Env.logInEndpoint;

  @EnviedField(varName: 'SIGN_UP_ENDPOINT', obfuscate: true)
  static final String signUpEndpoint = _Env.signUpEndpoint;

  @EnviedField(varName: 'REFRESH_TOKEN_ENDPOINT', obfuscate: true)
  static final String refreshTokenEndpoint = _Env.refreshTokenEndpoint;

  @EnviedField(varName: 'PROFILE_ENDPOINT', obfuscate: true)
  static final String profileEndpoint = _Env.profileEndpoint;

  @EnviedField(varName: 'UPLOAD_IMAGE_ENDPOINT', obfuscate: true)
  static final String uploadImageEndpoint = _Env.uploadImageEndpoint;

  @EnviedField(varName: 'USER_BY_ID_ENDPOINT', obfuscate: true)
  static final String userByIdEndpoint = _Env.userByIdEndpoint;

  @EnviedField(varName: 'TRIPS_BASE_URL', obfuscate: true)
  static final String tripsBaseUrl = _Env.tripsBaseUrl;

  @EnviedField(varName: 'TRIPS_TO_U_ENDPOINT', obfuscate: true)
  static final String tripsToUEndpoint = _Env.tripsToUEndpoint;

  @EnviedField(varName: 'TRIPS_FROM_U_ENDPOINT', obfuscate: true)
  static final String tripsFromUEndpoint = _Env.tripsFromUEndpoint;

  @EnviedField(varName: 'REQUEST_SEAT_ENDPOINT', obfuscate: true)
  static final String requestSeatEndpoint = _Env.requestSeatEndpoint;

  @EnviedField(varName: 'VEHICLES_BASE_URL', obfuscate: true)
  static final String vehiclesBaseUrl = _Env.vehiclesBaseUrl;

  @EnviedField(varName: 'DRIVER_REQUEST_ENDPOINT', obfuscate: true)
  static final String driverRequestEndpoint = _Env.driverRequestEndpoint;

  @EnviedField(varName: 'NEW_VEHICLE_ENDPOINT', obfuscate: true)
  static final String newVehicleEndpoint = _Env.newVehicleEndpoint;

  @EnviedField(varName: 'MY_VEHICLES_ENDPOINT', obfuscate: true)
  static final String myVehiclesEndpoint = _Env.myVehiclesEndpoint;

  @EnviedField(varName: 'ORS_KEY', obfuscate: true)
  static final String orsKey = _Env.orsKey;
}