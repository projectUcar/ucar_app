import 'package:flutter/material.dart';

import 'field_types.dart';

abstract class FormFieldTemplate extends StatelessWidget{
  const FormFieldTemplate({super.key, required this.onChanged, this.validator, this.currentValue, this.focusNode, required this.fieldType, this.autovalidateMode});
  final ValueChanged<String?> onChanged;
  final FormFieldValidator<String>? validator;
  final String? currentValue;
  final FocusNode? focusNode;
  final FieldTypes fieldType;
  final AutovalidateMode? autovalidateMode;
}