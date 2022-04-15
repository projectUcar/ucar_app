import 'package:flutter/material.dart';
import 'package:ucar_app/src/theme/colors.dart';
import '../theme/fontsizes.dart';
import 'text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    Key ? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: textGray,
        style: const TextStyle(color: textGray, fontSize: 17),
        decoration: const InputDecoration(
          //isDense: true,                      // Added this
          //contentPadding: EdgeInsets.all(10),  // Added this
          //contentPadding: EdgeInsets.only(top: 15),
          hintText: "Contraseña",
          hintStyle: TextStyle(color: textGray,),
          icon: Icon(
            Icons.lock,
            color: textGray,
          ),
          suffixIcon: Icon(            
            Icons.visibility,
            color: textGray,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}