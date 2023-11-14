// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ucar_app/src/screens/background.dart';
import 'package:ucar_app/src/theme/colors.dart';
import 'package:ucar_app/src/theme/fontsizes.dart';
import 'package:ucar_app/src/widgets/person_rounded.dart';
import 'package:ucar_app/src/widgets/recorridos_ciudad.dart';
import 'package:ucar_app/src/widgets/recorridos_por_dia.dart';

import '../../components/app_bar_custom.dart';
import '../../components/rounded_input_field.dart';

class HomePassenger extends StatelessWidget {
  final String name;

  const HomePassenger({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
          child: AppBarCustom(
            color: primary,
            text: "Hola, "+name,
            leanding: true, //CAMBIAR A FALSE PARA NO IR A LOGIN
          ),
          preferredSize: Size.fromHeight(50),
        ),
      backgroundColor: primary,

        
      body: SizedBox(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RoundedInputField(
                  hintText: "¿A dónde vas?",
                  height: 40,
                  fontSize: bodyTextFontSize,
                  onChanged: (value) {}, 
                  icon: Icons.search,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width / 19.5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Nuestros Conductores",
                            style: TextStyle(
                              fontSize: subTitleTwoFontSize,
                              fontWeight: FontWeight.bold,
                              color: textWhite
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, color: textWhite,),                    
                        ],
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          PersonRounded(size: 50, sizeIcon: 35),
                          PersonRounded(size: 50, sizeIcon: 35),
                          PersonRounded(size: 50, sizeIcon: 35),
                          PersonRounded(size: 50, sizeIcon: 35),
                          PersonRounded(size: 50, sizeIcon: 35),
                          PersonRounded(size: 50, sizeIcon: 35),
                        ],
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Recorridos para hoy",
                            style: TextStyle(
                              fontSize: subTitleTwoFontSize,
                              fontWeight: FontWeight.bold,
                              color: textWhite
                            ),
                          ),
                        ],
                      ),
                      RecorridosDia(
                        day: "Miércoles", 
                        departure: "UPB", 
                        destination: "Mutis", 
                        timeExit: TimeOfDay(hour: 16, minute: 0), 
                        cantDrivers: 5, 
                        quotas: 13
                      ),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Explora otras opciones",
                            style: TextStyle(
                              fontSize: subTitleTwoFontSize,
                              fontWeight: FontWeight.bold,
                              color: textWhite
                            ),
                          ),
                        ],
                      ),
                      RecorridoCiudad(
                        name: "Floridablanca", 
                        cantDrivers: 3, 
                        quotas: 3, 
                        routes: 12, 
                        destinations: ["Cañaveral", "Florida", "La Cumbre", "Palmeras"]
                      ),
                      RecorridoCiudad(
                        name: "Bucaramanga", 
                        cantDrivers: 25, 
                        quotas: 10, 
                        routes: 110, 
                        destinations: ["Mutis", "Real de Minas", "Cabecera" , "Parque Turbay", "El Prado"]
                      ),
                      RecorridoCiudad(
                        name: "Piedecuesta", 
                        cantDrivers: 10, 
                        quotas: 12, 
                        routes: 15, 
                        destinations: ["Cañaveral", "Florida", "LaCumbre"]
                      ),
                      RecorridoCiudad(
                        name: "Girón", 
                        cantDrivers: 9, 
                        quotas: 10, 
                        routes: 11, 
                        destinations: ["Cañaveral", "Florida", "La Cumbre"]
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
      
    );
  }
}
