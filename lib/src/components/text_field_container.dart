import 'package:flutter/material.dart';
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
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * sizeFinal,
      height: 55,
      decoration: BoxDecoration(
        color: MyColors.secondary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}