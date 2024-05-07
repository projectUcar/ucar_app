import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/blocs.dart';
import '../../components/container_background.dart';
import '../../components/shimmer_card.dart';
import '../../config/size_config.dart';
import '../../routes/app_router.dart';
import '../../theme/themes.dart';
import '../../widgets/container_list.dart';
import 'detailed_routes.dart';

class RoutesByCities extends StatefulWidget {

  const RoutesByCities({super.key, required TripsBloc bloc}): _bloc = bloc;

  final TripsBloc _bloc;
  @override
  State<RoutesByCities> createState() => _RoutesByCitiesState();
}

class _RoutesByCitiesState extends State<RoutesByCities> {
  
  @override
  void initState() {
    super.initState();
    widget._bloc.add(const GetTripsToU());
  }

  int buttonIndex = 0;

  TextStyle get bodyStyle => CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => widget._bloc,
      child: BlocListener<TripsBloc, TripsState>(
        listener: (context, state) {},
        child: BlocBuilder<TripsBloc, TripsState>(
          builder: ((context, state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: SizeConfig.displayHeight(context) * 0.015),
                    child: StatefulBuilder(
                      builder: (context, refresh) {
                        return SegmentedButton<int>(
                          segments: <ButtonSegment<int>>[
                            ButtonSegment(
                              value: 0,
                              icon: const Icon(Icons.school_rounded, color: MyColors.purpleTheme),
                              label: const Text("UPB", style: TextStyle(color: MyColors.purpleTheme),),
                              enabled: state is! TripsLoading
                            ),
                            ButtonSegment(
                              value: 1,
                              icon: const Icon(Icons.home_rounded, color: MyColors.purpleTheme),
                              label: const Text("Casa", style: TextStyle(color: MyColors.purpleTheme),),
                              enabled: state is! TripsLoading
                            )
                          ],
                          selected: <int>{buttonIndex},
                          onSelectionChanged: (newSelection) {
                            widget._bloc.add(buttonIndex == 0 ? const GetTripsFromU() : const GetTripsToU());
                            refresh(() => buttonIndex = newSelection.first);
                          },
                        );
                      }
                    ),
                  )
                ),
                scrollable(context, state)
              ],
            );
          })
        ),
      ),
    );
  }

  Widget scrollable(BuildContext context, TripsState current){
    if (current is TripsLoading){
      return SliverList(delegate: SliverChildBuilderDelegate((context, index) => const ShimmerCard(), childCount: 4));
    }else if (current is TripsReturned){
      return SliverList(delegate: SliverChildBuilderDelegate((context, index) => CityCard(model: current.citiesList[index], bodyStyle: bodyStyle), childCount: current.citiesList.length));
    }else if (current is TripsError){
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: SizeConfig.displayHeight(context) * 0.2),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.purpleTheme, width: 5),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(iconSize: 50, onPressed: () => widget._bloc.add(buttonIndex == 0 ? const GetTripsFromU() : const GetTripsToU()), icon: const Icon(Icons.refresh_rounded), color: MyColors.purpleTheme),
              Text("${current.message}. Inténtalo de nuevo", style: const TextStyle(color: MyColors.textGrey, fontWeight: FontWeight.bold, fontSize: Fontsizes.subTitleTwoFontSize), textAlign: TextAlign.justify),
            ],
          ),
        ),
      );
    }else{
      return Container();
    }
  }
}

class CityCard extends StatelessWidget {
  
  const CityCard({super.key, required this.model, required this.bodyStyle,});

  final CitySummaryModel model;
  final TextStyle bodyStyle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (model.numberRoutes > 0) {
          Navigator.pushNamed(context, AppRouter.cityDetail, arguments: DetailedCityRoutesArgs(tripsList: model.trips, cityName: model.cityName));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Aún no hay rutas disponibles para este lugar", style: TextStyle(color: MyColors.textWhite)),
              backgroundColor: MyColors.purpleTheme,
            )
          );
        }
      },
      icon: ContainerBackground(
        color: MyColors.backgroundCard,
        height: 136,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/icons/${model.cityName.toLowerCase().replaceAll(RegExp("ó"), "o")}-1.svg",
              height: 90,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  model.cityName,
                  style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.subTitleFontSize + 4, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon( Icons.person_pin, color: MyColors.success, size: 20),
                    Text(" ${model.numberDrivers} Conductores", style: bodyStyle, overflow: TextOverflow.ellipsis)
                  ]
                ),
                SizedBox(
                  width: SizeConfig.displayWidth(context) * 0.5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const Icon(Icons.alt_route_rounded, color: MyColors.orangeDark, size: 20),
                        Text(" ${model.numberRoutes} rutas |",style: bodyStyle, overflow: TextOverflow.ellipsis),
                        const Icon(Icons.local_play_sharp, color: MyColors.yellow, size: 20),
                        Text(" ${model.numberSeats} cupos", style: bodyStyle, overflow: TextOverflow.ellipsis),
                      ]
                    ),
                  ),
                ),
                ListContainer(destinations: model.places.toList())
              ],
            ),
          ],
        )
      ),
    );
  }
}