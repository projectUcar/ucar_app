import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ucar_app/src/theme/colors.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key ? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              "assets/icons/figuraArriba.svg",
              color: backgroundSvg,
              height: size.height * 0.5,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/icons/figuraAbajo.svg",
              color: backgroundSvg,
              height: size.height * 0.15,
            ),
          ),
          child,
        ],
      ),
    );
  }
}