
import 'package:dio/dio.dart';

import '../../../env/env.dart';
import 'vehicles_provider.dart';

class VehiclesHelper{
  final VehiclesProvider _client = VehiclesProvider();
  final String _postDocumentEndpoint = Env.driverRequestEndpoint, _newVehicleEndpoint = Env.newVehicleEndpoint;

  Future<bool> sendDriverRequest(String token, String data) async {
    try {
      final response = await _client.postData(_postDocumentEndpoint, token, data);
      return (response != null && response.statusCode! < 300);
    } on DioException {
      return false;
    }
  }

  Future<bool> addVehicleRequest(String token, String data) async {
    try {
      final response = await _client.postData(_newVehicleEndpoint, token, data);
      return (response != null && response.statusCode! < 300);
    } on DioException {
      return false;
    }
  }
}