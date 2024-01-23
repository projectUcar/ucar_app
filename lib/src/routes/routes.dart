import 'package:flutter/material.dart';

import '../screens/forms/form_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  // Cuando se navega a la ruta "/" se muestra la pantalla de Iniciar Sesión
  '/': (context) => LogInScreen(),
  // Cuando se navega a la ruta "/sing-up", se muestra la pantalla de Registro
  '/sign-up': (context) => SignUpScreen(),
};