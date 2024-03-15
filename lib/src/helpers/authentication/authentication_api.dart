import 'dart:io';

import 'package:dio/dio.dart';

class AuthenticationAPI {
  static final AuthenticationAPI _instance = AuthenticationAPI._internal();
  factory AuthenticationAPI() => _instance;
  AuthenticationAPI._internal();
  final _client = Dio(
    BaseOptions(
      baseUrl: 'https://ms-authentication-production.up.railway.app/api',
      connectTimeout: const Duration(seconds: 10),
      sendTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      validateStatus: (statusCode) => (statusCode == null || (statusCode >= 300 && statusCode < 400)) ? false : true,
      receiveDataWhenStatusError: true
    )
  );
  Future<Response<String>> postData(String endpoint, String data) async{
    final response = await _client.post<String>(
      endpoint,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.userAgentHeader: 'dio',
        },
      ),
      data: data,
    );
    return response;
  }
}