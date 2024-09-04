
import 'package:dio/dio.dart';

import '../../models/vehicle.dart';
import '../../../env/env.dart';
import 'vehicles_provider.dart';

class VehiclesHelper{
  final VehiclesProvider _client = VehiclesProvider();
  final String _postDocumentEndpoint = Env.driverRequestEndpoint, _newVehicleEndpoint = Env.newVehicleEndpoint, _myVehiclesEndpoint = Env.myVehiclesEndpoint;

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

  Future<List<Vehicle>> myVehicles(String token) async{
    final vehicles = await _client.getVehicles(_myVehiclesEndpoint, token);
    List<Vehicle> formatted = vehicles != null && vehicles.isNotEmpty ? List<Vehicle>.generate(vehicles.length, (index) => Vehicle.fromJson(vehicles[index])): List<Vehicle>.empty();
    return formatted;
  }
}