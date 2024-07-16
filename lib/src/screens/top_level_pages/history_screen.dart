import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:ucar_app/src/blocs/blocs.dart';

import '../../components/shimmer_card.dart';
import '../../config/size_config.dart';
import '../../routes/app_router.dart';
import '../../theme/themes.dart';
import '../../widgets/temporaries/async_progress_dialog.dart';
import '../medium_level_pages/map_screen.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});
  final ScrollController scrollController = ScrollController();

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<HistoryBloc>(context).add(const GetHistoryToU());
  }

  int buttonIndex = 0;
  

  @override
  Widget build(BuildContext context) {
    return BlocListener<HistoryBloc, HistoryState>(
      listener: (context, state) {
        
      },
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) => RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            if (context.mounted && state is! HistoryLoading) BlocProvider.of<HistoryBloc>(context).add(buttonIndex == 0 ? const GetHistoryToU() : const GetHistoryFromU());
          },
          displacement: 50.0,
          color: MyColors.textGrey,
          backgroundColor: MyColors.purpleTheme,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: SizeConfig.displayHeight(context) * 0.015, left: SizeConfig.displayWidth(context) / 19.5, right: SizeConfig.displayWidth(context) / 19.5),
                  child: StatefulBuilder(
                    builder: (context, refresh) {
                      return SegmentedButton<int>(
                        segments: <ButtonSegment<int>>[
                          ButtonSegment(
                            value: 0,
                            icon: const Icon(Icons.school_rounded, color: MyColors.purpleTheme),
                            label: const Text("UPB", style: TextStyle(color: MyColors.purpleTheme)),
                            enabled: state is! HistoryLoading
                          ),
                          ButtonSegment(
                            value: 1,
                            icon: const Icon(Icons.home_rounded, color: MyColors.purpleTheme),
                            label: const Text("Casa", style: TextStyle(color: MyColors.purpleTheme)),
                            enabled: state is! HistoryLoading
                          )
                        ],
                        selected: <int>{buttonIndex},
                        onSelectionChanged: (newSelection) {
                          refresh(() => buttonIndex = newSelection.first);
                          BlocProvider.of<HistoryBloc>(context).add(buttonIndex == 0 ? const GetHistoryToU() : const GetHistoryFromU());
                        },
                      );
                    }
                  ),
                ),
              ),
              scrollable(context, state)
            ],
          ),
        ),
      )
    );
  }

  Widget scrollable(BuildContext context, HistoryState current){
    if (current is HistoryLoading){
      return SliverList(delegate: SliverChildBuilderDelegate((context, index) => const ShimmerCard(), childCount: 4));
    }else if (current is HistoryReturned){
      if (current.tripList.isEmpty) {
        return SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: SizeConfig.displayHeight(context) * 0.2, horizontal: SizeConfig.displayWidth(context) * 0.1),
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.transparent
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.dataset_outlined, color: MyColors.textGrey, size: 50),
                Text("Aún no hay viajes ${buttonIndex == 0 ? 'hacia' : 'desde'} la universidad en tu historial.", style: const TextStyle(color: MyColors.textGrey, fontWeight: FontWeight.bold, fontSize: Fontsizes.subTitleFontSize), textAlign: TextAlign.justify),
              ],
            ),
          ),
        );
      }
      final currentDT = DateTime.now();
      return SliverList.list(children: List<HistoryCard>.generate(current.tripList.length, (index) => HistoryCard(tripModel: current.tripList[index],currentDateTime: currentDT)));
    }else if (current is HistoryError){
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: SizeConfig.displayHeight(context) * 0.2, horizontal: SizeConfig.displayWidth(context) * 0.1),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.purpleTheme, width: 5),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: MyColors.purpleTheme.withOpacity(0.2),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(iconSize: 50, onPressed: () => BlocProvider.of<HistoryBloc>(context).add(buttonIndex == 0 ? const GetHistoryToU() : const GetHistoryFromU()), icon: const Icon(Icons.refresh_rounded), color: MyColors.textGrey),
              Text("${current.message}. Inténtalo de nuevo", style: const TextStyle(color: MyColors.textGrey, fontWeight: FontWeight.bold, fontSize: Fontsizes.subTitleTwoFontSize), textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }else{
      return Container();
    }
  }
}

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key, required this.tripModel, required this.currentDateTime});
  static const _upbVal = "Universidad Pontificia Bolivariana";
  final TripModel tripModel;
  final DateTime currentDateTime;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          decoration: BoxDecoration(
            color: tripModel.fullDateTime.isAfter(currentDateTime) ? MyColors.orangeDark : MyColors.purpleTheme,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Text(
            tripModel.formatDT,
            style: const TextStyle(color: MyColors.primary, fontSize: Fontsizes.bodyTextFontSize, fontWeight: FontWeight.bold)
          ),
        ),
        Divider(color: tripModel.fullDateTime.isAfter(currentDateTime) ? MyColors.orangeDark : MyColors.purpleTheme),
        ListTile(
          title: routeRendering(),
          subtitle: Column(
            children: [
              Row(
                children: [
                  const ImageIcon(AssetImage('assets/images/steering.png'), color: MyColors.yellow, size: 20),
                  Text(tripModel.driverName, style: const TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.bodyTextFontSize), textAlign: TextAlign.start)
                ]
              ),
              Row(
                children: [
                  const Icon(Icons.reduce_capacity_sharp, color: MyColors.yellow, size: 20),
                  Text('Pasajeros: ${tripModel.passengers.length} | Cupos: ${tripModel.availableSeats}', style: const TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.bodyTextFontSize), textAlign: TextAlign.start)
                ]
              )
            ],
          ),
          trailing: tripModel.fullDateTime.isAfter(currentDateTime) ? IconButton(
            onPressed: () async {
              AsyncProgressDialog.show(context);
              try {
                List<Location> current = await locations;
                MapScreenArgs args = await MapScreenArgs.create(tripModel: tripModel, locations: current, visibleSheet: false);
                if (context.mounted) {
                  AsyncProgressDialog.dismiss(context);
                  Navigator.pushNamed(context, AppRouter.tripMap, arguments: args);
                }
              } on PlatformException {
                if (context.mounted) {
                  AsyncProgressDialog.dismiss(context);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Error al cargar el mapa. Inténtalo más tarde.", style: TextStyle(color: MyColors.textWhite)),
                    backgroundColor: MyColors.purpleTheme,
                  ));
                }
              }
            },
            icon: const Icon(Icons.location_on, color: MyColors.backgroundBlue, size: 40),
          ): null,
        ),
      ],
    ),
  );

  Widget _placeWrapper(String place) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: place.contains(_upbVal) ? MyColors.backgroundBlue: MyColors.success,
      ),
      child: Text(place.contains(_upbVal) ? "UPB" : place, style: const TextStyle(fontSize: Fontsizes.bodyTextFontSize, color: MyColors.textWhite, fontWeight: FontWeight.bold)),
    );
  }
  
  Widget routeRendering() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _placeWrapper(tripModel.origin),
          const Icon(Icons.double_arrow_sharp, color: MyColors.textGrey),
          _placeWrapper(tripModel.destination)
        ]
      ),
    );
  }

  Future<List<Location>> get locations async{
    final originLocation = await locationFromAddress("${tripModel.origin}${(tripModel.toUniversity) ? ", ${tripModel.city}, Santander, Colombia": addressFormat(tripModel.origin)}").then((value) => value.first);
    final destinationLocation = await locationFromAddress("${tripModel.destination}${(!tripModel.toUniversity) ? ", ${tripModel.city}, Santander, Colombia": addressFormat(tripModel.destination)}").then((value) => value.first);
    return [originLocation, destinationLocation];
  }

  String addressFormat(String address) {
    const String plusString = "Seccional Bucaramanga";
    return address.contains(plusString) ? "" : " $plusString";
  }
}