import 'package:flutter/material.dart';
import 'package:ucar_app/src/components/text_field_container.dart';
import 'package:ucar_app/src/theme/colors.dart';
import 'package:ucar_app/src/theme/fontsizes.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key ? key,
    required this.hintText,
    required this.icon,
     required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
       return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor: textGray,
        style: const TextStyle(color: textGray, fontSize: 16),
        decoration: InputDecoration(
          // isDense: true,                      // Added this
          // contentPadding: EdgeInsets.all(8),  // Added this
          icon: Icon(
            icon,
            color: textGray,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: textGray, ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
