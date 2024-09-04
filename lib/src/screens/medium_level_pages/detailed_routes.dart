import 'package:flutter/material.dart';
import 'package:ucar_app/src/helpers/helpers.dart';
import '../../components/cards/trip_card.dart';
import '../wrappers/gps_access_screen.dart';
import '../../theme/themes.dart';
import '../../blocs/blocs.dart';

class DetailedCityRoutesArgs{
  final List<TripModel> _tripsList;
  final String _cityName;
  final TripsHelper helper = TripsHelper();

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
          SliverList(delegate: SliverChildBuilderDelegate((context, index) => TripCard(tripModel: args.tripsList[index], helper: args.helper), childCount: args.tripsList.length))
        ],
      ),
    );
  }
}