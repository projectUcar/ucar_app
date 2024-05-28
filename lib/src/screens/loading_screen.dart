import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ucar_app/src/config/size_config.dart';
import 'package:ucar_app/src/routes/app_router.dart';
import '../storage/auth_client.dart';
import '../theme/themes.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  
  @override
  void initState() {
    super.initState();
    _readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/ucar_logo.svg", height: SizeConfig.displayHeight(context) * 0.3),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: SizeConfig.displayWidth(context) * 0.2),
              child: const LinearProgressIndicator(color: MyColors.purpleTheme,),
            )
          ].map((child) => Padding(
            padding: EdgeInsets.symmetric(vertical: SizeConfig.displayWidth(context) * 0.015),
            child: child,
          )).toList()
        )
      ),
    );
  }

  Future<void> _readData() async{
    final session = await AuthClient().session;
    if (session != null && session.logged && !session.sessionExpired && session.refreshToken != null && context.mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.landing, arguments: session.name);
    }else if(context.mounted){
      Navigator.pushReplacementNamed(context, AppRouter.login);
    }
  }
}