part of 'trips_bloc.dart';

abstract class TripsEvent extends Equatable {
  const TripsEvent();

  @override
  List<Object> get props => [];
}

class GetTripsToU extends TripsEvent {
  const GetTripsToU();
}

class GetTripsFromU extends TripsEvent {
  const GetTripsFromU();
}