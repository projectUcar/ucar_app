import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/colors.dart';

class PersonRounded extends StatelessWidget {
  //final int cant;
  final double size;
  final double sizeIcon;

  const PersonRounded({ 
    Key? key,
    required this.sizeIcon,
    required this.size,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size,
          width: size,
          decoration: const BoxDecoration(
            color: textOrange,
          shape: BoxShape.circle
          ),
        ),
        Icon(Icons.person_rounded, color: secondary, size: sizeIcon,)
      ] 
    );
  }
}