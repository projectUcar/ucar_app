import 'package:flutter/material.dart';
import 'routes/app_router.dart';
import 'theme/themes.dart';

class UcarApp extends StatelessWidget {
  const UcarApp({Key? key}) : super(key: key);

  // Root Widget
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      behavior: HitTestBehavior.opaque,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ucar App',
        onGenerateRoute: AppRouter.onGenerateRoute,
        onUnknownRoute: AppRouter.onUnknownRoute,
        initialRoute: AppRouter.root,
        theme: MyThemes.defaultTheme,
        builder: (context, widget) => SafeArea(child: widget!),
        //routes: routes,
      ),
    );
  }
}