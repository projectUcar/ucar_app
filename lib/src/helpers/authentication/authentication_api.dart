import 'dart:io';

import 'package:dio/dio.dart';

class AuthenticationAPI {
  static final AuthenticationAPI _instance = AuthenticationAPI._internal();
  factory AuthenticationAPI() => _instance;
  AuthenticationAPI._internal();
  final _client = Dio(BaseOptions(
    baseUrl: 'https://ms-authentication-production.up.railway.app/api',
  ));
  Future<Response> postData(String endpoint, String data) async{
    final response = await _client.post(
      endpoint,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.userAgentHeader: 'dio',
          'api': '1.0.0',
        },
      ),
      data: data
    );
    return response;
  }
}