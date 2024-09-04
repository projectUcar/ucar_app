import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../util/fail_to_message.dart';
import '../../models/vehicle.dart';
import '../token_validation.dart';
import '../../helpers/helpers.dart';

part 'vehicles_event.dart';
part 'vehicles_state.dart';

class VehiclesBloc extends Bloc<VehiclesEvent, VehiclesState> with TokenValidation{
  VehiclesBloc() : _helper = VehiclesHelper(), super(const VehiclesLoading()) {
    on<FetchingEvent>((event, emit) async{
      if (state is! VehiclesLoading) emit(const VehiclesLoading());
      try {
        final token = await verifyToken();
        final vehicles = await _helper.myVehicles(token!);
        emit(VehiclesReturned(vehicles));
      } on DioException catch (e) {
        emit(VehiclesFailed(e.getMessage()));
      }
    });
  }
  final VehiclesHelper _helper;
}
