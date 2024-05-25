import 'package:dio/dio.dart';

class DirectionsProvider {
  static final DirectionsProvider _instance = DirectionsProvider._internal();
  factory DirectionsProvider() => _instance;
  DirectionsProvider._internal();

  static const String _endpoint = "/v2/directions/driving-car";
  final _client = Dio(
    BaseOptions(
      baseUrl: 'https://api.openrouteservice.org',
      connectTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      validateStatus: (statusCode) => (statusCode == null || (statusCode >= 300 && statusCode < 400)) ? false : true,
      receiveDataWhenStatusError: true
    )
  );

  Future<Response<String>> getDirections({required String apiKey, required String start, required String end}) async{
    final response = await _client.get<String>(
      _endpoint,
      queryParameters: {
        'api_key': apiKey,
        'start': start,
        'end': end,
      }
    );
    return response;
  }

  void closeClient() => _client.close();
}