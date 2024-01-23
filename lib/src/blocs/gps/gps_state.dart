part of 'gps_bloc.dart';

class GpsState extends Equatable {
  
  final bool enabledGPS, permissionGrantedGPS;
  
  const GpsState({required this.enabledGPS, required this.permissionGrantedGPS});
  
  GpsState copyWith({bool? enabledGPS, bool? permissionGrantedGPS})
  => GpsState(
    enabledGPS: enabledGPS ?? this.enabledGPS,
    permissionGrantedGPS: permissionGrantedGPS ?? this.permissionGrantedGPS
  );

  @override
  List<Object> get props => [enabledGPS, permissionGrantedGPS];

  @override
  String toString() => '{enabledGPS: $enabledGPS, permissionGrantedGPS: $permissionGrantedGPS}';
}
