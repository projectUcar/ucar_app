import 'package:flutter/material.dart';
import 'package:ucar_app/src/blocs/blocs.dart';

import '../models/vehicle.dart';
import '../screens/forms/forms.dart';
import '../screens/loading_screen.dart';
import '../screens/medium_level_pages/medium_level_pages.dart';
import '../screens/wrappers/landing_page.dart';

class AppRouter {
  static const String root = '/', login = '/log-in', signUp = '/sign-up', landing = '/landing', cityDetail = '/detailedRoutes', tripMap = '/tripMap', driverForm = '/driver-form', newTrip = '/new-trip', vehicles = '/vehicles', tripDetails = '/trip-details';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (context) => const LoadingScreen(), settings: settings);
      case login:
        return MaterialPageRoute(builder: (context) => LogInScreen());
      case signUp:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case landing:
        return MaterialPageRoute(builder: (_) => LandingPage(args: settings.arguments as LandingPageArgs));
      case cityDetail:
        return MaterialPageRoute(builder: (context) => DetailedCityRoutes(args: settings.arguments as DetailedCityRoutesArgs));
      case tripMap:
        return MaterialPageRoute<bool>(builder: (context) => MapScreen(args: settings.arguments as MapScreenArgs));
      case driverForm:
        return MaterialPageRoute<bool>(builder: (context) => DriverRequestScreen());
      case newTrip:
        return MaterialPageRoute<bool>(builder: (context) => NewTripScreen(vehicles: settings.arguments as List<Vehicle>));
      case vehicles:
        return MaterialPageRoute(builder: (context) => const VehiclesScreen());
      case tripDetails:
        return MaterialPageRoute(builder: (context) => TripDetails(historyModel: settings.arguments as HistoryModel));
      default:
        return onUnknownRoute(settings);
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