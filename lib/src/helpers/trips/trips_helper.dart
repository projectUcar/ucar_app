import 'package:ucar_app/env/env.dart';

import '../../blocs/blocs.dart';
import 'trips_provider.dart';

class TripsHelper{
  final TripsProvider _client = TripsProvider();

  Future<List<TripModel>> _fetchTrips(String endpoint, String token) async {
    final trips = await _client.getTrips(endpoint, token);
    List<TripModel> formatted = trips != null && trips.isNotEmpty ? List<TripModel>.generate(trips.length, (index) => TripModel.fromJson(trips[index])): List<TripModel>.empty();
    return formatted;
  }

  Future<List<TripModel>> fetchTripsFromUniversity(String city, String token) async => _fetchTrips("${Env.tripsFromUEndpoint}$city", token);

  Future<List<TripModel>> fetchTripsToUniversity(String city, String token) async => _fetchTrips("${Env.tripsToUEndpoint}$city", token);

  void destroyClient() => _client.closeClient();
}