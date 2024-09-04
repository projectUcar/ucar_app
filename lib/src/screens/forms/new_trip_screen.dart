import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../models/vehicle.dart';
import '../../theme/themes.dart';
import '../../widgets/forms/new_trip_form.dart';
import '../wrappers/background.dart';
import '../wrappers/gps_access_screen.dart';

class NewTripScreen extends StatelessWidget {
  NewTripScreen({super.key, required this.vehicles}): cubit = NewTripCubit();
  final NewTripCubit cubit;
  final List<Vehicle> vehicles;
  @override
  Widget build(BuildContext context) => GpsAccessScreen(
    child: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
      },
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("U-CAR", style: TextStyle(color: MyColors.purpleTheme, fontWeight: FontWeight.bold)),
          backgroundColor: MyColors.backgroundCard,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop<bool>(context, false);
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        ),
        body: Background(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _buildChildren(context),
            ),
          ),
        ),
      )
    )
  );

  List<Widget> _buildChildren(BuildContext context) => <Widget>[
    Text("Crea un nuevo recorrido",
      style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.titleFontSize - 8, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    BlocProvider<NewTripCubit>(
      create: (context) => cubit,
      child: NewTripForm(cubit: cubit, vehicles: vehicles),
    )
  ];
}
