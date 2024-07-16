import 'package:date_time_format/date_time_format.dart';

import '../../../util/options/cities.dart';

class NewTripModel {
  final String? target, description, vehicleId, departureTime;
  final Cities city;
  final DateTime? departureDate;
  final int availableSeats;

  NewTripModel({required this.city, required this.target, required this.description, required this.departureDate, required this.departureTime, required this.availableSeats, required this.vehicleId});
  
  factory NewTripModel.empty() => NewTripModel(
    city: Cities.bucaramanga,
    target: null,
    description: null,
    departureDate: null,
    departureTime: null,
    availableSeats: 0,
    vehicleId: null,
  );
  
  factory NewTripModel.fromJson(Map<String, dynamic> json) => NewTripModel(
    city: json["city"],
    target: json["destination"] ?? json["origin"],
    description: json["description"],
    departureDate: json["departureDate"],
    departureTime: json["departureTime"],
    availableSeats: json["availableSeats"],
    vehicleId: json["vehicleId"],
  );

  Map<String, dynamic> toJson(bool toU) => {
    "city": city.nameFormat,
    (toU ? "origin" : "destination"): target,
    "description": description,
    "departureDate": departureDate?.format(r'm/d/Y'),
    "departureTime": departureTime,
    "availableSeats": availableSeats,
    "vehicleId": vehicleId,
  };
}