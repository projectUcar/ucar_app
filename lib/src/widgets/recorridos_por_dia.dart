import 'package:flutter/material.dart';
import 'package:ucar_app/src/components/container_background.dart';
import 'package:ucar_app/src/theme/custom_styles.dart';

import '../theme/colors.dart';
import '../theme/fontsizes.dart';

class RecorridosDia extends StatelessWidget{
  final String day;
  final String departure;
  final String destination;
  final TimeOfDay timeExit;
  final int cantDrivers;
  final int quotas;

  const RecorridosDia({ 
    Key? key, 
    required this.day, 
    required this.departure, 
    required this.destination, 
    required this.timeExit, 
    required this.cantDrivers, 
    required this.quotas 
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle _bodyStyle = CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize);

    return ContainerBackground(
      color: MyColors.backgroundCard,
      height: 82, 
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(day, style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.titleFontSize - 10, fontWeight: FontWeight.w900),),
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
                    Text(departure, style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.subTitleFontSize + 4, fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.room, color: MyColors.textWhite, size: 24),
                    Text(destination, style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.subTitleFontSize + 4, fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
            Container(
              constraints: const BoxConstraints(maxWidth: 120.0),
              child: Column(
                children: [
                  Text(timeExit.format(context), style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize, fontWeight: FontWeight.w900)),
                  Text(cantDrivers.toString()+" Conductores", style: _bodyStyle, overflow: TextOverflow.ellipsis),
                  Text(quotas.toString()+" Cupos Totales", style: _bodyStyle, overflow: TextOverflow.ellipsis),
                ],
              ),
            )
          ],
        )
    );
  }
}