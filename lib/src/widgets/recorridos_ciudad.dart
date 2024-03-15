import 'package:flutter/material.dart';

import '../theme/custom_styles.dart';
import 'container_list.dart';
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
    super.key, 
    required this.name, 
    required this.cantDrivers, 
    required this.quotas, 
    required this.routes, 
    required this.destinations    
   });

  @override
  Widget build(BuildContext context) {
    TextStyle bodyStyle = CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize);
    return ContainerBackground(
      color: MyColors.backgroundCard,
      height: 136, 
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            name == "Girón"? "assets/images/giron.png" : "assets/images/${name.toLowerCase()}.png",
            height: 100,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.subTitleFontSize +4, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10,),
              Row(children: [const PersonRounded(size: 17, sizeIcon: 15,),const PersonRounded(size: 17, sizeIcon: 15),const PersonRounded(size: 17, sizeIcon: 15), Text(" $cantDrivers Conductores", style: bodyStyle, overflow: TextOverflow.ellipsis)]),
              const SizedBox(height: 8,),
              Text("${routes.toString()} Recorridos, ${quotas.toString()} cupos totales", style: bodyStyle, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 7,),
              ListContainer(destinations: destinations)
            ],
          ),
        ],
      )
    );
  }
}