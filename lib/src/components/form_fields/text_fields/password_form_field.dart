import 'package:flutter/material.dart';
import 'package:ucar_app/src/components/form_fields/text_fields/text_field_template.dart';

import '../../../theme/colors.dart';
import '../../../theme/custom_styles.dart';

class PasswordFormField extends TextFieldTemplate{
  const PasswordFormField({
    super.key,
    required super.onChanged,
    required super.fieldType,
    super.currentValue,
    super.validator,
    super.autovalidateMode,
    super.focusNode,
    super.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    bool _pv = true;
    return StatefulBuilder(
      builder: (context, refresh) => TextFormField(
        autovalidateMode: autovalidateMode,
        keyboardType: TextInputType.visiblePassword,
        focusNode: focusNode,
        onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
        obscureText: _pv,
        cursorColor: MyColors.orangeDark,
        validator: validator,
        onChanged: onChanged,
        style: CustomStyles.whiteStyle,
        decoration: InputDecoration(
          labelText: fieldType.getLabelText,
          hintText: fieldType.getHintText,
          prefixIcon: Icon(
            fieldType.getPrefixIcon,
            color: MyColors.orangeDark,
          ),
          suffixIcon: GestureDetector(
            onTap: () => refresh(() => _pv = !_pv),
            child: !_pv ? const Icon(Icons.visibility): const Icon(Icons.visibility_off),
          )
        ),
      ),
    );
  }
}