import 'package:date_time_format/date_time_format.dart';

import '../../../models/vehicle.dart';
import '../../../util/options/cities.dart';

class NewTripModel {
  final String? target, description, departureTime;
  final Cities? city;
  final DateTime? departureDate;
  final int availableSeats;
  final Vehicle? vehicle;

  String? get vehicleId => vehicle?.id;

  NewTripModel({required this.city, required this.target, required this.description, required this.departureDate, required this.departureTime, required this.availableSeats, required this.vehicle});
  
  factory NewTripModel.initial() => NewTripModel(
    city: null,
    target: null,
    description: null,
    departureDate: null,
    departureTime: null,
    availableSeats: 0,
    vehicle: null,
  );

  Map<String, dynamic> toJson(bool toU) => {
    "city": city?.nameFormat,
    (toU ? "origin" : "destination"): target,
    "description": description,
    "departureDate": departureDate?.format(r'm/d/Y'),
    "departureTime": departureTime,
    "availableSeats": availableSeats,
    "vehicleId": vehicleId,
  };

  @override
  String toString() => '$city, $target, $description, $departureDate, $departureTime, $availableSeats, $vehicle';
}