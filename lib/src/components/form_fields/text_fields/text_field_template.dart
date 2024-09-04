import 'package:flutter/material.dart';
import '../form_field_template.dart';

abstract class TextFieldTemplate extends FormFieldTemplate{
  const TextFieldTemplate({super.key, required super.onChanged, super.validator, super.currentValue, super.focusNode, this.nextFocusNode, required super.fieldType, required this.readOnly, super.autovalidateMode, this.maxLength, this.textCapitalization, this.enabled, this.maxLines});
  final FocusNode? nextFocusNode;
  final int? maxLength, maxLines;
  final bool readOnly;
  final bool? enabled;
  final TextCapitalization? textCapitalization;
}