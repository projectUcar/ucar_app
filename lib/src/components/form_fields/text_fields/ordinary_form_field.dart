import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../theme/themes.dart';
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
    super.readOnly = false,
    super.maxLength,
    super.autovalidateMode,
    super.textCapitalization,
    super.enabled,
    this.onTap
  });

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      onFieldSubmitted: (_) => nextFocusNode?.requestFocus(),
      initialValue: currentValue,
      keyboardType: fieldType.getTextInputType,
      maxLength: maxLength,
      maxLengthEnforcement: maxLength != null ? MaxLengthEnforcement.enforced : MaxLengthEnforcement.none,
      onChanged: onChanged,
      cursorColor: MyColors.purpleTheme,
      style: CustomStyles.whiteStyle,
      decoration: InputDecoration(
        hintText: fieldType.getHintText,
        labelText: fieldType.getLabelText,
        prefixIcon: Icon(
          fieldType.getPrefixIcon,
          color: MyColors.purpleTheme,
        ),
      ),
      validator: validator,
    );
  }

}