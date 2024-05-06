import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../helpers/authentication/refresh_token_helper.dart';
import '../models/auth_response.dart';
import '../storage/auth_client.dart';

mixin TokenValidation<T, U> on Bloc<T, U>{
  Future<String?> verifyToken() async{
    final authclient = AuthClient();
    final accessToken = await authclient.accessToken;
    if (accessToken != null) {
      final expDate = JwtDecoder.getExpirationDate(accessToken);
      final currentDate = DateTime.now();
      if (expDate.difference(currentDate).inSeconds <= 250) {
        final newToken = await RefreshTokenHelper().refreshToken(accessToken);
        if (newToken != null) {
          await authclient.saveAuth(AuthResponse.fromJWT(jwt: newToken, logged: true));
          debugPrint("$newToken | isExpired: ${JwtDecoder.isExpired(newToken)}");
          return newToken;
        }
      }
      debugPrint("$accessToken | isExpired: ${JwtDecoder.isExpired(accessToken)}");
      return accessToken;
    }
    return null;
  }
}