
import 'package:flutter/material.dart';
import 'package:ucar_app/src/config/size_config.dart';
import '../background.dart';
import '../../theme/colors.dart';
import '../../theme/fontsizes.dart';
import '../../widgets/person_rounded.dart';
import '../../widgets/recorridos_ciudad.dart';
import '../../widgets/recorridos_por_dia.dart';
import '../../components/app_bar_custom.dart';
import '../../components/rounded_input_field.dart';
import '../../theme/custom_styles.dart';

class HomePassenger extends StatelessWidget {
  final String name;

  const HomePassenger({super.key, this.name = "nuevo"});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBarCustom(
            color: MyColors.backgroundSvg,
            text: "Hola, $name",
            leadingBoolean: false,
          ),
        ),
      body: Background(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RoundedInputField(
                  hintText: "¿A dónde vas?",
                  onChanged: (value) {}, 
                  icon: Icons.search,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.displayWidth(context) / 19.5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Nuestros Conductores",
                            style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.subTitleFontSize, fontWeight: FontWeight.bold,),
                          ),
                          const Icon(Icons.arrow_forward_ios_rounded, color: MyColors.textWhite,),                    
                        ],
                      ),
                      SizedBox(height: SizeConfig.displayHeight(context) * 0.01),
                      const Row(
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
                      SizedBox(height: SizeConfig.displayHeight(context) * 0.02),
                      Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            "Recorridos para hoy",
                            style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.subTitleFontSize, fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                      const RecorridosDia(
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
                          Text(
                            "Explora otras opciones",
                            style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.subTitleFontSize, fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                      const RecorridoCiudad(
                        name: "Floridablanca", 
                        cantDrivers: 3, 
                        quotas: 3, 
                        routes: 12, 
                        destinations: ["Cañaveral", "Florida", "La Cumbre", "Palmeras"]
                      ),
                      const RecorridoCiudad(
                        name: "Bucaramanga", 
                        cantDrivers: 25, 
                        quotas: 10, 
                        routes: 110, 
                        destinations: ["Mutis", "Real de Minas", "Cabecera" , "Parque Turbay", "El Prado"]
                      ),
                      const RecorridoCiudad(
                        name: "Piedecuesta", 
                        cantDrivers: 10, 
                        quotas: 12, 
                        routes: 15, 
                        destinations: ["Cañaveral", "Florida", "LaCumbre"]
                      ),
                      const RecorridoCiudad(
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
