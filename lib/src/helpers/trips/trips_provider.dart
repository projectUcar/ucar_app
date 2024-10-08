import 'dart:io';
import 'package:dio/dio.dart';

import '../../../env/env.dart';

class TripsProvider {
  static final TripsProvider _instance = TripsProvider._internal();
  factory TripsProvider() => _instance;
  TripsProvider._internal();

  final _client = Dio(
    BaseOptions(
      baseUrl: Env.tripsBaseUrl,
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (statusCode) => (statusCode == null || (statusCode >= 300 && statusCode < 400)) ? false : true,
      receiveDataWhenStatusError: true
    )
  )..interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (response.statusCode == 204) {
          handler.resolve(Response(requestOptions: response.requestOptions, data: <dynamic>[]));
        }else{
          return handler.next(response);
        }
      },
    ),
  );
  
  Future<List<dynamic>?> getTrips(String endpoint, String token) async{
    final response = await _client.get<List<dynamic>>(
      endpoint,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.userAgentHeader: 'dio',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      ),
    );
    return response.data;
  }

  Future<Response<String>?> getTripById(String endpoint, String token) async{
    final response = await _client.get<String>(
      endpoint,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.userAgentHeader: 'dio',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
        sendTimeout: const Duration(seconds: 50),
        receiveTimeout: const Duration(seconds: 50)
      ),
    );
    return response;
  }

  Future<Response<String>?> postData(String endpoint, String token, String data) async{
    final response = await _client.post<String>(
      endpoint,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.userAgentHeader: 'dio',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        }
      ),
      data: data
    );
    return response;
  }

  void closeClient() => _client.close();
}