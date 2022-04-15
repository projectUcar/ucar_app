import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/colors.dart';
import '../theme/fontsizes.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final String text;
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key ? key,
    required this.onChanged, 
    this.text = "Contraseña",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: textGray,
        style: const TextStyle(color: textGray, fontSize: 17),
        decoration:  InputDecoration(
          hintText: text,
          hintStyle: const TextStyle(color: textGray,),
          icon: const Icon(
            Icons.lock,
            color: textGray,
          ),
          suffixIcon: const Icon(            
            Icons.visibility,
            color: textGray,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}