import 'package:flutter/material.dart';

import '../field_types.dart';
import '../form_field_template.dart';
import '../../../theme/themes.dart';

class SelectionFormField extends FormFieldTemplate {
  final SelectionFieldTypes selectionFieldType;

  const SelectionFormField({super.key, required super.onChanged, required super.currentValue, required super.focusNode, required super.fieldType, required this.selectionFieldType, super.validator, super.autovalidateMode,});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        autovalidateMode: autovalidateMode,
        focusNode: focusNode,
        value: currentValue,
        validator: validator,
        hint: Text(fieldType.getHintText ?? 'Elige una opción', style: CustomStyles.greyStyle.copyWith(fontSize: 16)),
        menuMaxHeight: 142.0,
        dropdownColor: MyColors.secondary,
        style: CustomStyles.whiteStyle.copyWith(fontSize: 16),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        decoration: InputDecoration(
          prefixIcon: Icon(fieldType.getPrefixIcon, color: MyColors.purpleTheme,),
          labelText: fieldType.getLabelText,
          hintText: fieldType.getHintText
        ),
        icon: const Icon(Icons.arrow_drop_down_rounded, color: MyColors.textGrey, size: 35),
        items: selectionFieldType.getItems.map<DropdownMenuItem<String>>((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}