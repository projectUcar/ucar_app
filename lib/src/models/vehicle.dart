import '../util/options/document_types.dart';

class Vehicle{
  final String? id, brand, model, line, plate, color, documentTypeOwner, documentNumberOwner;
  final int? doors, seats;
  final bool isOwner;

  const Vehicle({required this.id, required this.brand, required this.model, required this.line, required this.plate, required this.color, required this.doors, required this.seats, this.isOwner = false, required this.documentTypeOwner, required this.documentNumberOwner});

  String get defaultText => "Info. no disponible";

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    id: json["_id"],
    brand: json["brand"],
    model: json["model"],
    line: json["line"],
    plate: json["plate"],
    color: json["color"],
    seats: json["seats"],
    doors: json["doors"],
    isOwner: json["isOwner"] ?? false,
    documentTypeOwner: json["documentTypeOwner"],
    documentNumberOwner: json["documentNumberOwner"]
  );

  factory Vehicle.empty() => Vehicle(
    id: null,
    brand: null,
    model: null,
    line: null,
    plate: null,
    color: null,
    seats: null,
    doors: null,
    isOwner: false,
    documentTypeOwner: DocumentTypes.cc.name,
    documentNumberOwner: null
  );

  Map<String, dynamic> toJson() => {
    "brand": brand,
    "model": model,
    "line": line,
    "plate": plate,
    "color": color,
    "seats": seats,
    "doors": doors,
    "isOwner": isOwner,
    "documentTypeOwner": documentTypeOwner,
    "documentNumberOwner": documentNumberOwner
  };

  @override
  bool operator ==(dynamic other) => other != null && other is Vehicle && id == other.id && plate == other.plate;

  @override
  int get hashCode => Object.hash(id, plate);

  @override
  String toString() => '$id, $brand, $model, $line, $plate, $color, $seats, $doors, $isOwner, $documentTypeOwner, $documentNumberOwner';

  bool get isEmpty => brand == null && model == null && line == null && plate == null && color == null && seats == null && doors == null && documentTypeOwner == null && documentNumberOwner == null;
}