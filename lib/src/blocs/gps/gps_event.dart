part of 'gps_bloc.dart';

abstract class GpsEvent extends Equatable {
  const GpsEvent();

  @override
  List<Object> get props => [];
}

class GpsAndPermissionEvent extends GpsEvent{
  final bool enabledGPS, permissionGrantedGPS;

  const GpsAndPermissionEvent({required this.enabledGPS, required this.permissionGrantedGPS});
}