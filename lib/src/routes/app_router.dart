import 'package:flutter/material.dart';

import '../screens/forms/form_screen.dart';
import '../screens/loading_screen.dart';
import '../screens/top_level_pages/detailed_routes.dart';
import '../screens/wrappers/landing_page.dart';

class AppRouter {
  static const String root = "/", login = "/log-in", signUp = '/sign-up', landing = 'landing', cityDetail = 'detailedRoutes';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (context) => const LoadingScreen(), settings: settings);
      case login:
        return MaterialPageRoute(builder: (context) => LogInScreen());
      case signUp:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case landing:
        return MaterialPageRoute(builder: (_) => LandingPage(name: settings.arguments as String));
      case cityDetail:
        return MaterialPageRoute(builder: (context) => DetailedCityRoutes(args: settings.arguments as DetailedCityRoutesArgs));
      default:
        return null;
    }
  }

  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text('Ruta ${settings.name} no encontrada'),
        ),
      )
    );
  }
}