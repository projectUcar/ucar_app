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

  Map<String, dynamic> toJson(bool toU) {
    if (toU == true) {
      return {
        "origin" : target,
        "city": city?.nameFormat,
        "description": description,
        "departureDate": departureDate?.format(r'Y/m/d'),
        "departureTime": departureTime,
        "availableSeats": availableSeats,
        "vehicleId": vehicleId,
      };
    }
    return {
      "city": city?.nameFormat,
      "destination": target,
      "description": description,
      "departureDate": departureDate?.format(r'Y/m/d'),
      "departureTime": departureTime,
      "availableSeats": availableSeats,
      "vehicleId": vehicleId,
  };
  }

  @override
  String toString() => '$city, $target, $description, $departureDate, $departureTime, $availableSeats, $vehicle';
}