part of 'directions_cubit.dart';

class DirectionsState{
  static const LatLng upbLocation = LatLng(7.037584, -73.072450);

  const DirectionsState._({required this.toUniversity, required this.target, required this.directions});
  final bool? toUniversity;
  final LatLng? target;
  final DirectionsModel? directions;

  factory DirectionsState.initialState() => const DirectionsState._(toUniversity: null, target: null, directions: null);

  DirectionsState copyWith({bool? toUniversity, LatLng? target, DirectionsModel? directionsModel}) => DirectionsState._(
    toUniversity: toUniversity ?? this.toUniversity,
    target: target ?? this.target,
    directions: directionsModel ?? directions
  );

  bool get nullAttributes => toUniversity == null && target == null && directions == null;
}