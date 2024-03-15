import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ucar_app/src/config/size_config.dart';
import 'package:ucar_app/src/routes/app_router.dart';
import '../storage/auth_client.dart';
import '../theme/colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  
  @override
  void initState() {
    _readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/ucarLogo.svg"),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: SizeConfig.displayWidth(context) * 0.2),
              child: const LinearProgressIndicator(color: MyColors.orangeDark,),
            )
          ]
        )
      ),
    );
  }

  Future<void> _readData() async{
    final session = await Future.delayed(const Duration(seconds: 5)).then((_) => AuthClient().session);
    if (session!.logged && context.mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.homePass, arguments: session.name);
    }else if(!session.logged && context.mounted){
      Navigator.pushReplacementNamed(context, AppRouter.login);
    }
  }
}