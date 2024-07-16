import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ucar_app/src/widgets/temporaries/dio_alert_dialog.dart';

import '../../blocs/blocs.dart';
import '../../config/size_config.dart';
import '../../helpers/helpers.dart';
import '../../models/vehicle.dart';
import '../../theme/themes.dart';
import '../../util/latlng_to_string.dart';
import '../../util/location_to_latlng.dart';
import '../../storage/auth_client.dart';
import '../wrappers/gps_access_screen.dart';

class MapScreenArgs{
  MapScreenArgs._({required this.visibleSheet, required this.vehicle, required this.tripModel, required this.directionsModel, required this.origin, required this.destination});
  final TripModel tripModel;
  final DirectionsModel? directionsModel;
  final LatLng origin, destination;
  final Vehicle vehicle;
  final bool visibleSheet; 
  static final DirectionsHelper _helper = DirectionsHelper();

  static Future<MapScreenArgs> create({required TripModel tripModel, required List<Location> locations, required bool visibleSheet}) async{
    final origin = locations[0].toLatLng();
    final destination = locations[1].toLatLng();
    final model = await _helper.fetchDirections(origin: origin.invertLatLng(), destination: destination.invertLatLng());
    final token = await AuthClient().accessToken;
    final vehicle = await TripsHelper().fetchVehicleFeatures(tripModel, token!);
    return MapScreenArgs._(tripModel: tripModel, directionsModel: model, origin: origin, destination: destination, vehicle: vehicle, visibleSheet: visibleSheet);
  }
}

class MapScreen extends StatelessWidget {
  MapScreen({super.key, required MapScreenArgs args}): _args = args, mapStyle = CustomMapStyle();
  static const String _origin = "origin", _destination = "destination";
  final CustomMapStyle mapStyle;
  final MapScreenArgs _args;

  final MarkerId _originMarkerId = const MarkerId(_origin), _destinationMarkerId = const MarkerId(_destination);

  @override
  Widget build(BuildContext context) {
    return GpsAccessScreen(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("${_args.tripModel.origin} - ${_args.tripModel.destination}".replaceAll(RegExp(r"Universidad\sPontificia\sBolivariana(\sSeccional Bucaramanga)?"), "UPB"), style: const TextStyle(fontSize: Fontsizes.bodyTextFontSize + 1, color: MyColors.textWhite, fontWeight: FontWeight.bold)),
          backgroundColor: MyColors.purpleTheme,
          elevation: 0,
          leading: IconButton(onPressed: () => Navigator.pop<bool>(context, false), icon: const Icon(Icons.arrow_back_ios, color: MyColors.textWhite)),
        ),
        body: Stack(
          children: [
            GoogleMap(
              markers: <Marker>{
                Marker(markerId: _originMarkerId, position: _args.origin, icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed)),
                Marker(
                  markerId: _destinationMarkerId,
                  position: _args.destination,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
                  infoWindow: InfoWindow(
                    title: "${(_args.directionsModel!.distance / 1000).toStringAsFixed(2)} km",
                    snippet: "${_args.directionsModel?.duration} min.",
                    anchor: const Offset(0.5, 0)
                  ),
                )
              },
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              initialCameraPosition: mapStyle.initialCameraPosition,
              polylines: {
                if(_args.directionsModel != null) Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: MyColors.orangeDark,
                  width: 3,
                  points: _args.directionsModel!.coordinates
                )
              },
              onMapCreated: mapStyle.onMapCreated,
            ),
            Visibility(
              visible: _args.visibleSheet,
              child: _BottomDetailsSheet(_args.tripModel, _args.vehicle, _args.directionsModel)
            )
          ],
        ),
      ),
    );
  }
}

class _BottomDetailsSheet extends StatelessWidget {
  const _BottomDetailsSheet(this.tripModel, this.vehicle, this.directionsModel);
  static const double _initialChildSize = 0.45;
  static const TextStyle _textStyle = TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.smallTextFontSize + 1, fontWeight: FontWeight.bold);
  static const Radius _radius = Radius.circular(6);
  final TripModel tripModel;
  final Vehicle vehicle;
  final DirectionsModel? directionsModel;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: _initialChildSize,
      maxChildSize: _initialChildSize,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: SizeConfig.displayWidth(context) * 0.02),
          padding: EdgeInsets.all(SizeConfig.displayWidth(context) * 0.03),
          decoration: BoxDecoration(color: MyColors.backgroundCard, borderRadius: _sheetRadius()),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                controller: scrollController,
                children: [draggableSheetInfo(), Text(tripModel.description, style: const TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.bodyTextFontSize))],
              ),
              Container(
                decoration: const BoxDecoration(color: MyColors.backgroundCard),
                padding: EdgeInsets.all(SizeConfig.displayWidth(context) * 0.01),
                width: double.infinity,
                child: FloatingActionButton.extended(
                  foregroundColor: MyColors.textWhite,
                  backgroundColor: MyColors.backgroundBlue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: const BorderSide(color: MyColors.backgroundBlue)),
                  onPressed: () async{
                    try {
                      final bool result = await Future.value(true); //REEMPLAZAR POR FUNCIÓN DE RESERVAR CUPO
                      if (result == true && context.mounted) {
                        Navigator.pop<bool>(context, true);
                      }
                    } on DioException catch (e) {
                      if (context.mounted) {
                        DioAlertDialog.fromDioException(context, e);
                      }
                    }
                  },
                  label: const Text("Apartar mi cupo", style: TextStyle(fontSize: Fontsizes.subTitleFontSize))
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  BorderRadius _sheetRadius() => const BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12));

  StatelessWidget draggableSheetInfo() {
    return ListTile(
      title: Text(tripModel.driverName),
      titleTextStyle: _textStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize, color: MyColors.textWhite),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(!vehicle.isEmpty ? "${vehicle.brand} ${vehicle.model} ${vehicle.line} ${vehicle.color}" : vehicle.defaultText, style: _textStyle.copyWith(color: MyColors.backgroundBlue, fontSize: Fontsizes.bodyTextFontSize)),
          Text("${tripModel.availablePlaces} cupos", style: _textStyle)
        ],
      ),
      subtitleTextStyle: _textStyle,
      trailing: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center, height: 40, width: 70,
              decoration: const BoxDecoration(color: MyColors.yellow, borderRadius: BorderRadius.all(_radius)),
              child: Container(
                alignment: Alignment.center, height: 36, width: 66,
                decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: MyColors.primary), borderRadius: const BorderRadius.all(_radius)),
                child: Text(!vehicle.isEmpty ? vehicle.plate! : vehicle.defaultText, style: const TextStyle(color: MyColors.primary, fontWeight: FontWeight.bold, fontSize: Fontsizes.bodyTextFontSize)),
              ),
            ),
            Text(tripModel.departureTime, style: _textStyle.copyWith(fontSize: Fontsizes.smallTextFontSize))
          ],
        ),
      ),
    );
  }
}