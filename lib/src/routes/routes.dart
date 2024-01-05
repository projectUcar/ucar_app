import 'package:flutter/material.dart';
import 'package:ucar_app/src/screens/login.dart';
import 'package:ucar_app/src/screens/sign_up.dart';

Map<String, Widget Function(BuildContext)> routes = {
  // Cuando se navega a la ruta "/" se muestra la pantalla de Iniciar Sesión
  '/': (context) => LogInScreen(),
  // Cuando se navega a la ruta "/sing-up", se muestra la pantalla de Registro
  '/sign-up': (context) => SignUpScreen(),
};