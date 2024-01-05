import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/custom_styles.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color;

  const RoundedButton({
    Key ? key,
    required this.text,
    required this.press,
    this.color = MyColors.orangeDark,
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
        style: CustomStyles.boldStyle.copyWith(fontSize: 20, color: MyColors.textWhite),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: CustomStyles.whiteStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500)
      ),
    );
  }
}