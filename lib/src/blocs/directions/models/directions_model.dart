import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsModel {
  List<double> _bbox;
  Features _features;

  DirectionsModel._({required List<double> bbox, required Features features}) : _features = features, _bbox = bbox;

  factory DirectionsModel.fromJson(Map<String, dynamic> json) => DirectionsModel._(
    bbox: List<double>.from(json["bbox"].map((x) => x?.toDouble())),
    features: Features.fromJson(json["features"][0]),
  );

  double get distance => _features.summary.distance;
  int get duration => (_features.summary.duration.floor()/60).round();
  List<double> get bbox => _bbox;
  List<LatLng> get coordinates => _features.coordinates;
}

class Features {
  final Summary summary;
  final List<LatLng> coordinates;

  Features._({required this.summary, required this.coordinates});

  factory Features.fromJson(Map<String, dynamic> json) => Features._(
    summary: Summary.fromJson(json["properties"]["summary"]),
    coordinates: List<LatLng>.from(json["geometry"]["coordinates"].map((x) => LatLng(x[1], x[0]))),
  );
}

class Summary {
  final double distance;
  final double duration;

  Summary._({required this.distance, required this.duration});

  factory Summary.fromJson(Map<String, dynamic> json) => Summary._(
    distance: json["distance"]?.toDouble(),
    duration: json["duration"]?.toDouble(),
  );
}
