part of 'trips_bloc.dart';

abstract class TripsState extends Equatable {
  const TripsState();
  @override
  List<Object> get props => [];
}

class TripsLoading extends TripsState {
  const TripsLoading();
}

class TripsReturned extends TripsState {
  final List<CitySummaryModel> citiesList;
  const TripsReturned(this.citiesList);
  @override
  List<Object> get props => List.generate(citiesList.length, (index) => citiesList.elementAt(index).props);
}

class TripsError extends TripsState {
  final String message;
  const TripsError(this.message);
}
