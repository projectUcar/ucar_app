import 'package:flutter/material.dart';

import '../theme/themes.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    super.key,
    this.login = true,
    required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "¿No tienes una cuenta? " : "¿Ya tienes una cuenta? ",
          style: CustomStyles.whiteStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Regístrate" : "Inicia Sesión",
            style: CustomStyles.boldStyle.copyWith(color: MyColors.textGrey, fontSize: Fontsizes.bodyTextFontSize),
          ),
        )
      ],
    );
  }
}