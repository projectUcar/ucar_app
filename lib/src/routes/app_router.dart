import 'package:flutter/material.dart';
import 'package:ucar_app/src/screens/loading_screen.dart';
import 'package:ucar_app/src/screens/passenger/pass_home.dart';

import '../screens/forms/form_screen.dart';
class AppRouter{
  static const String root = "/",
  login = "/log-in",
  signUp = '/sign-up',
  homePass = 'home-pass';
  
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    switch (settings.name) {
      case root:
        return MaterialPageRoute(
          builder: (context) =>const LoadingScreen(),
          settings: settings
        );
      case login:
        return MaterialPageRoute(
          builder: (context) =>LogInScreen(),
          settings: settings
        );
      case signUp:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        );
      case homePass:
        return MaterialPageRoute(
          builder: (context) => HomePassenger(name: settings.arguments as String)
        );
      default:
        return null;
    }
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings){
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('Ruta ${settings.name} no encontrada'),
        ),
      )
    );
  }
}