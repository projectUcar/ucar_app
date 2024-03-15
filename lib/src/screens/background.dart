import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ucar_app/src/config/size_config.dart';
import 'package:ucar_app/src/theme/colors.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    super.key,
    required this.child,
  });

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
              colorFilter: const ColorFilter.mode(MyColors.backgroundSvg, BlendMode.srcIn),
              height: SizeConfig.displayHeight(context) * 0.5,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              "assets/icons/figuraAbajo.svg",
              colorFilter: const ColorFilter.mode(MyColors.backgroundSvg, BlendMode.srcIn),
              height: SizeConfig.displayHeight(context) * 0.15,
            ),
          ),
          child,
        ],
      ),
    );
  }
}