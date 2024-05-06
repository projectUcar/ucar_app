import 'package:flutter/material.dart';

import '../theme/themes.dart';

class AppBarCustom extends StatelessWidget {

  final String text;
  final Color color;
  final bool leadingBoolean;

  const AppBarCustom({
    super.key, 
    required this.text, 
    this.leadingBoolean = true,
    required this.color,
  });

  List<String> get titleWordsList => text.split(" ");

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0.8,
      backgroundColor: color,
      centerTitle: true,
      leading: (leadingBoolean) ? IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: MyColors.purpleTheme,
        ),
        onPressed: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
          Navigator.of(context).pop();//Navigator.pop(context); //Así también funciona
        },
      ): null,
      titleTextStyle: const TextStyle(
        fontSize: Fontsizes.titleFontSize-10,
        color: MyColors.purpleTheme
      ),
      //title: Text(text.split(" ").length.toString()),
      title: titleWordsList.length > 1  ? Row( mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("${titleWordsList[0]} "),
        Text(titleWordsList[1], style: CustomStyles.boldStyle)
      ],) : const Text(""),
      
    );
  }
}