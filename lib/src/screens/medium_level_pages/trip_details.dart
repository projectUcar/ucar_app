import 'package:flutter/material.dart';

import '../../blocs/blocs.dart';
import '../../helpers/helpers.dart';
import '../../models/vehicle.dart';
import '../../storage/auth_client.dart';
import '../../theme/themes.dart';
import '../../util/whatsapp_launcher.dart';
import '../wrappers/gps_access_screen.dart';

class TripDetails extends StatelessWidget with WhatsAppLauncher{
  
  const TripDetails({super.key, required this.historyModel});
  
  final HistoryModel historyModel;
  static final ProfileHelper _helper = ProfileHelper();

  TripModel get tripModel => historyModel.tripModel;
  Vehicle get vehicle => historyModel.vehicle;
  List<String> get ids => <String>[tripModel.driverUserId, ...tripModel.passengers];
  static const Radius _radius = Radius.circular(6);
  
  @override
  Widget build(BuildContext context) {
    return GpsAccessScreen(
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
            icon:const Icon(Icons.arrow_back_ios, color: MyColors.purpleTheme)
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: MyColors.purpleTheme, width: 1.5),
                borderRadius: BorderRadius.circular(16)
              ),
              contentPadding: const EdgeInsets.all(8),
              title: Text(historyModel.tripModel.titleFormat, style: const TextStyle(fontSize: Fontsizes.subTitleTwoFontSize, color: MyColors.textWhite, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.home_work_rounded, color: MyColors.yellow, size: 25),
                      Text(historyModel.tripModel.city, style: const TextStyle(color: MyColors.textWhite, fontSize: Fontsizes.bodyTextFontSize + 1)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.date_range_rounded, color: MyColors.yellow, size: 25),
                      Text(historyModel.tripModel.formatDT, style: const TextStyle(color: MyColors.textWhite, fontSize: Fontsizes.bodyTextFontSize + 1)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.directions_car_rounded, color: MyColors.yellow, size: 25),
                      Text('${vehicle.brand} ${vehicle.line} ${vehicle.color}', style: const TextStyle(color: MyColors.backgroundBlue, fontSize: Fontsizes.bodyTextFontSize + 1), textAlign: TextAlign.start, overflow: TextOverflow.ellipsis)
                    ]
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    alignment: Alignment.center, height: 40, width: 70,
                    decoration: const BoxDecoration(color: MyColors.yellow, borderRadius: BorderRadius.all(_radius)),
                    child: Container(
                      alignment: Alignment.center, height: 36, width: 66,
                      decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: MyColors.primary), borderRadius: const BorderRadius.all(_radius)),
                      child: Text(vehicle.plate!, style: const TextStyle(color: MyColors.primary, fontWeight: FontWeight.bold, fontSize: Fontsizes.bodyTextFontSize)),
                    ),
                  ),
                ],
              )
            ),
            ...List<Widget>.generate(ids.length, (index) => userTile(context, ids[index]))
          ].map((e) => Padding(padding: const EdgeInsets.only(bottom: 8), child: e)).toList(),
        ),
      )
    );
  }

  Widget userTile(BuildContext context, String tileId){
    return FutureBuilder<ProfileModel?>(
      future: _helper.userById(tileId),
      builder: (context, snapshot) {
        if (snapshot.hasData || snapshot.hasError) {
          return ListTile(
            tileColor: snapshot.hasError ? MyColors.danger.withOpacity(0.3) :
            snapshot.data?.id == tripModel.driverUserId ? MyColors.purpleTheme.withOpacity(0.3) :
            Colors.transparent,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: snapshot.hasError ? MyColors.danger : MyColors.backgroundBlue, width: 1.5),
              borderRadius: BorderRadius.circular(12)
            ),
            contentPadding: const EdgeInsets.all(8),
            title: Text(snapshot.hasError? "ERROR" : '${snapshot.data?.firstName} ${snapshot.data?.lastName}', style: const TextStyle(fontSize: Fontsizes.subTitleTwoFontSize - 2, color: MyColors.textWhite, fontWeight: FontWeight.bold)),
            subtitle: snapshot.hasData ? Text('${snapshot.data?.email}\n${snapshot.data?.carrer}', style: const TextStyle(fontSize: Fontsizes.bodyTextFontSize, color: MyColors.textWhite)) : null,
            trailing: snapshot.hasData ? IconButton(
              onPressed: () async{
                final clientId = await AuthClient().userId;
                if ((tileId != clientId && clientId != tripModel.driverUserId && tileId == tripModel.driverUserId)) {
                  await sendMessageAsPassenger(snapshot.data!.phoneNumber, tripModel);
                }else if (tileId != clientId && clientId == tripModel.driverUserId){
                  await sendMessageAsDriver(snapshot.data!.phoneNumber, tripModel);
                }else {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: const Text("Acción denegada", style: CustomStyles.whiteStyle), backgroundColor: Colors.red.shade400,)
                    );
                  }
                }
              },
              icon: Image.asset("assets/images/whatsapp-fill.png", color: MyColors.success, height: 25)
            ) : null,
          );
        }
        return const ListTile(tileColor: MyColors.secondary);
      },
    );
  }
}