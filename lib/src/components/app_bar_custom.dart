import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/fontsizes.dart';

class AppBarCustom extends StatelessWidget {

  final String text;
  final Color color;
  final bool leanding;

  const AppBarCustom({
    Key? key, 
    required this.text, 
    this.leanding = true,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      backgroundColor: color,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: titleFontSize-10),
      automaticallyImplyLeading: leanding,
      //title: Text(text.split(" ").length.toString()),
      title: text.split(" ").length > 1  ? Row( mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(text.split(" ")[0] + " "),
        Text(text.split(" ")[1], style: const TextStyle(fontWeight: FontWeight.bold),)
      ],) : const Text(""),
      
    );
  }
}