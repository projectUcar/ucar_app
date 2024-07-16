import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../helpers/helpers.dart';
import '../models/auth_response.dart';
import '../storage/auth_client.dart';

mixin TokenValidation<T> on BlocBase<T>{
  Future<String?> verifyToken() async{
    final authclient = AuthClient();
    final accessToken = await authclient.accessToken;
    if (accessToken != null) {
      final expDate = JwtDecoder.getExpirationDate(accessToken);
      final currentDate = DateTime.now();
      if (expDate.difference(currentDate).inSeconds <= 250) {
        final refreshToken = await authclient.refreshToken;
        final newToken = await RefreshTokenHelper().tokenRefresh(accessToken, refreshToken!);
        if (newToken != null) {
          await authclient.saveAuth(AuthResponse.fromJWT(jwt: newToken, refreshToken: refreshToken, logged: true));
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