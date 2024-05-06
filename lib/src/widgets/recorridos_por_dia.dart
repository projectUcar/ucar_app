import 'package:flutter/material.dart';

import '../components/container_background.dart';
import '../theme/themes.dart';

class RecorridosDia extends StatelessWidget{
  final String day;
  final String departure;
  final String destination;
  final TimeOfDay timeExit;
  final int cantDrivers;
  final int quotas;

  const RecorridosDia({ 
    super.key, 
    required this.day, 
    required this.departure, 
    required this.destination, 
    required this.timeExit, 
    required this.cantDrivers, 
    required this.quotas 
    });

  TextStyle get _bodyStyle => CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize);
  
  @override
  Widget build(BuildContext context) {
    return ContainerBackground(
      color: MyColors.backgroundCard,
      height: 82, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.titleFontSize - 10, fontWeight: FontWeight.w900), overflow: TextOverflow.ellipsis),
          Container(
            width: 2.5,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.textGrey,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.room, color: MyColors.textGrey, size: 24,),
                  Text(departure, style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.subTitleFontSize + 4, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.room, color: MyColors.textWhite, size: 24),
                  Text(destination, style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.subTitleFontSize + 4, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis)
                ],
              ),
            ],
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 120.0),
            child: Column(
              children: [
                Text(timeExit.format(context), style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize, fontWeight: FontWeight.w900), overflow: TextOverflow.ellipsis),
                Text("$cantDrivers Conductores", style: _bodyStyle, overflow: TextOverflow.ellipsis),
                Text("$quotas Cupos Totales", style: _bodyStyle, overflow: TextOverflow.ellipsis),
              ],
            ),
          )
        ],
      )
    );
  }
}