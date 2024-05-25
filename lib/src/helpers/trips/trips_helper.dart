import 'dart:convert';
import 'package:dio/dio.dart';

import '../../../env/env.dart';
import '../../models/vehicle.dart';
import '../../blocs/blocs.dart';
import 'trips_provider.dart';

class TripsHelper{
  final TripsProvider _client = TripsProvider();

  Future<List<TripModel>> _fetchTrips(String endpoint, String token) async {
    final trips = await _client.getTripsByCity(endpoint, token);
    List<TripModel> formatted = trips != null && trips.isNotEmpty ? List<TripModel>.generate(trips.length, (index) => TripModel.fromJson(trips[index])): List<TripModel>.empty();
    return formatted;
  }

  Future<List<TripModel>> fetchTripsFromUniversity(String city, String token) async => _fetchTrips("${Env.tripsFromUEndpoint}/city/$city", token);

  Future<List<TripModel>> fetchTripsToUniversity(String city, String token) async => _fetchTrips("${Env.tripsToUEndpoint}/city/$city", token);

  Future<Vehicle> fetchVehicleFeatures(TripModel model, String token) async {
    try {
      final response = await _client.getTripById("${model.toUniversity ? Env.tripsToUEndpoint : Env.tripsFromUEndpoint}/id/${model.id}", token);
      if (response != null && response.statusCode! < 300) return Vehicle.fromJson(jsonDecode(response.data!)["vehicle"] as Map<String, dynamic>); 
      return Vehicle.empty();
    } on DioException {
      return Vehicle.empty();
    }
  }

  void destroyClient() => _client.closeClient();
}