import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/blocs.dart';
import '../../components/shimmer_card.dart';
import '../../config/size_config.dart';
import '../../models/vehicle.dart';
import '../../storage/auth_client.dart';
import '../../theme/themes.dart';
import '../../util/whatsapp_launcher.dart';
import '../wrappers/gps_access_screen.dart';

class TripDetails extends StatelessWidget with WhatsAppLauncher{
  const TripDetails({super.key, required this.historyModel});
  
  final HistoryModel historyModel;

  TripModel get tripModel => historyModel.tripModel;
  Vehicle get vehicle => historyModel.vehicle;
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
        body: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverToBoxAdapter(
                child: ListTile(
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
              ),
            ),
            BlocProvider<HoldersBloc>(
              create: (context) => HoldersBloc(tripModel: tripModel)..add(HoldersFetching()),
              child: const TripBody(),
            )
          ],
        )
      )
    );
  }
}

class TripBody extends StatelessWidget with WhatsAppLauncher{
  const TripBody({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HoldersBloc, HoldersState>(
    builder: (context, state) {
      if (state is HoldersFailed) {
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
                 IconButton(iconSize: 50, onPressed: () => BlocProvider.of<HoldersBloc>(context).add(HoldersFetching()), icon: const Icon(Icons.refresh_rounded), color: MyColors.purpleTheme),
                 Text("${state.message}. Inténtalo de nuevo", style: const TextStyle(color: MyColors.textGrey, fontWeight: FontWeight.bold, fontSize: Fontsizes.subTitleTwoFontSize), textAlign: TextAlign.justify)
               ],
             ),
           ),
        );
      } else if (state is HoldersReturned){
        return SliverList.list(
          children: List<Widget>.generate(
            state.holders.length,
            (index) => userTile(context, state.holders[index], BlocProvider.of<HoldersBloc>(context).tripModel)
          ));
      } else if (state is HoldersLoading){
        return SliverList(delegate: SliverChildBuilderDelegate((context, index) => const ShimmerCard(), childCount: 4));
      }
      return Container();
    },
  );

  Widget userTile(BuildContext context, ProfileModel profileModel, TripModel tripModel){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        tileColor: profileModel.id == tripModel.driverUserId ? MyColors.backgroundBlue.withOpacity(0.3) :
        Colors.transparent,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: MyColors.orangeDark, width: 1.5),
          borderRadius: BorderRadius.circular(12)
        ),
        contentPadding: const EdgeInsets.all(8),
        title: Text('${profileModel.firstName} ${profileModel.lastName}', style: const TextStyle(fontSize: Fontsizes.subTitleTwoFontSize - 2, color: MyColors.textWhite, fontWeight: FontWeight.bold)),
        subtitle: Text('${profileModel.email}\n${profileModel.carrer}', style: const TextStyle(fontSize: Fontsizes.bodyTextFontSize, color: MyColors.textWhite)),
        trailing: IconButton(
          onPressed: () async{
            final clientId = await AuthClient().userId;
            if ((profileModel.id != clientId && clientId != tripModel.driverUserId && profileModel.id == tripModel.driverUserId)) {
              await sendMessageAsPassenger(profileModel.phoneNumber, tripModel);
            }else if (profileModel.id != clientId && clientId == tripModel.driverUserId){
              await sendMessageAsDriver(profileModel.phoneNumber, tripModel);
            }else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text("Acción denegada", style: CustomStyles.whiteStyle), backgroundColor: Colors.red.shade400,)
                );
              }
            }
          },
          icon: Image.asset("assets/images/whatsapp-fill.png", color: MyColors.success, height: 25)
        ),
      ),
    );
  }
}