import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ucar_app/src/screens/wrappers/gps_access_screen.dart';

import '../../blocs/blocs.dart';
import '../../config/size_config.dart';
import '../../theme/themes.dart';
import '../../widgets/forms/driver_request_form.dart';
import '../wrappers/background.dart';

class DriverRequestScreen extends StatelessWidget {
  DriverRequestScreen({super.key});
  final DriverCubit cubit = DriverCubit();

  @override
  Widget build(BuildContext context) {
    return GpsAccessScreen(
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
              icon:const Icon(Icons.arrow_back_ios)
            ),
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
        ),
      ),
    );
  }

  List<Widget> _buildChildren(BuildContext context) => <Widget>[
    SvgPicture.asset("assets/icons/ucar_logo.svg", height: SizeConfig.displayHeight(context) * 0.15),
    Text("¡Estás cerca de ser un conductor!",
      style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.titleFontSize - 8, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
    ),
    BlocProvider<DriverCubit>(
      create: (context) => cubit,
      child: DriverRequestForm(cubit: cubit),
    )
  ];
}
