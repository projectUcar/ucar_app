part of 'driver_cubit.dart';
class DriverState{
  const DriverState({required this.vehicle, required this.docValue, required this.documentType, this.submitted = false});

  final String documentType;
  final String? docValue;
  final Vehicle vehicle;
  final bool submitted;

  factory DriverState.initial() => DriverState(
    documentType: DocumentTypes.cc.name,
    docValue: null,
    vehicle: Vehicle.empty(),
  );

  Map<String, dynamic> driverToJson() => {
    "documentType": documentType,
    "documentNumber": docValue
  };

  String? docTypeValidator(String? s) => RegexComparison.selectionValidator(s, "Tipo de Documento");
  String? docNumberValidator(String? s) => RegexComparison.defaultValidator(s, "Documento", documentType == DocumentTypes.nit.name ? RegexComparison.nitRegExp : RegexComparison.ccOrTiRegExp);
  String? brandValidator(String? s) => RegexComparison.defaultValidator(s, "Marca", RegexComparison.brandRegExp);
  String? modelValidator(String? s) => RegexComparison.defaultValidator(s, "Modelo", RegexComparison.modelRegExp);
  String? lineValidator(String? s) => RegexComparison.defaultValidator(s, "Línea", RegexComparison.lineRegExp);
  String? plateValidator(String? s) => RegexComparison.defaultValidator(s, "Placa", RegexComparison.plateRegExp);
  String? colorValidator(String? s) => RegexComparison.defaultValidator(s, "Color", RegexComparison.lineRegExp);
  String? seatsValidator(String? s) => RegexComparison.defaultValidator(s, "Asientos", RegexComparison.seatsRegExp);
  String? doorsValidator(String? s) => RegexComparison.defaultValidator(s, "Puertas", RegexComparison.doorsRegExp);
  
  bool get docTypeIsValid => docTypeValidator(documentType) == null;
  bool get docNumberIsValid => docNumberValidator(docValue) == null;
  bool get ownerDocTypeIsValid => docTypeValidator(vehicle.documentTypeOwner) == null;
  bool get ownerDocNumberIsValid => docNumberValidator(vehicle.documentNumberOwner) == null;
  bool get brandIsValid => brandValidator(vehicle.brand) == null;
  bool get modelIsValid => modelValidator(vehicle.model) == null;
  bool get lineIsValid => lineValidator(vehicle.line) == null;
  bool get plateIsValid => plateValidator(vehicle.plate) == null;
  bool get colorIsValid => colorValidator(vehicle.color) == null;
  bool get seatsIsValid => seatsValidator(vehicle.seats.toString()) == null;
  bool get doorsIsValid => doorsValidator(vehicle.doors.toString()) == null;

  bool get isValid => docTypeIsValid && docNumberIsValid && ownerDocTypeIsValid && ownerDocNumberIsValid && brandIsValid && modelIsValid && lineIsValid && plateIsValid && colorIsValid && seatsIsValid && doorsIsValid;

  DriverState copyWith({String? documentType, String? docValue, String? brand, String? model, String? line, String? plate, String? color, String? documentNumberOwner,
  int? doors, int? seats, bool? isOwner, String? documentTypeOwner, bool? submitted}) => DriverState(
    documentType: documentType ?? this.documentType,
    docValue: docValue ?? this.docValue,
    vehicle: Vehicle(
      brand: brand ?? vehicle.brand,
      model: model ?? vehicle.model,
      line: line ?? vehicle.line,
      plate: plate ?? vehicle.plate,
      color: color ?? vehicle.color,
      seats: seats ?? vehicle.seats,
      doors: doors ?? vehicle.doors,
      isOwner: isOwner ?? vehicle.isOwner,
      documentTypeOwner: documentTypeOwner ?? vehicle.documentTypeOwner,
      documentNumberOwner: documentNumberOwner ?? vehicle.documentNumberOwner
    ),
    submitted: submitted ?? this.submitted
  );

  AutovalidateMode get autoValidateMode => submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled;
}


