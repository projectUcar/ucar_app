library form_template;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/forms/cubits/signup_cubit.dart';
import '../../blocs/forms/cubits/login_cubit.dart';
import '../../blocs/forms/cubits/form_validator_cubit.dart';
import '../../components/form_fields/selection_fields/selection_form_field.dart';
import '../../blocs/forms/states/user_login_state.dart';
import '../../blocs/forms/states/user_signup_state.dart';
import '../../blocs/forms/states/user_state.dart';
import '../../theme/colors.dart';
import '../../theme/custom_styles.dart';
import '../../theme/fontsizes.dart';
import '../../components/form_fields/field_types.dart';
import '../../components/form_fields/text_fields/ordinary_form_field.dart';
import '../../components/form_fields/text_fields/password_form_field.dart';
part 'login_form.dart';
part 'sign_up_form.dart';

abstract class FormTemplate<T extends UserState, U extends FormValidatorCubit> extends StatefulWidget {
  const FormTemplate({super.key, required this.formKey, required this.onChanged, required this.cubit, required this.text});

  final GlobalKey<FormState> formKey;
  final ValueChanged<T> onChanged;
  final U cubit;
  final String text;

  @override
  State<FormTemplate<T, U>> createState();
}

abstract class FormTemplateState<X extends FormTemplate> extends State<X>{
  
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
    return BlocSelector<FormValidatorCubit, UserState, bool>(
      bloc: widget.cubit,
      selector: (state) => !(state.isValid()), //El widget sólo se redibujará cuando se cumpla que el estado es inválido
      builder: (context, currentlyValid) {
        return Form(
          key: widget.formKey,
          autovalidateMode: (_submitted.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
          child: ValueListenableBuilder<bool>(
            valueListenable: _submitted, 
            builder: (context, value, _) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _finalList(context).map((child) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: child,
              )).toList(),
            ),
          )
        );
      }
    );
  }

  AsyncCallback get _onSubmit;

  @mustCallSuper
  List<Widget> _finalList(BuildContext context) {
    List<Widget> list = _buildChildren(context);

    list.add(FloatingActionButton.extended(
      focusNode: buttonFocusNode,
      foregroundColor: MyColors.primary,
      backgroundColor: MyColors.orangeDark,
      onPressed: _onSubmit,
      label: Text(widget.text, style: CustomStyles.boldStyle.copyWith(fontSize: 20))
    ));
    return list;
  }

  List<Widget> _buildChildren(BuildContext context);
}