import '../../../env/env.dart';
import '../../blocs/trips/models/history_model.dart';
import '../../storage/auth_client.dart';
import 'trips_provider.dart';

class HistoryHelper{
  final TripsProvider _client = TripsProvider();

  Future<List<HistoryModel>> _fetchHistory(String endpoint, String token) async {
    final trips = await _client.getTrips(endpoint, token);
    List<HistoryModel> formatted = trips != null && trips.isNotEmpty ? List<HistoryModel>.generate(trips.length, (index) => HistoryModel.fromJson(trips[index])): List<HistoryModel>.empty();
    return formatted;
  }

  Future<List<HistoryModel>> _fullHistory(String endpoint, String token) async {
    List<HistoryModel> driverRoutes = List.empty(), passengerRoutes = await _fetchHistory('$endpoint/routes-passenger', token);
    if (await AuthClient().isDriver == true) {
      driverRoutes = await _fetchHistory('$endpoint/routes-driver', token);
      return [...driverRoutes, ...passengerRoutes];
    }
    return passengerRoutes;
  }

  Future<List<HistoryModel>> fetchHistoryFromU(String token) async => _fullHistory(Env.tripsFromUEndpoint, token);

  Future<List<HistoryModel>> fetchHistoryToU(String token) async => _fullHistory(Env.tripsToUEndpoint, token);
}