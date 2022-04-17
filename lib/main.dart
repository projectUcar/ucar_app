import 'package:flutter/material.dart';
import 'package:ucar_app/src/screens/login.dart';
import 'package:ucar_app/src/screens/sing_up.dart';
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
        // Cuando se navega a la ruta "/" se muestra la pantalla de Iniciar Sesión
        '/': (context) => const LoginScreen(),
        // Cuando se navega a la ruta "/sing-up", se muestra la pantalla de Registro
        '/sing-up': (context) => const SingUp(),
      },
    );
  }
}
