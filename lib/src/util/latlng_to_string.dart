import 'package:google_maps_flutter/google_maps_flutter.dart';

extension LatLngToString on LatLng{
  String invertLatLng() => '$longitude,$latitude';
}