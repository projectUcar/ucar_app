import 'package:date_time_format/date_time_format.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import '../../../storage/auth_client.dart';
import '../../../util/hour_formatter.dart';

class TripModel extends Equatable{
  final String _id, origin, destination, city, description, departureTime, vehicleId, driverUserId, status, driverName;
  final int availableSeats;
  final List<dynamic> passengers;
  final DateTime departureDate, createdAt, updatedAt;

  static const upbVal = "Universidad Pontificia Bolivariana";

  bool alreadyBooked(String userID) => (driverUserId == userID) || passengers.contains(userID);

  String get id => _id;
  bool get toUniversity => destination.contains(upbVal);

  DateTime get fullDateTime {
    final formatted = departureDate.add(departureTime.toDuration());
    return formatted;
  }

  String get titleFormat => '$origin - $destination'.replaceAll(RegExp(TripModel.upbVal + r"\s?Seccional Bucaramanga"), "UPB");

  //Evalúa si el que está viendo la información en pantalla es el conductor del viaje
  Future<bool> get viewerIsDriver async => await AuthClient().userId == driverUserId;

  String get formatDT => '${DateTimeFormat.format(departureDate, format: r'd/m/Y')} $departureTime';

  const TripModel({
    required String id,
    required this.origin,
    required this.destination,
    required this.city,
    required this.description,
    required this.departureDate,
    required this.departureTime,
    required this.availableSeats,
    required this.vehicleId,
    required this.driverUserId,
    required this.status,
    required this.passengers,
    required this.createdAt,
    required this.updatedAt,
    required this.driverName,
  }) : _id = id;

  factory TripModel.fromJson(Map<String, dynamic> json) => TripModel(
    id: json["_id"],
    origin: json["origin"],
    destination: json["destination"],
    city: json["city"],
    description: json["description"],
    departureDate: DateTime.parse(json["departureDate"]),
    departureTime: (json["departureTime"] as String),
    availableSeats: json["availableSeats"],
    vehicleId: json["vehicleId"],
    driverUserId: json["driverUserId"],
    status: json["status"],
    passengers: List<dynamic>.from(json["passengers"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    driverName: json["driverName"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": _id,
    "origin": origin,
    "destination": destination,
    "city": city,
    "description": description,
    "departureDate": departureDate.toIso8601String(),
    "departureTime": departureTime,
    "availableSeats": availableSeats,
    "vehicleId": vehicleId,
    "driverUserId": driverUserId,
    "status": status,
    "passengers": List<dynamic>.from(passengers.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "driverName": driverName,
  };

  Future<List<Location>> get locations async{
    final originLocation = await locationFromAddress("$origin${(toUniversity) ? ", $city, Santander, Colombia": _addressFormat(origin)}").then((value) => value.first);
    final destinationLocation = await locationFromAddress("$destination${(!toUniversity) ? ", $city, Santander, Colombia": _addressFormat(destination)}").then((value) => value.first);
    return [originLocation, destinationLocation];
  }

  String _addressFormat(String address) {
    const String plusString = "Seccional Bucaramanga";
    return address.contains(plusString) ? "" : " $plusString";
  }
  
  @override
 List<Object?> get props => [_id, origin, destination, city, description, departureDate, departureTime, availableSeats, vehicleId, driverUserId, status, passengers, createdAt, updatedAt, driverName];
}
