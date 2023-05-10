import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/colors.dart';

import '../theme/fontsizes.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    Key ? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "¿No tienes una cuenta? " : "¿Ya tienes una cuenta? ",
          style: const TextStyle(color: textWhite, fontSize: bodyTextFontSize),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Regístrate" : "Inicia Sesión",
            style: const TextStyle(
              fontSize: bodyTextFontSize,
              color: textOrange,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}