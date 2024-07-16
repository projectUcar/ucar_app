import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../helpers/helpers.dart';
import '../../../util/fail_to_message.dart';
import '../../../util/options/cities.dart';
import '../../token_validation.dart';
import '../models/city_summary_model.dart';
import '../models/trip_model.dart';

part 'trips_event.dart';
part 'trips_state.dart';

class TripsBloc extends Bloc<TripsEvent, TripsState> with TokenValidation<TripsState>{
  TripsBloc() : _helper = TripsHelper(), super(const TripsLoading()) {
    on<TripsEvent>((event, emit) async{
      if (state is! TripsLoading) emit(const TripsLoading());
      List<CitySummaryModel> summaries = [];
      final token = await verifyToken();
      try {
        for (Cities city in Cities.values) {
          List<TripModel> data;
          if (event is GetTripsFromU) {
            data = await _helper.fetchTripsFromU(city.nameFormat, token!);
          }else{
            data = await _helper.fetchTripsToU(city.nameFormat, token!);
          }
          summaries.add(CitySummaryModel.fromTripList(data, city.nameFormat, event is GetTripsFromU));
        }
        emit(TripsReturned(summaries));
      } on DioException catch (e) {
        emit(TripsError(e.getMessage()));
      }
    });
  }
  final TripsHelper _helper;
}
