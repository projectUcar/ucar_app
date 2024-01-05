import 'package:flutter/material.dart';

abstract class FormTemplate<UserViewModel> extends StatefulWidget {
  const FormTemplate({super.key, required this.formKey, required this.onChanged, required this.viewModel});

  final GlobalKey<FormState> formKey;
  final ValueChanged<UserViewModel> onChanged;
  final UserViewModel viewModel;

}