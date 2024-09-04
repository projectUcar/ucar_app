import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../helpers/helpers.dart';
import '../../../models/vehicle.dart';
import '../../../util/fail_to_message.dart';
import '../../blocs.dart';
import '../../token_validation.dart';

part 'history_event.dart';
part 'history_state.dart';
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> with TokenValidation<HistoryState>{
  HistoryBloc(): _historyHelper = HistoryHelper(), _vehiclesHelper = VehiclesHelper(), super(const HistoryLoading()) {
    on<HistoryEvent>((event, emit) async{
      if (state is! HistoryLoading) emit(const HistoryLoading());
      List<HistoryModel> list = [];
      try {
        final token = await verifyToken();
        if (event is GetHistoryToU) {
          list = await _historyHelper.fetchHistoryToU(token!);
          emit(HistoryReturned(list));
        } else if (event is GetHistoryFromU) {
          list = await _historyHelper.fetchHistoryFromU(token!);
          emit(HistoryReturned(list));
        }
      } on Exception catch (e) {
        emit(HistoryError((e is DioException) ? e.getMessage() : "Ocurrió un error inesperado"));
      }
    });
  }
  final HistoryHelper _historyHelper;
  final VehiclesHelper _vehiclesHelper;

  Future<List<Vehicle>> vehicles() async {
    try {
      final token = await verifyToken();
      final vehicles = await _vehiclesHelper.myVehicles(token!);
      return vehicles;
    } on Exception{
      return List<Vehicle>.empty();
    }
  }
}
