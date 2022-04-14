import 'package:flutter/material.dart';
import 'package:ucar_app/src/screens/welcome.dart';
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
      theme: ThemeData(
        primaryColor: textWhite,
      ),
      home: const Scaffold(
        backgroundColor: primary,
        body: Welcome()
        ),
    );
  }
}
