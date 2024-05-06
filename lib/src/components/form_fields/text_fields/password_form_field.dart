import 'package:flutter/material.dart';

import 'text_field_template.dart';
import '../../../theme/themes.dart';

class PasswordFormField extends TextFieldTemplate{
  const PasswordFormField({
    super.key,
    required super.onChanged,
    required super.fieldType,
    super.readOnly = false,
    super.currentValue,
    super.validator,
    super.autovalidateMode,
    super.focusNode,
    super.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    bool pv = true;
    return StatefulBuilder(
      builder: (context, refresh) => TextFormField(
        readOnly: readOnly,
        autovalidateMode: autovalidateMode,
        keyboardType: TextInputType.visiblePassword,
        focusNode: focusNode,
        onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
        obscureText: pv,
        cursorColor: MyColors.purpleTheme,
        validator: validator,
        onChanged: onChanged,
        style: CustomStyles.whiteStyle,
        decoration: InputDecoration(
          labelText: fieldType.getLabelText,
          hintText: fieldType.getHintText,
          prefixIcon: Icon(
            fieldType.getPrefixIcon,
            color: MyColors.purpleTheme,
          ),
          suffixIcon: GestureDetector(
            onTap: () => refresh(() => pv = !pv),
            child: !pv ? const Icon(Icons.visibility): const Icon(Icons.visibility_off),
          )
        ),
      ),
    );
  }
}