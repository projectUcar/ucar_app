import '../../blocs.dart';
import '../../../models/vehicle.dart';

class HistoryModel {
  TripModel tripModel;
  Vehicle vehicle;

  HistoryModel({required this.tripModel, required this.vehicle});

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
    tripModel: TripModel.fromJson(json["route"]),
    vehicle: Vehicle.fromJson(json["vehicle"]),
  );

  Map<String, dynamic> toJson() => {
    "route": tripModel.toJson(),
    "vehicle": vehicle.toJson(),
  };
}