import 'package:flutter/material.dart';
import 'package:ucar_app/src/components/general/form_template.dart';

import '../models/vm/user_signup_view_model.dart';
import '../theme/colors.dart';
import '../theme/custom_styles.dart';
import '../util/options/field_types.dart';
import 'ordinary_form_field.dart';
import 'password_form_field.dart';
import 'selection_form_field.dart';


class SignUpForm extends FormTemplate<UserSignupViewModel>{
  const SignUpForm({super.key, required super.formKey, required super.onChanged, required super.viewModel});

  
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {

  late FocusNode nameFocusNode, phonenumberFocusNode, lastnameFocusNode, emailFocusNode, passwordFocusNode, passwordConfirmationFocusNode, genderFocusNode, careerFocusNode;

  @override
  void initState() {
    nameFocusNode = FocusNode();
    phonenumberFocusNode = FocusNode();
    lastnameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    passwordConfirmationFocusNode = FocusNode();
    genderFocusNode = FocusNode();
    careerFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    phonenumberFocusNode.dispose();
    lastnameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    passwordConfirmationFocusNode.dispose();
    genderFocusNode.dispose();
    careerFocusNode.dispose();
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
            //NOMBRES
            OrdinaryFormField(
              autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              onChanged: (s) => 
                widget.onChanged(widget.viewModel.copyWith(SignUpEnum.name, s) as UserSignupViewModel),
              validator: widget.viewModel.nameValidator,
              currentValue: widget.viewModel.userData.getName,
              focusNode: nameFocusNode,
              nextFocusNode: lastnameFocusNode,
              fieldType: TextFieldTypes.name,
            ),
            //APELLIDOS
            OrdinaryFormField(
              autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              onChanged: (s) => 
                widget.onChanged(widget.viewModel.copyWith(SignUpEnum.lastname, s) as UserSignupViewModel),
              validator: widget.viewModel.lastnameValidator,
              currentValue: widget.viewModel.userData.getLastname,
              focusNode: lastnameFocusNode,
              nextFocusNode: genderFocusNode,
              fieldType: TextFieldTypes.lastname,
            ),
            //GENERO
            SelectionFormField(
              autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              onChanged: (s) {
                widget.onChanged(widget.viewModel.copyWith(SignUpEnum.gender, s) as UserSignupViewModel);
                careerFocusNode.requestFocus();
              },
              validator: widget.viewModel.genderValidator,
              currentValue: widget.viewModel.userData.getGender,
              focusNode: genderFocusNode,
              fieldType: TextFieldTypes.genders,
              selectionFieldType: SelectionFieldTypes.genders,
            ),
            //CARRERA
            SelectionFormField(
              autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              onChanged: (s) {
                widget.onChanged(widget.viewModel.copyWith(SignUpEnum.career, s) as UserSignupViewModel);
                phonenumberFocusNode.requestFocus();
              },
              validator: widget.viewModel.careerValidator,
              currentValue: widget.viewModel.userData.getCareer,
              focusNode: careerFocusNode,
              fieldType: TextFieldTypes.careers,
              selectionFieldType: SelectionFieldTypes.careers,
            ),
            //TELEFONO
            OrdinaryFormField(
              autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              onChanged: (s) => 
                widget.onChanged(widget.viewModel.copyWith(SignUpEnum.phonenumber, s) as UserSignupViewModel),
              validator: widget.viewModel.phonenumberValidator,
              currentValue: widget.viewModel.userData.getPhonenumber,
              focusNode: phonenumberFocusNode,
              nextFocusNode: emailFocusNode,
              fieldType: TextFieldTypes.phonenumber,
              maxLength: 10,
            ),
            //EMAIL
            OrdinaryFormField(
              autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              onChanged: (s) => 
                widget.onChanged(widget.viewModel.copyWith(SignUpEnum.email, s) as UserSignupViewModel),
              validator: widget.viewModel.emailValidator,
              currentValue: widget.viewModel.userData.getEmail,
              focusNode: emailFocusNode,
              nextFocusNode: passwordFocusNode,
              fieldType: TextFieldTypes.email,
            ),
            //CONTRASEÑA
            PasswordFormField(
              autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
              focusNode: passwordFocusNode,
              nextFocusNode: passwordConfirmationFocusNode,
              onChanged: (s) => 
                widget.onChanged(widget.viewModel.copyWith(SignUpEnum.password, s) as UserSignupViewModel),
              currentValue: widget.viewModel.userData.getPassword,
              fieldType: TextFieldTypes.password,
              validator: widget.viewModel.passwordValidator,
            ),
            //CONFIRMACION DE CONTRASEÑA
            PasswordFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              focusNode: passwordConfirmationFocusNode,
              nextFocusNode: null,
              onChanged: (s) => 
                widget.onChanged(widget.viewModel.copyWith(SignUpEnum.passwordConfirmation, s) as UserSignupViewModel),
              currentValue: widget.viewModel.userData.getPasswordConfirmation,
              fieldType: TextFieldTypes.confirmation,
              validator: widget.viewModel.passwordConfirmationValidator,
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
              label: Text('Registrar', style: CustomStyles.boldStyle.copyWith(fontSize: 20))
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