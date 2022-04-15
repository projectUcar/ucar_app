import 'package:flutter/material.dart';
import 'package:ucar_app/src/screens/login.dart';
import 'package:ucar_app/src/screens/sing-up.dart';
import 'package:ucar_app/src/theme/colors.dart';

void main() {
  runApp(const UcarApp());
}

class UcarApp extends StatelessWidget {
  const UcarApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ucar App',
      initialRoute: '/',
      theme: ThemeData(
        primaryColor: textWhite,
      ),
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => const LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/sing-up': (context) => const SingUp(),
      },
    );
  }
}
