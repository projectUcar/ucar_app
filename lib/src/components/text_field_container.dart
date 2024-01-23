import 'package:flutter/material.dart';
import 'package:ucar_app/src/config/size_config.dart';
import 'package:ucar_app/src/theme/colors.dart';

class TextFieldContainer extends StatelessWidget {
  final double sizeFinal;
  final Widget child;

  const TextFieldContainer({ 
    Key? key, 
    this.sizeFinal = 0.90,
    required this.child 
    }) : super(key: key);

  @override
   Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: SizeConfig.displayWidth(context) * sizeFinal,
      height: 55,
      decoration: BoxDecoration(
        color: MyColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}