part of 'vehicles_bloc.dart';

abstract class VehiclesEvent extends Equatable {
  const VehiclesEvent();

  @override
  List<Object> get props => [];
}

class FetchingEvent extends VehiclesEvent{}
