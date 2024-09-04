import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../wrappers/background.dart';
import '../wrappers/gps_access_screen.dart';
import '../../blocs/blocs.dart';
import '../../components/shimmer_card.dart';
import '../../config/size_config.dart';
import '../../models/vehicle.dart';
import '../../theme/themes.dart';
class VehiclesScreen extends StatelessWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context) => GpsAccessScreen(
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("U-CAR", style: TextStyle(color: MyColors.purpleTheme, fontWeight: FontWeight.bold)),
        backgroundColor: MyColors.backgroundCard,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
          },
          icon:const Icon(Icons.arrow_back_ios, color: MyColors.purpleTheme)
        ),
      ),
      body: Background(child: BlocProvider<VehiclesBloc>(create: (context) => VehiclesBloc(), child: const _VehiclesBody())),
    )
  );
}

class _VehiclesBody extends StatefulWidget {
  const _VehiclesBody();

  @override
  State<_VehiclesBody> createState() => _VehiclesBodyState();
}

class _VehiclesBodyState extends State<_VehiclesBody> {

  VehiclesBloc get bloc => BlocProvider.of<VehiclesBloc>(context);

  @override
  void initState() {
    super.initState();
    bloc.add(FetchingEvent());
  }

  void reload() => bloc.add(FetchingEvent());

  @override
  Widget build(BuildContext context) => BlocBuilder<VehiclesBloc, VehiclesState>(
    builder: (context, state) {
      if (state is VehiclesFailed) {
        return Center(
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
                IconButton(iconSize: 50, onPressed: () => reload(), icon: const Icon(Icons.refresh_rounded), color: MyColors.textGrey),
                Text("${state.message}. Inténtalo de nuevo", style: const TextStyle(color: MyColors.textGrey, fontWeight: FontWeight.bold, fontSize: Fontsizes.subTitleTwoFontSize), textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      }
      else if (state is VehiclesReturned) {
        return RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(const Duration(seconds: 1));
            if (context.mounted && state is! HistoryLoading) reload();
          },
          displacement: 50.0,
          color: MyColors.textGrey,
          backgroundColor: MyColors.purpleTheme,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: List<Widget>.generate(state.vehicles.length, (index) => _vehicleTile(context, state.vehicles[index]))
          ),
        );
      }
      return ListView(
        padding: const EdgeInsets.all(16),
        children: List<Widget>.filled(4, const ShimmerCard())
      );
    },
  );

  Widget _vehicleTile(BuildContext context, Vehicle vehicle) => ListTile(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6),
      side: const BorderSide(color: MyColors.backgroundBlue, width: 1.5)
    ),
    tileColor: MyColors.backgroundBlue.withOpacity(0.2),
    title: Container(
      alignment: Alignment.center, height: SizeConfig.displayHeight(context) * 0.08, width: SizeConfig.displayWidth(context) * 0.1,
      decoration: BoxDecoration(color: MyColors.yellow, border: Border.all(color: MyColors.primary), borderRadius: BorderRadius.circular(6)),
      child: Text(vehicle.plate!, style: const TextStyle(color: MyColors.primary, fontWeight: FontWeight.bold, fontSize: Fontsizes.subTitleFontSize)),
    ),
    subtitle: Table(
      children: [
        TableRow(children: [const Text("Marca", style: _cellStyle), Text('${vehicle.brand}', style: _cellStyle)]),
        TableRow(children: [const Text("Línea", style: _cellStyle), Text('${vehicle.line}', style: _cellStyle)]),
        TableRow(children: [const Text("Color", style: _cellStyle), Text('${vehicle.color}', style: _cellStyle)]),
        TableRow(children: [const Text("Modelo", style: _cellStyle), Text('${vehicle.model}', style: _cellStyle)]),
        TableRow(children: [const Text("Puertas", style: _cellStyle), Text('${vehicle.doors}', style: _cellStyle)]),
        TableRow(children: [const Text("Asientos", style: _cellStyle), Text('${vehicle.seats! + 1}', style: _cellStyle)]),
      ],
    ),
  );

  static const TextStyle _cellStyle = TextStyle(color: MyColors.textGrey, fontSize: Fontsizes.bodyTextFontSize + 2, fontWeight: FontWeight.w700);

}