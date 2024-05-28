import 'package:flutter/material.dart';
import '../../config/size_config.dart';
import 'routes_by_cities.dart';

class HomePassenger extends StatelessWidget {
  const HomePassenger({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: SizeConfig.displayWidth(context) / 19.5),
      child: const RoutesByCities()
    );
  }
}
