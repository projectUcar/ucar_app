part of 'trips_bloc.dart';

abstract class TripsState extends Equatable {
  const TripsState({required this.type});
  final DestinationType type;
  @override
  List<Object> get props => [type.name];

  TripsState copyWith(DestinationType type);
}

class TripsInitial extends TripsState {
  const TripsInitial({required super.type});
  
  @override
  TripsInitial copyWith(DestinationType type) => TripsInitial(type: type);
}

class TripsLoading extends TripsState {
  const TripsLoading({required super.type});
  
  @override
  TripsLoading copyWith(DestinationType type) => TripsLoading(type: type);
}

class TripsReturned extends TripsState {
  final List<CitySummaryModel> citiesList;
  const TripsReturned(this.citiesList, {required super.type});
  @override
  List<Object> get props => List.generate(citiesList.length, (index) => citiesList.elementAt(index).props);

  @override
  TripsReturned copyWith(DestinationType type) => TripsReturned(citiesList, type: type);
}

class TripsError extends TripsState {
  final String message;
  const TripsError(this.message, {required super.type});
  
  @override
  TripsError copyWith(DestinationType type) => TripsError(message, type: type);
}
