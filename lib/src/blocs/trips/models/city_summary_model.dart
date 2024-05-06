import 'package:equatable/equatable.dart';

import 'trip_model.dart';

class CitySummaryModel extends Equatable{
  final String cityName;
  final List<String> places;
  final int numberRoutes, numberDrivers, numberSeats;
  final List<TripModel> trips;

  CitySummaryModel.fromTripList(List<TripModel> tripsList, String name, bool fromU):
    trips = tripsList,
    cityName = name,
    numberRoutes = tripsList.length,
    numberDrivers = _getNumDrivers(tripsList),
    numberSeats = _getSeats(tripsList),
    places = _getPlaces(tripsList, fromU);

  static int _getNumDrivers(List<TripModel> list){
    List<String> drivers = [];
    if (list.isNotEmpty) {
      for (TripModel trip in list) {
        drivers.add(trip.driverName);
      }
    }
    return Set<String>.of(drivers).length;
  }
  static int _getSeats(List<TripModel> list){
    int seats = 0;
    if (list.isNotEmpty) {
      for (TripModel trip in list) {
        seats += trip.availableSeats;
      }
    }
    return seats;
  }

  //type:
  //  true => fromUniversity
  //  false => toUniversity
  static List<String> _getPlaces(List<TripModel> list, bool type){
    List<String> places = [];
    switch (type) {
      case true:
        for (TripModel trip in list) {
          places.add(trip.destination);
        }
        break;
      default:
        for (TripModel trip in list) {
          places.add(trip.origin);
        }
        break;
    }
    return Set<String>.of(places).toList();
  }
  
  @override
  List<Object?> get props =>[cityName, places, numberRoutes, numberDrivers, numberSeats, trips];
}