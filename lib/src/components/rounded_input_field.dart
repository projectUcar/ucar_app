import 'package:flutter/material.dart';
import 'package:ucar_app/src/components/text_field_container.dart';
import 'package:ucar_app/src/theme/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final double sizeFinal;
  final double fontSize;
  final double height;
  final TextInputType textImputType;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    Key ? key,
    this.sizeFinal = 0.90,
    this.height = 55,
    this.fontSize = 16,
    required this.hintText,
    required this.icon,
    required this.onChanged, 
     this.textImputType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _textController = TextEditingController(text: "");

    return TextFieldContainer(
      height: height,
      sizeFinal: sizeFinal,
      child: TextField(
        controller: _textController,
        onChanged: onChanged,
        keyboardType: textImputType,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: textGray,
        style: TextStyle(color: textGray, fontSize: fontSize),
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
