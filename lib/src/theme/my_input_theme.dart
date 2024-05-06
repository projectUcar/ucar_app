import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/colors.dart';

class MyInputTheme {
  TextStyle _buildTextStyle(Color color, {double size = 16.0}) {
    return TextStyle(color: color, fontSize: size);
  }

  OutlineInputBorder _buildBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(color: color, width:  1.0)
    );
  }

  InputDecorationTheme theme() => InputDecorationTheme(
    contentPadding: const EdgeInsets.all(10),
    isDense: true,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    constraints: const BoxConstraints(maxWidth: 150),

    // Bordes
    enabledBorder: _buildBorder(Colors.grey[600]!),
    errorBorder: _buildBorder(Colors.red),
    focusedErrorBorder: _buildBorder(const Color.fromARGB(255, 223, 15, 0)),
    focusedBorder: _buildBorder(MyColors.purpleTheme),
    disabledBorder: _buildBorder(MyColors.textGrey),

    // Estilos de texto
    suffixStyle: _buildTextStyle(MyColors.textGrey),
    counterStyle: _buildTextStyle(MyColors.textGrey, size: 12.0),
    floatingLabelStyle: _buildTextStyle(MyColors.textGrey),
    errorStyle: _buildTextStyle(Colors.red, size: 12.0),
    hintStyle: _buildTextStyle(MyColors.textGrey),
    labelStyle: _buildTextStyle(MyColors.purpleTheme),
  );
}