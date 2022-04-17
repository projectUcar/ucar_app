import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/container_background.dart';
import '../theme/colors.dart';
import '../theme/fontsizes.dart';
import 'person_rounded.dart';

class RecorridoCiudad extends StatelessWidget {
  final String name;
  final int cantDrivers;
  final int quotas;
  final int routes;
  final List<String> destinations;

  const RecorridoCiudad({ 
    Key? key, 
    required this.name, 
    required this.cantDrivers, 
    required this.quotas, 
    required this.routes, 
    required this.destinations    
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerBackground(
      color: backgroundCard,
      height: 136, 
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 100,
            height: 100,
            color: textGray,
          ),
          
          // SvgPicture.asset(
          //     "assets/icons/floridablanca.svg",
          //     color: backgroundSvg,
          //     height: 101,
          //   ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(color: textWhite, fontSize: subTitleFontSize+4, fontWeight: FontWeight.bold)),
              Row(children: [PersonRounded(size: 17, sizeIcon: 15,),PersonRounded(size: 17, sizeIcon: 15),PersonRounded(size: 17, sizeIcon: 15), Text(" "+cantDrivers.toString()+" Conductores", style: const TextStyle(color: textGray, fontSize: bodyTextFontSize))]),
              Row(children: [Text(routes.toString()+" Recorridos, ", style: const TextStyle(color: textGray, fontSize: bodyTextFontSize)), Text(quotas.toString()+" Cupos totales", style: const TextStyle(color: textGray, fontSize: bodyTextFontSize))])
            ],
          )
        ],
      )
    );
  }
}