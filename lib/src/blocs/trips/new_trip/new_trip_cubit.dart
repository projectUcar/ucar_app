import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../helpers/helpers.dart';
import '../../../util/options/cities.dart';
import '../../../util/regex_comparison.dart';
import '../../blocs.dart';
import '../../token_validation.dart';
import '../models/new_trip_model.dart';

part 'new_trip_state.dart';

class NewTripCubit extends Cubit<NewTripState> with TokenValidation<NewTripState>{
  NewTripCubit() : super(NewTripState.initial());
  final TripsHelper _helper = TripsHelper();

  void _updateState(NewTripState newState){
    emit(newState);
  }

  Future<bool> submit() async{
    final token = await verifyToken();
    final bool result = state.toU ? await _helper.createTripToU(state.newTripModel.toJson(state.toU), token!) : await _helper.createTripFromU(state.newTripModel.toJson(state.toU), token!);
    return result;
  }

  void updateToU(bool? value) => _updateState(state.copyWith(toU: value));
  void updateCity(Cities? value) => _updateState(state.copyWith(city: value));
  void updateTarget(String? value) => _updateState(state.copyWith(target: value));
  void updateVehicle(String? value) => _updateState(state.copyWith(vehicleId: value));
  void updateSeats(int value) => _updateState(state.copyWith(availableSeats: value));
  void updateDescription(String? value) => _updateState(state.copyWith(description: value));
  void updateDepartureDate (DateTime? value) => _updateState(state.copyWith(departureDate: value));
  void updateDepartureTime (String? value) => _updateState(state.copyWith(departureTime: value));
  void updateSubmitted(bool? value) => _updateState(state.copyWith(submitted: value));

}
