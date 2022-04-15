import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AppBarCustom extends StatelessWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  final String text;
  final Color color;

  const AppBarCustom({
    Key? key, 
    required this.text, 
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.8,
      backgroundColor: color,
      title: Text(text),
    );
  }
}