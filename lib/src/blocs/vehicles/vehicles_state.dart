part of 'vehicles_bloc.dart';

abstract class VehiclesState extends Equatable {
  const VehiclesState();
  
  @override
  List<Object> get props => [];
}

class VehiclesLoading extends VehiclesState {
  const VehiclesLoading();
}

class VehiclesReturned extends VehiclesState {
  final List<Vehicle> vehicles;
  
  const VehiclesReturned(this.vehicles);

  @override
  List<Object> get props => vehicles;
}

class VehiclesFailed extends VehiclesState{
  final String message;

  const VehiclesFailed(this.message);

  @override
  List<Object> get props => [message];
}
