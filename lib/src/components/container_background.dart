import 'package:flutter/material.dart';
import 'package:ucar_app/src/config/size_config.dart';

class ContainerBackground extends StatelessWidget {
  final Color color;
  final double height;
  final Widget child;

  const ContainerBackground({ 
    super.key,
    required this.color, 
    required this.height,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: SizeConfig.displayWidth(context) * 0.9,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}