import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:ucar_app/src/util/fail_to_message.dart';
import '../../helpers/helpers.dart';
import '../blocs.dart';
import '../token_validation.dart';

part 'holders_event.dart';
part 'holders_state.dart';

class HoldersBloc extends Bloc<HoldersEvent, HoldersState> with TokenValidation{
  HoldersBloc({required this.tripModel}) : _helper = ProfileHelper(), super(HoldersLoading()) {
    on<HoldersFetching>((event, emit) async{
      if (state is! HoldersLoading) emit(HoldersLoading());
      final token = await verifyToken();
      try {
        final data = await Future.wait(List.generate(tripModel.ids.length, (index) => _helper.userById(tripModel.ids[index], token!)));
        emit(HoldersReturned(holders: data));
      } on DioException catch (e) {
        emit(HoldersFailed(message: e.getMessage()));
      }
    });
  }
  final TripModel tripModel;
  final ProfileHelper _helper;
}

