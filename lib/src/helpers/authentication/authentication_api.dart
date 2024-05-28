import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import '../../../env/env.dart';

class AuthenticationAPI {
  static final AuthenticationAPI _instance = AuthenticationAPI._internal();
  factory AuthenticationAPI() => _instance;
  AuthenticationAPI._internal();
  final _client = Dio(
    BaseOptions(
      baseUrl: Env.authBaseUrl,
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

  Future<Response<String>> tokenRefresh(String endpoint, String oldToken, String refreshToken) async{
    final response = await _client.get<String>(
      endpoint,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.userAgentHeader: 'dio',
          HttpHeaders.cookieHeader: refreshToken,
          HttpHeaders.authorizationHeader: 'Bearer $oldToken'
        },
      ),
    );
    return response;
  }

  Future<Response<String>> getRequestWithToken(String endpoint, String token) async{
    final response = await _client.get<String>(
      endpoint,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.userAgentHeader: 'dio',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      ),
    );
    return response;
  }

  Future<Response> getImage(String endpoint, String token) async{
    final response = await _client.get(
      endpoint,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.userAgentHeader: 'dio',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        responseType: ResponseType.bytes
      ),
    );
    return response;
  }

  Future<Response> postImage(String endpoint, String token, Uint8List bytes, String filename) async{
    final response = await _client.post(
      endpoint,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.userAgentHeader: 'dio',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      ),
      data: FormData.fromMap(
        {
          "photoUrl" : MultipartFile.fromBytes(bytes, filename: filename)
        }
      )
    );
    return response;
  }
}