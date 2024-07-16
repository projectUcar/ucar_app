part of 'new_trip_cubit.dart';

class NewTripState{
  const NewTripState({required this.newTripModel, this.toU = true, this.submitted = false});
  final NewTripModel newTripModel;
  final bool submitted, toU;

  factory NewTripState.initial() => NewTripState(newTripModel: NewTripModel.empty());

  AutovalidateMode get autoValidateMode => submitted ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled;

  bool get isValid => cityValidator(newTripModel.city.nameFormat) == null
  && targetValidator(newTripModel.target) == null
  && vehicleValidator(newTripModel.vehicleId) == null
  && seatsValidator(newTripModel.availableSeats.toString()) == null;

  NewTripState copyWith({bool? toU, Cities? city, String? target, String? description, DateTime? departureDate, String? departureTime, String? vehicleId, int? availableSeats, bool? submitted}) => NewTripState(
    newTripModel: NewTripModel(
      city: city ?? newTripModel.city,
      target: target ?? newTripModel.target,
      description: description ?? newTripModel.description,
      departureDate: departureDate ?? newTripModel.departureDate,
      departureTime: departureTime ?? newTripModel.departureTime,
      availableSeats: availableSeats ?? newTripModel.availableSeats,
      vehicleId: vehicleId ?? newTripModel.vehicleId
    ),
    toU: toU ?? this.toU,
    submitted: submitted ?? this.submitted
  );

  

  String? cityValidator(String? value) => RegexComparison.selectionValidator(value, "Ciudad");

  String? targetValidator(String? value) => RegexComparison.selectionValidator(value, toU ? "Origen" : "Destino");

  String? vehicleValidator(String? value) => RegexComparison.selectionValidator(value, "Vehículo");

  String? seatsValidator(String? value) => RegexComparison.defaultValidator(value, "Asientos disponibles", RegexComparison.seatsRegExp);

  String? descriptionValidator(String? value) {
  }
}
