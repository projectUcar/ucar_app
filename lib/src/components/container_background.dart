import 'package:flutter/material.dart';

class ContainerBackground extends StatelessWidget {
  final Color color;
  final double height;
  final Widget child;

  const ContainerBackground({ 
    Key? key,
    required this.color, 
    required this.height,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          width: size.width * 0.90,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child,
      ]
    );
  }
}