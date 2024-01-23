import 'package:flutter/material.dart';
import 'package:ucar_app/src/components/form_fields/form_field_template.dart';

abstract class TextFieldTemplate extends FormFieldTemplate{
  const TextFieldTemplate({super.key, required super.onChanged, super.validator, super.currentValue, super.focusNode, this.nextFocusNode, required super.fieldType, super.autovalidateMode, this.maxLength});
  final FocusNode? nextFocusNode;
  final int? maxLength;
}