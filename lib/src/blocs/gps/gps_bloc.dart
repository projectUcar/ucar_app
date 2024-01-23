import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {
  GpsBloc() : super(const GpsState(enabledGPS: false, permissionGrantedGPS: false)) {
    
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
      enabledGPS: event.enabledGPS,
      permissionGrantedGPS: event.permissionGrantedGPS
    )));

    _init();
  }

  Future<void> _init() async{
    final isEnable = await _checkGpsStatus();
    debugPrint('isEnable: $isEnable');
  }

  Future<bool> _checkGpsStatus() async{
    final isEnable = await Geolocator.isLocationServiceEnabled();
    
    Geolocator.getServiceStatusStream().listen((event) {
      final enabled = (event.index == 1) ? true : false;
      debugPrint('Service status $enabled');
    });
    
    return isEnable;
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
