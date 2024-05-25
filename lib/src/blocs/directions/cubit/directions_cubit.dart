import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../helpers/helpers.dart';
import '../../../util/latlng_to_string.dart';
import '../models/directions_model.dart';
part 'directions_state.dart';

class DirectionsCubit extends Cubit<DirectionsState> {
  DirectionsCubit({required DirectionsState directionsState}): super(directionsState);
  final DirectionsHelper _helper = DirectionsHelper();

  Future<void> retrieveDirections(bool toUniversity, LatLng target) async{
    final DirectionsModel? model = await _helper.fetchDirections(
      origin: toUniversity ? target.invertLatLng(): DirectionsState.upbLocation.invertLatLng(),
      destination: toUniversity ? DirectionsState.upbLocation.invertLatLng() : target.invertLatLng()
    );
    emit(state.copyWith(toUniversity: toUniversity, target: target, directionsModel: model));
  }
}
