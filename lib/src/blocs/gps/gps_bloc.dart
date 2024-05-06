import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

part 'gps_event.dart';
part 'gps_state.dart';

class GpsBloc extends Bloc<GpsEvent, GpsState> {

  StreamSubscription? gpsServiceSubscription;

  GpsBloc() : super(const GpsState(enabledGPS: false, permissionGrantedGPS: false)) {
    
    on<GpsAndPermissionEvent>((event, emit) => emit(state.copyWith(
      enabledGPS: event.enabledGPS,
      permissionGrantedGPS: event.permissionGrantedGPS
    )));

    _init();
  }

  Future<void> _init() async{
    final gpsInitStatus = await Future.wait([_checkGpsStatus(), _isPermissionGranted()]);
    add(GpsAndPermissionEvent(enabledGPS: gpsInitStatus[0], permissionGrantedGPS: gpsInitStatus[1]));
  }

  Future<bool> _isPermissionGranted() async {
    final isGranted = await Permission.location.isGranted;
    return isGranted;
  }

  Future<bool> _checkGpsStatus() async{
    final isEnable = await Geolocator.isLocationServiceEnabled();
    
    gpsServiceSubscription = Geolocator.getServiceStatusStream().listen((event) {
      final isEnabled = event.index == 1;
      add(GpsAndPermissionEvent(enabledGPS: isEnabled, permissionGrantedGPS: state.permissionGrantedGPS));
    });
    
    return isEnable;
  }

  Future<void> askGpsAccess() async{
    final PermissionStatus status = await Permission.location.request();

    switch (status) {
      case PermissionStatus.granted:
        add(GpsAndPermissionEvent(enabledGPS: state.enabledGPS, permissionGrantedGPS: true));
        break;
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.limited:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.provisional:
        add(GpsAndPermissionEvent(enabledGPS: state.enabledGPS, permissionGrantedGPS: false));
        openAppSettings();
    }
  }

  @override
  Future<void> close() {
    gpsServiceSubscription?.cancel();
    return super.close();
  }
}
