import '../util/options/document_types.dart';

class Vehicle{
  final String? brand, model, line, plate, color, documentTypeOwner, documentNumberOwner;
  final int? doors, seats;
  final bool isOwner;

  const Vehicle({required this.brand, required this.model, required this.line, required this.plate, required this.color, required this.doors, required this.seats, this.isOwner = false, required this.documentTypeOwner, required this.documentNumberOwner});

  String get defaultText => "Info. no disponible";

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    brand: json["brand"],
    model: json["model"],
    line: json["line"],
    plate: json["plate"],
    color: json["color"],
    seats: json["seats"],
    doors: json["doors"],
    isOwner: json["isOwner"] ?? false, //Corregir
    documentTypeOwner: json["documentTypeOwner"],
    documentNumberOwner: json["documentNumberOwner"]
  );

  factory Vehicle.empty() => Vehicle(
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

  bool get isEmpty => brand == null && model == null && line == null && plate == null && color == null && seats == null && doors == null && documentTypeOwner == null && documentNumberOwner == null;
}