part of 'new_trip_cubit.dart';

class NewTripState{
  const NewTripState({required this.vehicles, required this.newTripModel, this.toU = true, this.submitted = false});
  final NewTripModel newTripModel;
  final bool submitted, toU;
  final List<Vehicle> vehicles;

  factory NewTripState.initial(List<Vehicle> vehicles) => NewTripState(vehicles: vehicles, newTripModel: NewTripModel.initial());

  AutovalidateMode get autoValidateMode => submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled;

  bool get isValid => cityValidator(newTripModel.city?.nameFormat) == null
  && targetValidator(newTripModel.target) == null
  && vehicleValidator(newTripModel.vehicleId) == null
  && seatsValidator(newTripModel.availableSeats.toString()) == null
  && descriptionValidator(newTripModel.description) == null
  && departureValidator == true;

  NewTripState copyWith({bool? toU, Cities? city, String? target, String? description, DateTime? departureDate, String? departureTime, int? availableSeats, bool? submitted, List<Vehicle>? vehicles}) => NewTripState(
    newTripModel: NewTripModel(
      city: city ?? newTripModel.city,
      target: target ?? newTripModel.target,
      description: description ?? newTripModel.description,
      departureDate: departureDate ?? newTripModel.departureDate,
      departureTime: departureTime ?? newTripModel.departureTime,
      availableSeats: availableSeats ?? newTripModel.availableSeats,
      vehicle: this.vehicles[0]
    ),
    vehicles: this.vehicles,
    toU: toU ?? this.toU,
    submitted: submitted ?? this.submitted,
  );

  bool get departureValidator {
    final currentDT = DateTime.now();
    if (newTripModel.departureDate != null) {
      return newTripModel.departureDate!.isAfter(currentDT.add(Duration(minutes: toU ? 40: 10))) && newTripModel.departureDate!.isBefore(currentDT.add(const Duration(days: 7)));
    }
    return false;
  }

  String? cityValidator(String? value) => RegexComparison.selectionValidator(value, "Ciudad");

  String? targetValidator(String? value) => RegexComparison.selectionValidator(value, toU ? "Origen" : "Destino");

  String? vehicleValidator(String? value) => RegexComparison.selectionValidator(value, "Vehículo");

  String? seatsValidator(String? value) => RegexComparison.defaultValidator(value, "Asientos disponibles", RegexComparison.seatsRegExp);

  String? descriptionValidator(String? value) => RegexComparison.selectionValidator(value, "Descripción");

  @override
  String toString() => '$toU, ${newTripModel.toString()}';
}
