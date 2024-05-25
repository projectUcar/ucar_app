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

  @EnviedField(varName: 'TRIPS_BASE_URL', obfuscate: true)
  static final String tripsBaseUrl = _Env.tripsBaseUrl;

  @EnviedField(varName: 'TRIPS_TO_U_ENDPOINT', obfuscate: true)
  static final String tripsToUEndpoint = _Env.tripsToUEndpoint;

  @EnviedField(varName: 'TRIPS_FROM_U_ENDPOINT', obfuscate: true)
  static final String tripsFromUEndpoint = _Env.tripsFromUEndpoint;

  @EnviedField(varName: 'ORS_KEY', obfuscate: true)
  static final String orsKey = _Env.orsKey;
}