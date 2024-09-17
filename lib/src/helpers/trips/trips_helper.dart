import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:ucar_app/src/storage/auth_client.dart';

import '../../../env/env.dart';
import '../../models/vehicle.dart';
import '../../blocs/blocs.dart';
import 'trips_provider.dart';

class TripsHelper{
  final TripsProvider _client = TripsProvider();
  final AuthClient _authClient = AuthClient();

  Future<List<TripModel>> _fetchTrips(String endpoint, String token) async {
    final userId = await _authClient.userId;
    final trips = await _client.getTrips(endpoint, token);
    List<TripModel> formatted = trips != null && trips.isNotEmpty ? List<TripModel>.generate(trips.length, (index) => TripModel.fromJson(trips[index])): List<TripModel>.empty();
    return formatted.where((tripModel) => !tripModel.alreadyBooked(userId!)).toList();
  }

  Future<bool> _createTrip(String endpoint, Map<String, dynamic> data, String token) async {
    try {
      final response = await _client.postData(endpoint, token, jsonEncode(data));
      return (response != null && response.statusCode! < 300);
    } on DioException {
      return false;
    }
  }

  Future<bool> createTripToU(Map<String, dynamic> data, String token) async => _createTrip("${Env.tripsToUEndpoint}/create-route", data, token);

  Future<bool> createTripFromU(Map<String, dynamic> data, String token) async => _createTrip("${Env.tripsFromUEndpoint}/create-route", data, token);

  Future<List<TripModel>> fetchTripsFromU(String city, String token) async => _fetchTrips("${Env.tripsFromUEndpoint}/city/$city", token);

  Future<List<TripModel>> fetchTripsToU(String city, String token) async => _fetchTrips("${Env.tripsToUEndpoint}/city/$city", token);

  Future<Vehicle> fetchVehicleFeatures(TripModel model, String token) async {
    try {
      final response = await _client.getTripById("${model.toUniversity ? Env.tripsToUEndpoint : Env.tripsFromUEndpoint}/id/${model.id}", token);
      if (response != null && response.statusCode! < 300) return Vehicle.fromJson(jsonDecode(response.data!)["vehicle"] as Map<String, dynamic>); 
      return Vehicle.empty();
    } on DioException {
      return Vehicle.empty();
    }
  }

  Future<bool> requestSeat(String tripId, String driverId) async {
    try {
      final token = await AuthClient().accessToken;
      final response = await _client.postData('${Env.requestSeatEndpoint}/$tripId', token!, jsonEncode(<String, dynamic>{"idDriver": driverId}));
      return (response != null && response.statusCode! < 300);
    } on DioException {
      return false;
    }
  }

  void destroyClient() => _client.closeClient();
}