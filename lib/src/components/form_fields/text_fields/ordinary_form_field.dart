import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/colors.dart';
import '../../../theme/custom_styles.dart';
import 'text_field_template.dart';

class OrdinaryFormField extends TextFieldTemplate {
  
  const OrdinaryFormField(
    {super.key,
    required super.onChanged,
    required super.validator,
    required super.currentValue,
    required super.focusNode,
    required super.nextFocusNode,
    required super.fieldType,
    super.maxLength,
    super.autovalidateMode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
      initialValue: currentValue,
      keyboardType: fieldType.getTextInputType,
      maxLength: maxLength,
      maxLengthEnforcement: maxLength != null ? MaxLengthEnforcement.enforced : MaxLengthEnforcement.none,
      onChanged: onChanged,
      cursorColor: MyColors.orangeDark,
      style: CustomStyles.whiteStyle,
      decoration: InputDecoration(
        hintText: fieldType.getHintText,
        labelText: fieldType.getLabelText,
        prefixIcon: Icon(
          fieldType.getPrefixIcon,
          color: MyColors.orangeDark,
        ),
      ),
      validator: validator,
    );
  }

}