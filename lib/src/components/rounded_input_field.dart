import 'package:flutter/material.dart';
import 'package:ucar_app/src/components/text_field_container.dart';
import 'package:ucar_app/src/theme/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final double sizeFinal;
  final TextInputType textImputType;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key ? key,
    this.sizeFinal = 0.90,
    required this.hintText,
    required this.icon,
    required this.onChanged, 
     this.textImputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController(text: "");

    return TextFieldContainer(
      sizeFinal: sizeFinal,
      child: TextField(
        controller: _textController,
        onChanged: onChanged,
        keyboardType: textImputType,
        cursorColor: textGray,
        style: const TextStyle(color: textGray, fontSize: 16),
        decoration: InputDecoration(
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
