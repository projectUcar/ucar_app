import 'package:flutter/material.dart';

import 'colors.dart';
import 'my_input_theme.dart';

class MyThemes {
  static ThemeData defaultTheme = ThemeData(
    useMaterial3: true,
    primaryColor: MyColors.textWhite,
    inputDecorationTheme: MyInputTheme().theme(),
    scaffoldBackgroundColor: MyColors.primary,
    dividerColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(
        color: MyColors.purpleTheme
      ),
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      backgroundColor: MyColors.backgroundSvg
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: MyColors.backgroundSvg,
      selectedIconTheme: IconThemeData(color: MyColors.textWhite),
      unselectedIconTheme: IconThemeData(color: MyColors.purpleTheme),
      selectedItemColor: MyColors.textWhite,
      unselectedItemColor: MyColors.purpleTheme
    )
  );
}