import 'package:flutter/material.dart';

import 'general/form_template.dart';
import '../models/vm/user_login_view_model.dart';
import '../theme/colors.dart';
import '../theme/custom_styles.dart';
import '../theme/fontsizes.dart';
import '../util/options/field_types.dart';
import 'ordinary_form_field.dart';
import 'password_form_field.dart';

class LogInForm extends FormTemplate<UserLoginViewModel> {
  const LogInForm({super.key, required super.formKey, required super.onChanged, required super.viewModel});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  late FocusNode emailFocusNode, passwordFocusNode;

  @override
  void initState() {
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  final ValueNotifier<bool> _submitted = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ValueListenableBuilder<bool>(
        valueListenable: _submitted, 
        builder: (context, value, _) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //EMAIL O TELEFONO
            OrdinaryFormField(
              autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              onChanged: (s) => 
                widget.onChanged(widget.viewModel.copyWith(LogInEnum.emailOrPhonenumber, s) as UserLoginViewModel),
              validator: widget.viewModel.emailValidator,
              currentValue: widget.viewModel.userData.getEmailOrPhonenumber,
              focusNode: emailFocusNode,
              nextFocusNode: passwordFocusNode,
              fieldType: TextFieldTypes.email,
            ),
            //CONTRASEÑA
            PasswordFormField(
              autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              focusNode: passwordFocusNode,
              nextFocusNode: null,
              onChanged: (s) => 
                widget.onChanged(widget.viewModel.copyWith(LogInEnum.password, s) as UserLoginViewModel),
              currentValue: widget.viewModel.userData.getPassword,
              fieldType: TextFieldTypes.loginPassword,
              validator: widget.viewModel.passwordValidator,
            ),
            Container(
              alignment: Alignment.topRight,
              child: Text("¿Olvidaste tu contraseña?",
                style: CustomStyles.greyStyle.copyWith(fontSize: Fontsizes.bodyTextFontSize)),
            ),
            FloatingActionButton.extended(
              foregroundColor: MyColors.primary,
              backgroundColor: MyColors.orangeDark,
              onPressed: () {
                _submitted.value = true;
                if (widget.formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              label: Text('Entrar', style: CustomStyles.boldStyle.copyWith(fontSize: 20))
            ),
          ].map((child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: child,
          )).toList(),
        ),
      )
    );
  }
}
