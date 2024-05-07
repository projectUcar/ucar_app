import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../blocs/blocs.dart';
import '../theme/themes.dart';
class MapScreen extends StatelessWidget {
  MapScreen({super.key, required this.tripModel}): mapStyle = CustomMapStyle();

  final TripModel tripModel;
  final CustomMapStyle mapStyle;
  final _initialCameraPosition = const CameraPosition(
    target: LatLng(7.037584, -73.072450),
    zoom: 15
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${tripModel.origin} - ${tripModel.destination}", style: const TextStyle(fontSize: Fontsizes.subTitleTwoFontSize),)),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: mapStyle.onMapCreated,
      ),
    );
  }
}