part of 'trips_bloc.dart';

abstract class TripsEvent extends Equatable {
  const TripsEvent();

  @override
  List<Object> get props => [];
}

class GetTripsList extends TripsEvent {
  final DestinationType destinationType;

  const GetTripsList({required this.destinationType});
}

class DestinationTypeUpdate extends TripsEvent{
  final DestinationType destinationType;

  const DestinationTypeUpdate({required this.destinationType});
}
