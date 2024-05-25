import 'dart:convert';

import '../../blocs/blocs.dart';
import '../../../env/env.dart';
import 'directions_provider.dart';

class DirectionsHelper {
  final DirectionsProvider _client = DirectionsProvider();
  static final _ors = Env.orsKey;

  Future<DirectionsModel?> fetchDirections({required String origin, required String destination}) async {
    final response = await _client.getDirections(apiKey: _ors, start: origin, end: destination);
    if (response.statusCode != null && response.statusCode == 200){
      final decoded = jsonDecode(response.data!) as Map<String, dynamic>;
      return DirectionsModel.fromJson(decoded);
    }
    return null;
  }

  void destroyClient() => _client.closeClient();
}