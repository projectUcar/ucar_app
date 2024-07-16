library pass_home;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../blocs/blocs.dart';
import '../../components/container_background.dart';
import '../../components/shimmer_card.dart';
import '../../config/size_config.dart';
import '../../routes/app_router.dart';
import '../../theme/themes.dart';
import '../../widgets/container_list.dart';
import '../medium_level_pages/detailed_routes.dart';
part 'routes_by_cities.dart';

class HomePassenger extends StatelessWidget {
  const HomePassenger({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: SizeConfig.displayWidth(context) / 19.5),
      child: const RoutesByCities()
    );
  }
}
