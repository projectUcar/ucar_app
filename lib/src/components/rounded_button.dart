import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/colors.dart';
import 'package:ucar_app/src/theme/fontsizes.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback  press;
  final Color color;

  const RoundedButton({
    Key ? key,
    required this.text,
    required this.press,
    this.color = orangeDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: const TextStyle(color: textWhite, fontSize: subTitleFontSize, fontWeight: FontWeight.bold),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: const TextStyle(
              color: textWhite, fontSize: 14, fontWeight: FontWeight.w500)),
    );
  }
}