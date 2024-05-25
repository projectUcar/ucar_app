import 'package:equatable/equatable.dart';

class TripModel extends Equatable{
  final String _id, origin, destination, city, description, departureTime, vehicleId, driverUserId, status, driverName;
  final int availableSeats;
  final List<dynamic> passengers;
  final DateTime departureDate, createdAt, updatedAt;

  String get id => _id;
  bool get toUniversity => destination.contains("Universidad Pontificia Bolivariana");

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
    departureTime: json["departureTime"],
    availableSeats: json["availableSeats"],
    vehicleId: json["vehicleId"],
    driverUserId: json["driverUserId"],
    status: json["status"],
    passengers: List<dynamic>.from(json["passengers"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    driverName: json["driverName"],
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
  
  @override
 List<Object?> get props => [_id, origin, destination, city, description, departureDate, departureTime, availableSeats, vehicleId, driverUserId, status, passengers, createdAt, updatedAt, driverName];
}
