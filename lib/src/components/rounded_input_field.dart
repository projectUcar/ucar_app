import 'package:flutter/material.dart';

import 'text_field_container.dart';
import '../theme/colors.dart';
import '../theme/custom_styles.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final double sizeFinal;
  final TextInputType textImputType;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    super.key,
    this.sizeFinal = 0.90,
    required this.hintText,
    required this.icon,
    required this.onChanged, 
     this.textImputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController(text: "");

    return TextFieldContainer(
      sizeFinal: sizeFinal,
      child: TextField(
        controller: textController,
        onChanged: onChanged,
        keyboardType: textImputType,
        cursorColor: MyColors.textGrey,
        style: CustomStyles.greyStyle.copyWith(fontSize: 16),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: MyColors.textGrey,
          ),
          hintText: hintText,
          hintStyle: CustomStyles.greyStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
