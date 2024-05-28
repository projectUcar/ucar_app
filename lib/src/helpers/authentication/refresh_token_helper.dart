import 'dart:convert';

import 'authentication_api.dart';
import '../../../env/env.dart';

class RefreshTokenHelper{
  final AuthenticationAPI _client = AuthenticationAPI();
  final String _endpoint;
  RefreshTokenHelper():_endpoint = Env.refreshTokenEndpoint;

  Future<String?> tokenRefresh(String token, String refreshToken) async {
    final response = await _client.tokenRefresh(_endpoint, token, refreshToken);
    if (response.statusCode != null && response.statusCode == 200) {
      final dataMap = jsonDecode(response.data!) as Map<String, dynamic>;
      return dataMap["token"];
    }
    return token;
  }
}