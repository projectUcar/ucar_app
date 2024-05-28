import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ucar_app/src/widgets/temporaries/async_progress_dialog.dart';
import '../wrappers/gps_access_screen.dart';
import 'map_screen.dart';
import '../../theme/themes.dart';
import '../../routes/app_router.dart';
import '../../blocs/blocs.dart';

class DetailedCityRoutesArgs{
  final List<TripModel> _tripsList;
  final String _cityName;

  DetailedCityRoutesArgs({required List<TripModel> tripsList, required String cityName}) : _cityName = cityName, _tripsList = tripsList;

  List<TripModel> get tripsList => _tripsList;
  String get cityName => _cityName;
}

class DetailedCityRoutes extends StatelessWidget {
  const DetailedCityRoutes({super.key, required this.args});
  final DetailedCityRoutesArgs args;

  @override
  Widget build(BuildContext context) {
    return GpsAccessScreen(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(onPressed: () => Navigator.of(context).pop(), icon: const Icon(Icons.arrow_back_ios, color: MyColors.textWhite),),
            pinned: true,
            expandedHeight: 200,
            centerTitle: true,
            title: Text(args.cityName, style: const TextStyle(fontSize: Fontsizes.titleFontSize - 10, color: MyColors.textGrey, fontWeight: FontWeight.bold)),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: MyColors.secondary,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                    image: AssetImage("assets/images/${args.cityName.toLowerCase().replaceAll(RegExp("ó"), "o")}.png")
                  )
                ),
              )
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
          ),
          SliverList(delegate: SliverChildBuilderDelegate((context, index) => _TripCard(model: args.tripsList[index]), childCount: args.tripsList.length))
        ],
      ),
    );
  }
}

class _TripCard extends StatelessWidget {
  const _TripCard({required this.model});
  static const _upbVal = "Universidad Pontificia Bolivariana";
  final TripModel model;

  Color get bookingColor {
    if (model.availableSeats > 0) {
      return MyColors.orangeDark;
    }
    else{
      return MyColors.backgroundSvg;
    }
  }

  Widget _placeWrapper(String place) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: place.contains(_upbVal) ? MyColors.backgroundBlue: MyColors.success,
      ),
      child: Text(place.contains(_upbVal) ? "UPB" : place, style: const TextStyle(fontSize: Fontsizes.subTitleTwoFontSize, color: MyColors.textWhite, fontWeight: FontWeight.bold)),
    );
  }
  
  Widget routeRendering() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _placeWrapper(model.origin),
          const Icon(Icons.double_arrow_sharp, color: MyColors.textGrey),
          _placeWrapper(model.destination)
        ]
      ),
    );
  }

  Future<List<Location>> get locations async{
    final originLocation = await locationFromAddress("${model.origin}${(model.toUniversity) ? ", ${model.city}, Santander, Colombia": addressFormat(model.origin)}").then((value) => value.first);
    final destinationLocation = await locationFromAddress("${model.destination}${(!model.toUniversity) ? ", ${model.city}, Santander, Colombia": addressFormat(model.destination)}").then((value) => value.first);
    return [originLocation, destinationLocation];
  }

  String addressFormat(String address) {
    const String plusString = "Seccional Bucaramanga";
    return address.contains(plusString) ? "" : " $plusString";
  }@override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        backgroundColor: MyColors.backgroundSvg.withOpacity(0.3),
        collapsedBackgroundColor: MyColors.backgroundSvg.withOpacity(0.3),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 4),
        textColor: MyColors.textGrey,
        title: routeRendering(),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [const Icon(Icons.person_outline, size: 15, color: MyColors.textGrey), Text(" ${model.driverName}", style: const TextStyle(color: MyColors.textGrey))]),
            Row(children: [const Icon(Icons.watch_later_outlined, size: 15, color: MyColors.textGrey), Text(' ${model.departureDate.day}/${model.departureDate.month}/${model.departureDate.year} - ${model.departureTime}', style: const TextStyle(color: MyColors.textGrey))])
          ],
        ),
        children: <Widget>[
          Text(model.description, style: const TextStyle(color: MyColors.textGrey)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                onPressed: () async{
                  AsyncProgressDialog.show(context);
                  List<Location> current = await locations;
                  MapScreenArgs args = await MapScreenArgs.create(tripModel: model, locations: current);
                  if (context.mounted) {
                    AsyncProgressDialog.dismiss(context);
                    Navigator.pushNamed(context, AppRouter.tripMap, arguments: args);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      Color detailColor = MyColors.purpleTheme;
                      if (states.contains(MaterialState.pressed)) {
                        return detailColor.withOpacity(0.5);
                      }
                      return detailColor;
                    },
                  ),
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(10)))),
                ),
                icon: const Icon(Icons.text_snippet_outlined, color: MyColors.textWhite),
                label: const Text("Detalles", style: TextStyle(color: MyColors.textWhite, fontWeight: FontWeight.bold))
              ),
              TextButton.icon(
                onPressed: model.availableSeats != 0 
                  ? () {
                  
                  }
                  : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return bookingColor.withOpacity(0.5);
                      }
                      return bookingColor;
                    },
                  ),
                  shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10)))),
                ),
                icon: const Icon(Icons.send_sharp, color: MyColors.textWhite),
                label: const Text("Reservar", style: TextStyle(color: MyColors.textWhite, fontWeight: FontWeight.bold))
              )
            ].map((e) => Expanded(child: e)).toList(),
          ),
        ],
      ),
    );
  }
}