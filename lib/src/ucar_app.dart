import 'package:flutter/material.dart';
import 'helpers/helpers.dart';
import 'routes/app_router.dart';
import 'theme/themes.dart';

class UcarApp extends StatefulWidget {
  const UcarApp({super.key});

  @override
  State<UcarApp> createState() => _UcarAppState();
}

class _UcarAppState extends State<UcarApp> {

  @override
  void initState() {
    super.initState();
    PushNotificationHelper.messagesStream.listen((message) {
      debugPrint("UcarApp: $message");
    });
  }
  
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