import 'package:flutter/material.dart';

import '../wrappers/gps_access_screen.dart';
import '../../blocs/blocs.dart';
import '../../theme/themes.dart';

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
        color: place == _upbVal ? MyColors.backgroundBlue: MyColors.success,
      ),
      child: Text(place == _upbVal ? "UPB" : place, style: const TextStyle(fontSize: Fontsizes.subTitleTwoFontSize, color: MyColors.textWhite, fontWeight: FontWeight.bold)),
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

  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyColors.backgroundCard,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ExpansionTile(
          backgroundColor: Colors.transparent,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                
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
                  ),
                  icon: const Icon(Icons.send_sharp, color: MyColors.textWhite),
                  label: const Text("Reservar", style: TextStyle(color: MyColors.textWhite, fontWeight: FontWeight.bold))
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}