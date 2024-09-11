
import 'package:dio/dio.dart';

import '../../models/vehicle.dart';
import '../../../env/env.dart';
import 'vehicles_provider.dart';

class VehiclesHelper{
  final VehiclesProvider _client = VehiclesProvider();
  final String _postDocumentEndpoint = Env.driverRequestEndpoint, _newVehicleEndpoint = Env.newVehicleEndpoint, _myVehiclesEndpoint = Env.myVehiclesEndpoint, _saveDocumentEndpoint = Env.saveDocumentEndpoint;

  Future<bool> _sendPostMethod(String endpoint, String token, String? data) async {
    try {
      final response = await _client.postData(endpoint, token, data);
      return (response != null && response.statusCode! < 300);
    } on DioException {
      return false;
    }
  }

  Future<bool> saveDocument(String token, String data) async => _sendPostMethod(_saveDocumentEndpoint, token, data);

  Future<bool> sendDriverRequest(String token) async => _sendPostMethod(_postDocumentEndpoint, token, null);

  Future<bool> addVehicleRequest(String token, String data) async => _sendPostMethod(_newVehicleEndpoint, token, data);

  Future<List<Vehicle>> myVehicles(String token) async{
    final vehicles = await _client.getVehicles(_myVehiclesEndpoint, token);
    List<Vehicle> formatted = vehicles != null && vehicles.isNotEmpty ? List<Vehicle>.generate(vehicles.length, (index) => Vehicle.fromJson(vehicles[index])): List<Vehicle>.empty();
    return formatted;
  }
}