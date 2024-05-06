import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../config/size_config.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  final _initialCameraPosition = const CameraPosition(
    target: LatLng(7.037584, -73.072450),
    zoom: 15
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: SizeConfig.displayWidth(context) * 0.8,
          height: SizeConfig.displayWidth(context) * 0.8,
          child: GoogleMap(initialCameraPosition: _initialCameraPosition),
        ),
      ),
    );
  }
}