import 'package:flutter/material.dart';
import 'package:ucar_app/src/widgets/container_list.dart';

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
    TextStyle _bodyStyle = const TextStyle(color: textGray, fontSize: bodyTextFontSize);
    return ContainerBackground(
      color: backgroundCard,
      height: 136, 
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            name == "Girón"? "assets/images/giron.png" : "assets/images/"+name.toLowerCase()+".png",
            height: 100,
            fit: BoxFit.cover,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(color: textWhite, fontSize: subTitleFontSize+4, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10,),
              Row(children: [const PersonRounded(size: 17, sizeIcon: 15,),PersonRounded(size: 17, sizeIcon: 15),PersonRounded(size: 17, sizeIcon: 15), Text(" "+cantDrivers.toString()+" Conductores", style: _bodyStyle, overflow: TextOverflow.ellipsis)]),
              const SizedBox(height: 8,),
              Container(constraints: const BoxConstraints(maxWidth: 210), child: Row(children: [Text(routes.toString()+" Recorridos, ", style: _bodyStyle, overflow: TextOverflow.ellipsis), Text(quotas.toString()+" Cupos totales ", style: _bodyStyle, overflow: TextOverflow.ellipsis)])),
              const SizedBox(height: 7,),
              ListContainer(destinations: destinations)
            ],
          ),
        ],
      )
    );
  }
}