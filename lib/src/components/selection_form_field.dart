import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../util/options/field_types.dart';
import '../theme/custom_styles.dart';

class SelectionFormField extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final ValueChanged<String?> onChanged;
  final String? currentValue;
  final FocusNode? focusNode;
  final TextFieldTypes fieldType;
  final SelectionFieldTypes selectionFieldType;
  final AutovalidateMode? autovalidateMode;

  const SelectionFormField({
    Key? key,
    required this.onChanged,
    required this.currentValue,
    required this.focusNode,
    required this.fieldType,
    required this.selectionFieldType,
    this.validator,
    this.autovalidateMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        autovalidateMode: autovalidateMode,
        focusNode: focusNode,
        value: currentValue,
        validator: validator,
        hint: Text(fieldType.getHintText ?? 'Elige una opción',
            style: CustomStyles.greyStyle.copyWith(fontSize: 16)),
        menuMaxHeight: 142.0,
        dropdownColor: MyColors.secondary,
        style: CustomStyles.whiteStyle.copyWith(fontSize: 16),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        decoration: InputDecoration(
          prefixIcon: Icon(fieldType.getPrefixIcon, color: MyColors.orangeDark,),
          labelText: fieldType.getLabelText,
          hintText: fieldType.getHintText
        ),
        icon: const Icon(
          Icons.arrow_drop_down_rounded,
          color: MyColors.textGrey,
          size: 35,
        ),
        items: selectionFieldType.getItems
            .map<DropdownMenuItem<String>>((value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}