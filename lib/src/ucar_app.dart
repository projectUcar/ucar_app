import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'theme/themes.dart';

class UcarApp extends StatelessWidget {
  const UcarApp({super.key});

  // Root Widget
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