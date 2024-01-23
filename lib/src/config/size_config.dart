import 'package:flutter/widgets.dart';

class SizeConfig {
  
  static Size displaySize(BuildContext context) => MediaQuery.of(context).size;

  static double displayHeight(BuildContext context) => displaySize(context).height;

  static double displayWidth(BuildContext context) => displaySize(context).width;

  SizeConfig._();
}
