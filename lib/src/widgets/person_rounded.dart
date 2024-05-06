import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/themes.dart';

class PersonRounded extends StatelessWidget {
  final double size;
  final double sizeIcon;

  const PersonRounded({ 
    super.key,
    required this.sizeIcon,
    required this.size,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: MyColors.purpleTheme,
        shape: BoxShape.circle,
      ),
      child: Icon(Icons.person_rounded, color: MyColors.secondary, size: sizeIcon,),
    );
  }
}