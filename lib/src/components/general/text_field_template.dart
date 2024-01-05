import 'package:flutter/material.dart';

import '../../util/options/field_types.dart';

abstract class TextFieldTemplate extends StatelessWidget{
  const TextFieldTemplate({super.key, required this.onChanged, this.validator, this.currentValue, this.focusNode, this.nextFocusNode, required this.fieldType, this.autovalidateMode, this.maxLength});
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String>? validator;
  final String? currentValue;
  final FocusNode? focusNode, nextFocusNode;
  final TextFieldTypes fieldType;
  final AutovalidateMode? autovalidateMode;
  final int? maxLength;
  
}