part of 'pass_home.dart';

class RoutesByCities extends StatefulWidget {

  const RoutesByCities({super.key});

  @override
  State<RoutesByCities> createState() => _RoutesByCitiesState();
}

class _RoutesByCitiesState extends State<RoutesByCities> {
  
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TripsBloc>(context).add(const GetTripsToU());
  }

  int buttonIndex = 0;

  TextStyle get bodyStyle => CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize);
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<TripsBloc, TripsState>(
      listener: (context, state) {},
      child: BlocBuilder<TripsBloc, TripsState>(
        builder: (context, state) => RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            if (context.mounted && state is! TripsLoading) BlocProvider.of<TripsBloc>(context).add(buttonIndex == 0 ? const GetTripsToU() : const GetTripsFromU());
          },
          displacement: 50.0,
          color: MyColors.textGrey,
          backgroundColor: MyColors.purpleTheme,
          child: CustomScrollView(
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
                          refresh(() => buttonIndex = newSelection.first);
                          BlocProvider.of<TripsBloc>(context).add(buttonIndex == 0 ? const GetTripsToU() : const GetTripsFromU());
                        },
                      );
                    }
                  ),
                )
              ),
              scrollable(context, state)
            ],
          ),
        )
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
              IconButton(iconSize: 50, onPressed: () => BlocProvider.of<TripsBloc>(context).add(buttonIndex == 0 ? const GetTripsToU() : const GetTripsFromU()), icon: const Icon(Icons.refresh_rounded), color: MyColors.textGrey),
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