import 'package:flutter/material.dart';
import 'package:ucar_app/src/components/container_background.dart';

import '../theme/colors.dart';
import '../theme/fontsizes.dart';

class RecorridosDia extends StatelessWidget {
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
    return ContainerBackground(
      color: backgroundCard,
      height: 82, 
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(day, style: const TextStyle(color: textOrange, fontSize: titleFontSize-10, fontWeight: FontWeight.w900),),
            Container(
              width: 2.5,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: textGray,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.room, color: textOrange, size: 24,),
                    Text(departure, style: const TextStyle(color: textWhite, fontSize: subTitleFontSize+4, fontWeight: FontWeight.bold))
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.room, color: textWhite, size: 24,),
                    Text(destination, style: const TextStyle(color: textWhite, fontSize: subTitleFontSize+4, fontWeight: FontWeight.bold))
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Text(timeExit.format(context), style: const TextStyle(color: textWhite, fontSize: bodyTextFontSize, fontWeight: FontWeight.w900)),
                Text(cantDrivers.toString()+" Conductores", style: const TextStyle(color: textGray, fontSize: bodyTextFontSize)),
                Text(quotas.toString()+" Cupos Totales", style: const TextStyle(color: textGray, fontSize: bodyTextFontSize)),
              ],
            )
          ],
        )
    );
  }
}