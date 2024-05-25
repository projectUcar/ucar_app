class Vehicle {
  String? brand, model, line, plate, color;
  int? doors;

  Vehicle({required this.brand, required this.model, required this.line, required this.plate, required this.color, required this.doors});

  String get defaultText => "Info. no disponible";

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
    brand: json["brand"],
    model: json["model"],
    line: json["line"],
    plate: json["plate"],
    color: json["color"],
    doors: json["doors"],
  );

  factory Vehicle.empty() => Vehicle(
    brand: null,
    model: null,
    line: null,
    plate: null,
    color: null,
    doors: null,
  );

  Map<String, dynamic> toJson() => {
    "brand": brand,
    "model": model,
    "line": line,
    "plate": plate,
    "color": color,
    "doors": doors,
  };

  bool get isEmpty => brand == null && model == null && line == null && plate == null && color == null && doors == null;
}