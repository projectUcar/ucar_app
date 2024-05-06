import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../config/size_config.dart';
import '../../theme/themes.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GpsBloc, GpsState>(
      builder: (context, state) {
        if (state.isAllReady) {
           return child;
        }else{
          return !state.enabledGPS ? const _EnambleGpsMessage() : const _AccessButton();
        }
      }
    );
  }
}

//Este screen se mostrará cuando el usuario no haya dado permiso de acceder al GPS
class _AccessButton extends StatelessWidget {
  const _AccessButton();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.displayWidth(context) * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lock_person_rounded, size: SizeConfig.displayWidth(context) * 0.4, color: MyColors.yellow),
            const Text("Permite que U-Car acceda a tu ubicación exacta", style: TextStyle(fontWeight: FontWeight.w800, color: MyColors.textGrey, fontSize: Fontsizes.subTitleFontSize), textAlign: TextAlign.justify),
            const Text("U-Car necesita tu ubicación precisa para brindarte indicaciones detalladas y otras funcionalidades útiles.",
              style: TextStyle(fontWeight: FontWeight.w800, color: MyColors.textGrey), textAlign: TextAlign.justify
            ),
            const Text("Sigue estos pasos", style: TextStyle(fontWeight: FontWeight.w800, color: MyColors.textGrey), textAlign: TextAlign.justify),
            const Text("1. Presiona el botón inferior.", style: TextStyle(fontWeight: FontWeight.w800, color: MyColors.textGrey), textAlign: TextAlign.justify),
            const Text("2. Selecciona Permitir solo con la app en uso.", style: TextStyle(fontWeight: FontWeight.w800, color: MyColors.textGrey), textAlign: TextAlign.justify),
            FloatingActionButton.extended(
              foregroundColor: MyColors.primary,
              backgroundColor: MyColors.purpleTheme,
              splashColor: Colors.transparent,
              onPressed: () {
                final gpsBloc = BlocProvider.of<GpsBloc>(context);
                gpsBloc.askGpsAccess();
              },
              label: Text('Solicitar acceso', style: CustomStyles.boldStyle.copyWith(fontSize: 20))
            )
          ],
        ),
      ),
    );
  }
}

//Este screen se mostrará cuando el usuario no tenga el GPS activo
class _EnambleGpsMessage extends StatelessWidget {
  const _EnambleGpsMessage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(SizeConfig.displayWidth(context) * 0.05, SizeConfig.displayHeight(context) * 0.1, SizeConfig.displayWidth(context) * 0.05, SizeConfig.displayHeight(context) * 0.45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.location_disabled_outlined, size: SizeConfig.displayWidth(context) * 0.4, color: MyColors.danger),
            const Text("¡Oops! Al parecer la ubicación de tu dispositivo se encuentra desactivada", style: TextStyle(fontWeight: FontWeight.w800, color: MyColors.textGrey, fontSize: Fontsizes.subTitleFontSize), textAlign: TextAlign.justify),
            const Text("Dirígete a Ajustes y actívala", style: TextStyle(fontWeight: FontWeight.w800, color: MyColors.textGrey), textAlign: TextAlign.justify)
          ],
        ),
      ),
    );
  }
}
