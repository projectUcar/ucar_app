import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ucar_app/src/config/size_config.dart';
import 'package:ucar_app/src/theme/colors.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key ? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.displayHeight(context),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              "assets/icons/figuraArriba.svg",
              color: MyColors.backgroundSvg,
              height: SizeConfig.displayHeight(context) * 0.5,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/icons/figuraAbajo.svg",
              color: MyColors.backgroundSvg,
              height: SizeConfig.displayHeight(context) * 0.15,
            ),
          ),
          child,
        ],
      ),
    );
  }
}