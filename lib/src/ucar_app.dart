import 'package:flutter/material.dart';
import 'package:ucar_app/src/routes/app_router.dart';
import 'package:ucar_app/src/theme/themes.dart';

class UcarApp extends StatelessWidget {
  const UcarApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ucar App',
      onGenerateRoute: AppRouter.onGenerateRoute,
      onUnknownRoute: AppRouter.onUnknownRoute,
      initialRoute: AppRouter.root,
      theme: MyThemes.defaultTheme,
      builder: (context, widget) => SafeArea(child: widget!),
      //routes: routes,
    );
  }
}