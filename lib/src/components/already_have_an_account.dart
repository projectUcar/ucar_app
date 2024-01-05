import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/custom_styles.dart';
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