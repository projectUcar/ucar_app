import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../helpers/helpers.dart';
import '../../../storage/auth_client.dart';
import '../../../util/fail_to_message.dart';
import '../../blocs.dart';
import '../../token_validation.dart';

part 'history_event.dart';
part 'history_state.dart';
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> with TokenValidation<HistoryState>{
  HistoryBloc(): _helper = TripsHelper(), super(const HistoryLoading()) {
    on<HistoryEvent>((event, emit) async{
      if (state is! HistoryLoading) emit(const HistoryLoading());
      final token = await verifyToken();
      final id = await AuthClient().userId;
      try {
        final List<TripModel> list;
        if (event is GetHistoryToU) {
          list = await _helper.fetchHistoryToU(id!,token!);
          emit(HistoryReturned(list));
        } else if (event is GetHistoryFromU) {
          list = await _helper.fetchHistoryFromU(id!,token!);
          emit(HistoryReturned(list));
        }
      } on DioException catch (e) {
        emit(HistoryError(e.getMessage()));
      }
    });
  }
  final TripsHelper _helper;
}
