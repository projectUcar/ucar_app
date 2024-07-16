import 'dart:io';
import 'package:dio/dio.dart';

import '../../../env/env.dart';

class VehiclesProvider{
  static final VehiclesProvider _instance = VehiclesProvider._internal();
  factory VehiclesProvider() => _instance;
  VehiclesProvider._internal();

  final _client = Dio(
    BaseOptions(
      baseUrl: Env.vehiclesBaseUrl,
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (statusCode) => (statusCode == null || (statusCode >= 300 && statusCode < 400)) ? false : true,
      receiveDataWhenStatusError: true
    )
  );
  Future<Response<String>?> postData(String endpoint, String token, String data) async{
    final response = await _client.post<String>(
      endpoint,
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: Headers.jsonContentType,
          HttpHeaders.userAgentHeader: 'dio',
          HttpHeaders.authorizationHeader: 'Bearer $token'
        },
      ),
      data: data
    );
    return response;
  }
}