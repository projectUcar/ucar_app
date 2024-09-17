import 'package:geocoding/geocoding.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../../blocs/blocs.dart';
import '../../helpers/helpers.dart';
import '../../routes/app_router.dart';
import '../../screens/medium_level_pages/medium_level_pages.dart';
import '../../theme/themes.dart';
import '../../widgets/temporaries/async_progress_dialog.dart';

class TripCard extends StatelessWidget{
  TripCard({super.key, required this.tripModel, required TripsHelper helper}): _helper = helper;
  
  final TripModel tripModel;
  final ValueNotifier<bool> _notifier = ValueNotifier(false);
  final TripsHelper _helper;
  
  Color get bookingColor {
    if (enabled) {
      return MyColors.orangeDark;
    }
    else{
      return MyColors.backgroundSvg;
    }
  }

  bool get enabled => tripModel.availableSeats == 0 && _notifier.value == false;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        backgroundColor: MyColors.backgroundSvg.withOpacity(0.5),
        collapsedBackgroundColor: MyColors.backgroundSvg.withOpacity(0.5),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 4),
        textColor: MyColors.textGrey,
        title: Center(child: Text(tripModel.titleFormat, style: const TextStyle(fontSize: Fontsizes.subTitleTwoFontSize, color: MyColors.textGrey, fontWeight: FontWeight.bold))),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [const Icon(Icons.person_outline, size: 15, color: MyColors.textGrey), Text(" ${tripModel.driverName}", style: const TextStyle(color: MyColors.textGrey))]),
            Row(children: [const Icon(Icons.watch_later_outlined, size: 15, color: MyColors.textGrey), Text(' ${tripModel.departureDate.day}/${tripModel.departureDate.month}/${tripModel.departureDate.year} - ${tripModel.departureTime}', style: const TextStyle(color: MyColors.textGrey))])
          ],
        ),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(tripModel.description, style: const TextStyle(color: MyColors.textGrey), textAlign: TextAlign.start),
          ValueListenableBuilder<bool>(
            valueListenable: _notifier,
            builder: (context, value, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                    onPressed: () async{
                      AsyncProgressDialog.show(context);
                      try {
                        List<Location> current = await tripModel.locations;
                        MapScreenArgs args = await MapScreenArgs.create(tripModel: tripModel, locations: current, visibleSheet: !value);
                        if (context.mounted) {
                          AsyncProgressDialog.dismiss(context);
                          final result = await Navigator.pushNamed<bool>(context, AppRouter.tripMap, arguments: args);
                          if (result == true) {
                            _notifier.value = result!;
                          }
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
                      shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(10)))),
                    ),
                    icon: const Icon(Icons.text_snippet_outlined, color: MyColors.textWhite),
                    label: const Text("Detalles", style: TextStyle(color: MyColors.textWhite, fontWeight: FontWeight.bold))
                  ),
                  TextButton.icon(
                    onPressed: enabled
                      ? () async{
                        AsyncProgressDialog.show(context);
                        final result = await _helper.requestSeat(tripModel.id, tripModel.driverUserId);
                        if (context.mounted) {
                          _notifier.value = result;
                          AsyncProgressDialog.dismiss(context);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(result == true ? "Reservación exitosa" : "Error al reservar. Inténtalo de nuevo", style: const TextStyle(color: MyColors.textWhite)),
                            backgroundColor: result == true ? MyColors.success : MyColors.danger
                          ));
                        }
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
                      shape: const MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10)))),
                    ),
                    icon: Icon(enabled ? Icons.send_sharp : Icons.check, color: MyColors.textWhite),
                    label: Text("Reserva${enabled ? 'r': 'do'}", style: const TextStyle(color: MyColors.textWhite, fontWeight: FontWeight.bold))
                  )
                ].map((e) => Expanded(child: e)).toList(),
              );
            }
          ),
        ],
      ),
    );
  }
}