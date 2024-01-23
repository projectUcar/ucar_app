library form_template;

import 'package:flutter/material.dart';

import '../../components/form_fields/selection_fields/selection_form_field.dart';
import '../../models/vm/user_login_view_model.dart';
import '../../models/vm/user_signup_view_model.dart';
import '../../theme/colors.dart';
import '../../theme/custom_styles.dart';
import '../../theme/fontsizes.dart';
import '../../components/form_fields/field_types.dart';
import '../../components/form_fields/text_fields/ordinary_form_field.dart';
import '../../components/form_fields/text_fields/password_form_field.dart';
part 'login_form.dart';
part 'sign_up_form.dart';

abstract class FormTemplate<UserViewModel> extends StatefulWidget {
  const FormTemplate({super.key, required this.formKey, required this.onChanged, required this.viewModel, required this.text});

  final GlobalKey<FormState> formKey;
  final ValueChanged<UserViewModel> onChanged;
  final UserViewModel viewModel;
  final String text;

  @override
  State<FormTemplate> createState();

}

abstract class FormTemplateState<T extends FormTemplate> extends State<T>{
  
  late FocusNode buttonFocusNode;
  final ValueNotifier<bool> _submitted = ValueNotifier<bool>(false);

  @override
  void initState() {
    buttonFocusNode = FocusNode();
    super.initState();
  }
  
  @mustCallSuper
  @override
  Widget build(BuildContext context) {

    return Form(
      key: widget.formKey,
      child: ValueListenableBuilder<bool>(
        valueListenable: _submitted, 
        builder: (context, value, _) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _finalList().map((child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: child,
          )).toList(),
        ),
      )
    );
  }

  VoidCallback get _onSubmit;

  @mustCallSuper
  List<Widget> _finalList() {
    List<Widget> list = _buildChildren();

    list.add(FloatingActionButton.extended(
      focusNode: buttonFocusNode,
      foregroundColor: MyColors.primary,
      backgroundColor: MyColors.orangeDark,
      onPressed: _onSubmit,
      label: Text(widget.text, style: CustomStyles.boldStyle.copyWith(fontSize: 20))
    ));
    return list;
  }

  List<Widget> _buildChildren();
}