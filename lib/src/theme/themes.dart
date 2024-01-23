import 'package:flutter/material.dart';

import 'colors.dart';
import 'my_input_theme.dart';

class MyThemes {
  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    primaryColor: MyColors.textWhite,
    inputDecorationTheme: MyInputTheme().theme(),
    scaffoldBackgroundColor: MyColors.primary,
    // textTheme: const TextTheme(
    //   displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    //   displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    //   displaySmall: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    //   headlineLarge: TextStyle(fontSize: 24),
    //   headlineMedium: TextStyle(fontSize: 20),
    //   headlineSmall: TextStyle(fontSize: 16),
    //   bodyLarge: TextStyle(fontSize: 14),
    //   bodyMedium: TextStyle(fontSize: 13),
    //   bodySmall: TextStyle(fontSize: 10),
    // )
  );
}
