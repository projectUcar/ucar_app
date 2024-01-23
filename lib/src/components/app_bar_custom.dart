import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/fontsizes.dart';
import '../theme/custom_styles.dart';

class AppBarCustom extends StatelessWidget {

  final String text;
  final Color color;
  final bool leadingBoolean;

  const AppBarCustom({
    Key? key, 
    required this.text, 
    this.leadingBoolean = true,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0.8,
      backgroundColor: color,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: MyColors.orangeDark,
        ),
        onPressed: (){
          Navigator.of(context).pop();//Navigator.pop(context); //Así también funciona
        },
      ),
      titleTextStyle: const TextStyle(
        fontSize: Fontsizes.titleFontSize-10,
        color: MyColors.textOrange
      ),
      automaticallyImplyLeading: leadingBoolean,
      //title: Text(text.split(" ").length.toString()),
      title: text.split(" ").length > 1  ? Row( mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(text.split(" ")[0] + " "),
        Text(text.split(" ")[1], style: CustomStyles.boldStyle,)
      ],) : const Text(""),
      
    );
  }
}