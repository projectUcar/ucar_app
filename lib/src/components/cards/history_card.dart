import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

import '../../blocs/blocs.dart';
import '../../routes/app_router.dart';
import '../../screens/medium_level_pages/map_screen.dart';
import '../../theme/themes.dart';
import '../../widgets/temporaries/async_progress_dialog.dart';

class HistoryCard extends StatelessWidget{
  const HistoryCard({super.key, required this.historyModel, required this.currentDateTime});
  final HistoryModel historyModel;
  final DateTime currentDateTime;

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    color: MyColors.primary,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      side: BorderSide(color: afterTime ? MyColors.orangeDark : MyColors.success),
      borderRadius: const BorderRadius.all(Radius.circular(16))
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ListTile(
          title: Center(child: Text(historyModel.tripModel.titleFormat, style: const TextStyle(fontSize: Fontsizes.subTitleTwoFontSize, color: MyColors.textWhite, fontWeight: FontWeight.bold))),
          subtitle: Column(
            children: [
              Row(
                children: [
                  const Icon(Icons.date_range_rounded, color: MyColors.yellow, size: 20),
                  Text(historyModel.tripModel.formatDT, style: const TextStyle(color: MyColors.textWhite, fontSize: Fontsizes.bodyTextFontSize + 2), textAlign: TextAlign.start),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.reduce_capacity_sharp, color: MyColors.yellow, size: 20),
                  Text('Pasajeros: ${historyModel.tripModel.passengers.length} | Cupos: ${historyModel.tripModel.availableSeats}', style: const TextStyle(color: MyColors.textWhite, fontSize: Fontsizes.bodyTextFontSize + 2), textAlign: TextAlign.start)
                ]
              )
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(
              visible: afterTime,
              child: Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    AsyncProgressDialog.show(context);
                    try {
                      List<Location> current = await historyModel.tripModel.locations;
                      MapScreenArgs args = await MapScreenArgs.create(tripModel: historyModel.tripModel, locations: current, visibleSheet: false);
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.backgroundBlue,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                  ),
                  child: const Icon(Icons.location_on, color: MyColors.textWhite),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, AppRouter.tripDetails, arguments: historyModel),
                style: TextButton.styleFrom(
                  backgroundColor: MyColors.purpleTheme,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.zero)),
                ),
                child: const Icon(Icons.text_snippet, color: MyColors.textWhite),
              ),
            ),
          ],
        )
      ],
    ),
  );

  bool get afterTime => historyModel.tripModel.fullDateTime.isAfter(currentDateTime);
}