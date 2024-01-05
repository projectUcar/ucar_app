import 'package:flutter/material.dart';

import '../screens/login.dart';
import '../screens/sign_up.dart';

class AppRouter{
  static const String root = "/",
  signUp = '/sign-up';
  
  static Route<dynamic>? onGenerateRoute(RouteSettings settings){
    switch (settings.name) {
      case root:
        return MaterialPageRoute(
          builder: (context) =>LogInScreen(),
          settings: settings
        );
      case signUp:
        return MaterialPageRoute(
          builder: (context) => SignUpScreen(),
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