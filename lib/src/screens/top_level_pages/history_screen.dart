import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ucar_app/src/models/vehicle.dart';

import '../../blocs/blocs.dart';
import '../../components/cards/history_card.dart';
import '../../components/shimmer_card.dart';
import '../../config/size_config.dart';
import '../../routes/app_router.dart';
import '../../theme/themes.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key, required this.isDriver});
  final ScrollController scrollController = ScrollController();
  final bool isDriver;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  @override
  void initState() {
    super.initState();
    bloc.add(const GetHistoryToU());
  }

  int buttonIndex = 0;
  HistoryBloc get bloc => BlocProvider.of<HistoryBloc>(context);
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) => RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          if (context.mounted && state is! HistoryLoading) reload();
        },
        displacement: 50.0,
        color: MyColors.textGrey,
        backgroundColor: MyColors.purpleTheme,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: SizeConfig.displayHeight(context) * 0.015, horizontal: SizeConfig.displayWidth(context) / 19.5),
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
                        bloc.add(buttonIndex == 0 ? const GetHistoryToU() : const GetHistoryFromU());
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
    );
  }

  Widget scrollable(BuildContext context, HistoryState current){
    if (current is HistoryLoading){
      return SliverList(delegate: SliverChildBuilderDelegate((context, index) => const ShimmerCard(), childCount: 4));
    }else if (current is HistoryReturned){
      if (current.tripList.isEmpty) {
        return SliverToBoxAdapter(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: SizeConfig.displayHeight(context) * 0.15, horizontal: SizeConfig.displayWidth(context) * 0.1),
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: Colors.transparent
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.dataset_outlined, color: MyColors.textGrey, size: 50),
                Text("Aún no hay viajes ${buttonIndex == 0 ? 'hacia' : 'desde'} la universidad en tu historial.", style: const TextStyle(color: MyColors.textGrey, fontWeight: FontWeight.bold, fontSize: Fontsizes.subTitleFontSize), textAlign: TextAlign.justify),
                newTripButton(context)
              ],
            ),
          ),
        );
      }
      final currentDT = DateTime.now();
      return SliverList.list(children: [
        newTripButton(context),
        ...List<HistoryCard>.generate(current.tripList.length, (index) => HistoryCard(historyModel: current.tripList[index],currentDateTime: currentDT))
        ]
      );
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
              IconButton(iconSize: 50, onPressed: () => bloc.add(buttonIndex == 0 ? const GetHistoryToU() : const GetHistoryFromU()), icon: const Icon(Icons.refresh_rounded), color: MyColors.textGrey),
              Text("${current.message}. Inténtalo de nuevo", style: const TextStyle(color: MyColors.textGrey, fontWeight: FontWeight.bold, fontSize: Fontsizes.subTitleTwoFontSize), textAlign: TextAlign.center),
            ],
          ),
        ),
      );
    }else{
      return Container();
    }
  }

  Widget newTripButton(BuildContext context) => Visibility(
    visible: widget.isDriver,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: FloatingActionButton.extended(
        onPressed: () async{
          bool? result;
          final List<Vehicle> vehicles = await bloc.vehicles();
          if (context.mounted) {
            vehicles.isNotEmpty
            ? result = await Navigator.pushNamed(context, AppRouter.newTrip, arguments: vehicles)
            : ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text("Error en la carga del formulario. Inténtalo más tarde", style: TextStyle(color: MyColors.textWhite)), backgroundColor: Colors.red.shade400));
          }
          if (result == true && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Viaje creado", style: TextStyle(color: MyColors.textWhite)), backgroundColor: MyColors.success,
                action: SnackBarAction(label: "Recargar página", textColor: MyColors.backgroundBlue, backgroundColor: MyColors.textWhite, onPressed: () => reload()),
              )
            );
          }
        },
        backgroundColor: MyColors.purpleTheme,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32), side: const BorderSide(color: MyColors.textWhite)),
        label: const Text("Nuevo viaje", style: TextStyle(color: MyColors.textWhite, fontWeight: FontWeight.bold, fontSize: Fontsizes.subTitleTwoFontSize)),
        icon: const Icon(Icons.route, color: MyColors.textWhite),
      ),
    ),
  );

  void reload() => bloc.add(buttonIndex == 0 ? const GetHistoryToU() : const GetHistoryFromU());
}